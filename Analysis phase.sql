-- ANALYSIS PHASE--

--making custom column duration_minutes

SELECT
*,
DATEDIFF(MINUTE, started_at, ended_at) AS duration_minutes
FROM Cycle_data;

ALTER TABLE Cycle_data
ADD duration_minutes INT;--Commands completed successfully.

UPDATE Cycle_data
SET duration_minutes = DATEDIFF(MINUTE, started_at, ended_at);
--(4058498 rows affected)

==========================================================================================================================
-- 1. Rider Category Breakdown (%)
==========================================================================================================================
SELECT
	rider_category,
	COUNT(ride_id) AS no_of_riders,
	FORMAT(COUNT(ride_id)*100.0/(SELECT COUNT(*) FROM Cycle_data),'N3')+ ' %' AS percentage_riders
FROM Cycle_data
GROUP BY rider_category;

==========================================================================================================================
-- 2. Ride Duration Statistics by rider_category
==========================================================================================================================
SELECT DISTINCT
    rider_category,
    COUNT(ride_id) OVER (PARTITION BY rider_category) AS no_of_riders,
    ROUND(AVG(CAST(duration_minutes AS FLOAT)) OVER (PARTITION BY rider_category), 2) AS avg_duration_min,
    ROUND(STDEV(CAST(duration_minutes AS FLOAT)) OVER (PARTITION BY rider_category), 2) AS stddev_duration_min,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY duration_minutes)
        OVER (PARTITION BY rider_category) AS lower_quartile_min,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY duration_minutes)
        OVER (PARTITION BY rider_category) AS median_duration_min,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY duration_minutes)
        OVER (PARTITION BY rider_category) AS upper_quartile_min
FROM Cycle_data;
/*measures that describe how long rides typically last,
how spread out they are, and where most values fall*/

==========================================================================================================================
-- 3. No.of riders for each RiderCategory broken down by Hours of the day
==========================================================================================================================
WITH starts AS (
    SELECT
        DATEPART(HOUR, started_at) AS hr,
        COUNT(CASE WHEN rider_category = 'member' THEN ride_id END) AS member_starts,
        COUNT(CASE WHEN rider_category = 'casual' THEN ride_id END) AS casual_starts,
        COUNT(ride_id) AS total_starts
    FROM Cycle_data
    GROUP BY DATEPART(HOUR, started_at)
),
ends AS (
    SELECT
        DATEPART(HOUR, ended_at) AS hr,
        COUNT(CASE WHEN rider_category = 'member' THEN ride_id END) AS member_ends,
        COUNT(CASE WHEN rider_category = 'casual' THEN ride_id END) AS casual_ends,
        COUNT(ride_id) AS total_ends
    FROM Cycle_data
    GROUP BY DATEPART(HOUR, ended_at)
)
SELECT
    ISNULL(s.hr, e.hr) AS hour_of_day,
    -- departures
    ISNULL(s.member_starts, 0) AS member_starts,
    ISNULL(s.casual_starts, 0) AS casual_starts,
    ISNULL(s.total_starts, 0)  AS total_starts,
    FORMAT(100.0 * s.total_starts / SUM(s.total_starts) OVER (), 'N2') AS pct_of_daily_starts,
    --shows how much of total demand falls in each hour

    -- arrivals
    ISNULL(e.member_ends, 0) AS member_ends,
    ISNULL(e.casual_ends, 0) AS casual_ends,
    ISNULL(e.total_ends, 0)  AS total_ends,
    ISNULL(e.total_ends, 0) - ISNULL(s.total_starts, 0) AS net_bike_flow
    -- Positive means more bikes came in than left, and negative means the station lost bikes.
FROM starts s
FULL OUTER JOIN ends e ON s.hr = e.hr
ORDER BY hour_of_day;

==========================================================================================================================
-- 4. No. of rides for each RiderCategory broken down by weekdays
==========================================================================================================================
WITH starts AS (
    SELECT
        DATEDIFF(DAY, '19000101', started_at) % 7 + 1 AS day_no,   -- 1 = Monday ... 7 = Sunday
        DATENAME(WEEKDAY, started_at) AS day_name,
        COUNT(CASE WHEN rider_category = 'member' THEN ride_id END) AS member_starts,
        COUNT(CASE WHEN rider_category = 'casual' THEN ride_id END) AS casual_starts,
        COUNT(ride_id) AS total_starts
    FROM Cycle_data
    GROUP BY DATEDIFF(DAY, '19000101', started_at) % 7 + 1,
             DATENAME(WEEKDAY, started_at)
),
ends AS (
    SELECT
        DATEDIFF(DAY, '19000101', ended_at) % 7 + 1 AS day_no,
        DATENAME(WEEKDAY, ended_at) AS day_name,
        COUNT(CASE WHEN rider_category = 'member' THEN ride_id END) AS member_ends,
        COUNT(CASE WHEN rider_category = 'casual' THEN ride_id END) AS casual_ends,
        COUNT(ride_id) AS total_ends
    FROM Cycle_data
    GROUP BY DATEDIFF(DAY, '19000101', ended_at) % 7 + 1,
             DATENAME(WEEKDAY, ended_at)
)
SELECT
    ISNULL(s.day_no, e.day_no)     AS day_no,
    ISNULL(s.day_name, e.day_name) AS day_name,
    -- departures
    ISNULL(s.member_starts, 0) AS member_starts,
    ISNULL(s.casual_starts, 0) AS casual_starts,
    ISNULL(s.total_starts, 0)  AS total_starts,
    FORMAT(100.0 * s.total_starts / SUM(s.total_starts) OVER (), 'N2') AS pct_of_total_starts,
    FORMAT(100.0 * s.casual_starts / NULLIF(s.total_starts, 0), 'N2')  AS pct_casual_starts,
    FORMAT(100.0 * s.member_starts / NULLIF(s.total_starts, 0), 'N2') AS pct_member_starts,
    -- arrivals
    ISNULL(e.member_ends, 0) AS member_ends,
    ISNULL(e.casual_ends, 0) AS casual_ends,
    ISNULL(e.total_ends, 0)  AS total_ends,
    ISNULL(e.total_ends, 0) - ISNULL(s.total_starts, 0) AS net_bike_flow
    -- positive = more bikes arriving than leaving that day
FROM starts s
FULL OUTER JOIN ends e ON s.day_no = e.day_no
ORDER BY day_no;

==========================================================================================================================
-- 5. No. of rides for each RiderCategory broken down by Months
==========================================================================================================================

WITH starts AS (
    SELECT
        MONTH(started_at) AS month_no,
        COUNT(CASE WHEN rider_category = 'member' THEN ride_id END) AS member_starts,
        COUNT(CASE WHEN rider_category = 'casual' THEN ride_id END) AS casual_starts,
        COUNT(ride_id) AS total_starts
    FROM Cycle_data
    GROUP BY MONTH(started_at)
),
ends AS (
    SELECT
        MONTH(ended_at) AS month_no,
        COUNT(CASE WHEN rider_category = 'member' THEN ride_id END) AS member_ends,
        COUNT(CASE WHEN rider_category = 'casual' THEN ride_id END) AS casual_ends,
        COUNT(ride_id) AS total_ends
    FROM Cycle_data
    GROUP BY MONTH(ended_at)
)
SELECT
    ISNULL(s.month_no, e.month_no) AS month_no,
    DATENAME(MONTH, DATEFROMPARTS(2000, ISNULL(s.month_no, e.month_no), 1)) AS month_name,
    -- departures
    ISNULL(s.member_starts, 0) AS member_starts,
    ISNULL(s.casual_starts, 0) AS casual_starts,
    ISNULL(s.total_starts, 0)  AS total_starts,
    FORMAT(100.0 * s.total_starts / SUM(s.total_starts) OVER (), 'N2') AS pct_of_total_starts,
    FORMAT(100.0 * s.casual_starts / NULLIF(s.total_starts, 0), 'N2')  AS pct_casual_starts,
    FORMAT(100.0 * s.member_starts / NULLIF(s.total_starts, 0), 'N2') AS pct_member_starts,
    FORMAT(100.0 * s.total_starts / AVG(1.0 * s.total_starts) OVER (), 'N0') AS seasonality_index,
    -- 100 = an average month, 130 = 30% busier than average, 70 = 30% quieter

    -- arrivals
    ISNULL(e.member_ends, 0) AS member_ends,
    ISNULL(e.casual_ends, 0) AS casual_ends,
    ISNULL(e.total_ends, 0)  AS total_ends
FROM starts s
FULL OUTER JOIN ends e ON s.month_no = e.month_no
ORDER BY month_no;

==========================================================================================================================
-- 6. No. of rides for each RiderCategory broken down by Rideabletype
==========================================================================================================================

SELECT *
FROM(
    SELECT rideable_type, rider_category,ride_id
    FROM Cycle_data
    ) AS source_table
    PIVOT(
        COUNT(ride_id)
        FOR rideable_type IN ([classic_bike], [electric_bike])
    ) AS pivot_table
ORDER BY rider_category;

==========================================================================================================================
-- 7. Top 10 start stations, separately for RidersCategory
==========================================================================================================================
WITH station_counts AS (
    SELECT
        rider_category,
        start_station_name,
        COUNT(ride_id) AS no_of_riders
    FROM Cycle_data
    WHERE start_station_name IS NOT NULL
    GROUP BY rider_category, start_station_name
),
ranked AS (
    SELECT
        rider_category,
        start_station_name,
        no_of_riders,
        ROW_NUMBER() OVER (PARTITION BY rider_category ORDER BY no_of_riders DESC) AS rank_no,
        FORMAT(100.0 * no_of_riders / SUM(no_of_riders) OVER (PARTITION BY rider_category), 'N2') AS pct_of_group_rides
    FROM station_counts
)
SELECT rider_category, rank_no, start_station_name, no_of_riders, pct_of_group_rides
FROM ranked
WHERE rank_no <= 10
ORDER BY rider_category, rank_no;

==========================================================================================================================
-- 8. Station profile: starts, ends, balance, and casual share
==========================================================================================================================
WITH s AS (
    SELECT
        start_station_name AS station,
        COUNT(ride_id) AS starts,
        COUNT(CASE WHEN rider_category = 'casual' THEN ride_id END) AS casual_starts
    FROM Cycle_data
    WHERE start_station_name IS NOT NULL
    GROUP BY start_station_name
),
e AS (
    SELECT
        end_station_name AS station,
        COUNT(ride_id) AS ends
    FROM Cycle_data
    WHERE end_station_name IS NOT NULL
    GROUP BY end_station_name
)
SELECT TOP 20
    ISNULL(s.station, e.station)                       AS station,
    ISNULL(s.starts, 0)                                AS starts,
    ISNULL(e.ends, 0)                                  AS ends,
    ISNULL(s.starts, 0) + ISNULL(e.ends, 0)            AS total_activity,
    ISNULL(e.ends, 0) - ISNULL(s.starts, 0)            AS net_bike_flow,
    -- A large negative value means the station keeps running out of bikes and needs restocking,
    --and a large positive value means it fills up and needs bikes removed.
    FORMAT(100.0 * s.casual_starts / NULLIF(s.starts, 0), 'N2') AS pct_casual_starts
    --A high pct_casual_starts at a busy station means many casual riders pass through there
FROM s
FULL OUTER JOIN e ON s.station = e.station
ORDER BY total_activity DESC;
CREATE DATABASE Cyclistic_bike;

--Prepare Phase--

SELECT
ride_id,
rideable_type,
started_at,
ended_at,
start_station_name,
end_station_name,
member_casual
FROM dbo.[202509]
UNION ALL

SELECT
ride_id,
rideable_type,
started_at,
ended_at,
start_station_name,
end_station_name,
member_casual
FROM dbo.[202510]
UNION ALL

SELECT
ride_id,
rideable_type,
started_at,
ended_at,
start_station_name,
end_station_name,
member_casual
FROM dbo.[202511]
UNION ALL

SELECT
ride_id,
rideable_type,
started_at,
ended_at,
start_station_name,
end_station_name,
member_casual
FROM dbo.[202512]
UNION ALL

SELECT
ride_id,
rideable_type,
started_at,
ended_at,
start_station_name,
end_station_name,
member_casual
FROM dbo.[202601]
UNION ALL

SELECT
ride_id,
rideable_type,
started_at,
ended_at,
start_station_name,
end_station_name,
member_casual
FROM dbo.[202602]
UNION ALL

SELECT
ride_id,
rideable_type,
started_at,
ended_at,
start_station_name,
end_station_name,
member_casual
FROM dbo.[202603]
UNION ALL

SELECT
ride_id,
rideable_type,
started_at,
ended_at,
start_station_name,
end_station_name,
member_casual
FROM dbo.[202604]
UNION ALL

SELECT
ride_id,
rideable_type,
started_at,
ended_at,
start_station_name,
end_station_name,
member_casual
FROM dbo.[202605]
UNION ALL

SELECT
ride_id,
rideable_type,
started_at,
ended_at,
start_station_name,
end_station_name,
member_casual
FROM dbo.[202606]
UNION ALL

SELECT
ride_id,
rideable_type,
started_at,
ended_at,
start_station_name,
end_station_name,
member_casual
FROM dbo.[202607]
UNION ALL

SELECT
ride_id,
rideable_type,
started_at,
ended_at,
start_station_name,
end_station_name,
member_casual
FROM dbo.[202608];








--Process Phase--

--Duplicating the table
SELECT * 
INTO Cycle_data
FROM Cyclistic_data;

SELECT count(*) 
FROM Cycle_data;--6115982

-- Identify and Removing NULL Values--
SELECT *
FROM dbo.Cycle_data
WHERE ride_id IS NULL
OR rideable_type IS NULL
OR started_at IS NULL
OR ended_at IS NULL
OR start_station_name IS NULL
OR end_station_name IS NULL
OR member_casual IS NULL;

SELECT TOP 20
    start_station_name,
    LEN(start_station_name)        AS len_chars,
    DATALENGTH(start_station_name) AS len_bytes
FROM cycle_data
WHERE start_station_name IS NULL
   OR LTRIM(RTRIM(start_station_name)) = ''
   OR UPPER(LTRIM(RTRIM(start_station_name))) = 'NULL';
--A len_bytes of 0 means an empty string, and 4 means the text 'NULL'

SELECT COUNT(*) AS rows_to_delete
FROM cycle_data
WHERE UPPER(LTRIM(RTRIM(start_station_name))) = 'NULL';
--1285406

BEGIN TRAN;

DELETE FROM cycle_data
WHERE UPPER(LTRIM(RTRIM(start_station_name))) = 'NULL';
--(1285406 rows affected)

SELECT @@ROWCOUNT AS rows_deleted;--1285406
-- returns the number of rows affected by the last statement executed

COMMIT;--Commands completed successfully.

SELECT COUNT(*) 
FROM cycle_data
WHERE UPPER(LTRIM(RTRIM(start_station_name))) = 'NULL';--0

DELETE FROM cycle_data
WHERE UPPER(LTRIM(RTRIM(end_station_name)))   = 'NULL'
--(772058 rows affected)


-- Identifying and removing duplicates

SELECT
ride_id, COUNT(*)
FROM Cycle_data
GROUP BY ride_id
HAVING COUNT(ride_id)>1;

WITH CTE AS (
SELECT *,
ROW_NUMBER() OVER (PARTITION BY ride_id ORDER BY ride_id) AS row_num
FROM Cycle_data
)
SELECT * FROM CTE 
WHERE  row_num >1;
--found 20 rows
SELECT * FROM Cycle_data
WHERE ride_id = 'EAB7C279D822C763'

--deleting duplicates

WITH CTE AS (
SELECT *,
ROW_NUMBER() OVER(PARTITION BY ride_id ORDER BY ride_id) AS row_num
FROM Cycle_data
)
DELETE FROM CTE
WHERE row_num = 2;--(20 rows affected)

--Correction of Headers
EXEC sp_rename'Cycle_data.member_casual','rider_category','COLUMN';

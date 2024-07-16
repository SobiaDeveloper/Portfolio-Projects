-- checking the data types of all columns

SELECT column_name, data_type
FROM "cyclistics".INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'cyclistic_users';


-- total count of data == 1564222
select count(ride_id) from cyclistics.dbo.cyclistic_users as cu;



-- look for data to better understand columns
select * from cyclistics.dbo.cyclistic_users as cu;

--check for bike rider members: classic_bike= 790112; electric; hence no null value in this column
select rideable_type, count(rideable_type) as total_rider_types
from cyclistics.dbo.cyclistic_users as cu
group by rideable_type;




-- check for bike types; member=1028523; casual= 535699; no null values 
select member_casual, count(member_casual) as types_of_members
from cyclistics.dbo.cyclistic_users as cu
group by member_casual;

-- calculate nulll values in columns
select Count (CASE WHEN ride_id is null then 1 end) as ride_id ,
       COUNT(CASE WHEN rideable_type is null then 1 end) as rideable_type ,
       COUNT(CASE WHEN started_at is null then 1 end) as started_at ,
	   Count (CASE WHEN ended_at is null then 1 end) as ended_at ,
       COUNT(CASE WHEN start_station_name is null then 1 end) as start_station_name ,
       COUNT(CASE WHEN end_station_name is null then 1 end) as end_station_name ,
	   Count (CASE WHEN start_lat is null then 1 end) as start_lat ,
       COUNT(CASE WHEN start_lng is null then 1 end) as start_lng ,
       COUNT(CASE WHEN end_lat is null then 1 end) as started_at ,
	    COUNT(CASE WHEN end_lng is null then 1 end) as end_lng ,
       COUNT(CASE WHEN member_casual is null then 1 end) as member_casual 
from cyclistics.dbo.cyclistic_users as cu;


-- calculate empty string or empty value; start_station_name = 240727; end_station_name = 252663
select Count (CASE WHEN ride_id = '' then 1 end) as ride_id ,
       COUNT(CASE WHEN rideable_type = '' then 1 end) as rideable_type ,
       COUNT(CASE WHEN started_at = '' then 1 end) as started_at ,
	   Count (CASE WHEN ended_at = '' then 1 end) as ended_at ,
       COUNT(CASE WHEN start_station_name = '' then 1 end) as start_station_name ,
       COUNT(CASE WHEN end_station_name = '' then 1 end) as end_station_name ,
	   Count (CASE WHEN start_lat = '' then 1 end) as start_lat ,
       COUNT(CASE WHEN start_lng = '' then 1 end) as start_lng ,
       COUNT(CASE WHEN end_lat = '' then 1 end) as started_at ,
	    COUNT(CASE WHEN end_lng = '' then 1 end) as end_lng ,
       COUNT(CASE WHEN member_casual = '' then 1 end) as member_casual 
from cyclistics.dbo.cyclistic_users as cu

-- 240727+252663 = 493390; total =1564222, 31% of my data is null so not good to remove

-- check for duplicates; total= 1564222
select count (*)
from (select distinct * from cyclistics.dbo.cyclistic_users as cu)  as dublicate_count;

-- select all data to look for columns and their means plus their datatypes
select * 
from cyclistics.dbo.cyclistic_users;

-- total count of data == 1564222
select count(ride_id) from dbo.cyclistic_users;
select * from dbo.cyclistic_users;

--- distinct ride_id to see if there any duplication in ride_id= 1564130
select count (*)
from (select distinct ride_id from cyclistics.dbo.cyclistic_users as cu)  as dublicate_rideid;

-- deleting start_staion_id 
Alter table cyclistics.dbo.cyclistic_users
drop column start_station_id
-- and end_station_id column 
Alter table cyclistics.dbo.cyclistic_users
drop column end_station_id

-- deleting start_lat ,start_lng,end_lat,end_lng
Alter table cyclistics.dbo.cyclistic_users
drop column start_lat,start_lng,end_lat,end_lng


select * from cyclistics.dbo.cyclistic_users as cu;

--adding column ride_day_of_week
SELECT DATEPART(dw,started_at) as ride_day_of_week
from cyclistics.dbo.cyclistic_users as cu;

ALTER TABLE cyclistics.dbo.cyclistic_users 
ADD ride_day_of_week as DATEPART(dw,started_at);

--adding column ride_month
SELECT  DATEPART(mm, started_at )  as ride_month
from cyclistics.dbo.cyclistic_users as cu;

ALTER TABLE cyclistics.dbo.cyclistic_users 
ADD ride_month as DATEPART(mm,started_at);

-- adding ride duration
--- to add ride duration column
ALTER TABLE cyclistics.dbo.cyclistic_users 
ADD ride_duration as (DATEPART("hour", (ended_at - started_at)) * 60 +
      DATEPART("n" , (ended_at - started_at)) +
      DATEPART("s" , (ended_at - started_at)) / 60);


---- bikes types used by riders
SELECT member_casual, rideable_type, COUNT(*) AS total_trips
FROM cyclistics.dbo.cyclistic_users 
GROUP BY member_casual, rideable_type
ORDER BY member_casual, total_trips;

-- no. of trips per day of week

SELECT ride_day_of_week, member_casual, COUNT(ride_id) AS total_trips
FROM cyclistics.dbo.cyclistic_users
GROUP BY ride_day_of_week, member_casual
ORDER BY member_casual;

--no. of trips per month 
select ride_month, member_casual, count(ride_id) as total_trips_per_month
FROM cyclistics.dbo.cyclistic_users
GROUP BY ride_month, member_casual
ORDER BY member_casual;

-- no. of trips per hour
SELECT datepart("HOUR", started_at) as hour_of_day, member_casual, COUNT(ride_id) AS total_trips
FROM cyclistics.dbo.cyclistic_users
GROUP BY hour_of_day, member_casual
ORDER BY member_casual;

-- average ride_length per month

SELECT ride_month, member_casual, AVG(ride_duration) AS avg_ride_duration
FROM cyclistics.dbo.cyclistic_users
GROUP BY ride_month, member_casual;

-- average ride_length per day of week

SELECT ride_day_of_week, member_casual, AVG(ride_duration) AS avg_ride_duration
FROM cyclistics.dbo.cyclistic_users
GROUP BY ride_day_of_week, member_casual;










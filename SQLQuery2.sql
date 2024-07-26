SELECT *
  FROM [Nestech DE Task].[dbo].[Green_Trip_Data_Jan_2024];

  
  select * from Green_Trip_Data_Jan_2024;
  select * from taxi_zone_lookup;
  select * from trips_fact order by pickup_datetime asc;
  select * from date_dim; 
  select * from location_dim;
 
	drop table trips_fact;

	CREATE TABLE trips_fact (
    trip_id INT PRIMARY KEY,
    pickup_datetime VARCHAR(50),
    dropoff_datetime VARCHAR(50),
    passenger_count INT,
    trip_distance FLOAT,
    pickup_location_id INT,
    dropoff_location_id INT,
    fare_amount FLOAT,
    tip_amount FLOAT,
    total_amount FLOAT,
	trip_date Date
);


CREATE TABLE date_dim (
    date_id INT PRIMARY KEY,
    date INT,
    year INT,
    month VARCHAR(15),
    day VARCHAR(15),
    weekday VARCHAR(15)
);


CREATE TABLE location_dim (
    location_id INT PRIMARY KEY,
    borough VARCHAR(50),
    zone VARCHAR(100),
    service_zone VARCHAR(50)
);


INSERT INTO trips_fact (trip_id, pickup_datetime, dropoff_datetime, passenger_count, 
trip_distance, pickup_location_id, dropoff_location_id, fare_amount, tip_amount, total_amount, trip_date)
SELECT 
    ROW_NUMBER() OVER (ORDER BY trip_date) AS trip_id,
    lpep_pickup_datetime,
    lpep_dropoff_datetime,
    passenger_count,
    trip_distance,
    PULocationID,
    DOLocationID,
    fare_amount,
    tip_amount,
    total_amount,
	trip_date
FROM Green_Trip_Data_Jan_2024;



INSERT INTO date_dim (date_id, date, year, month, day, weekday)
SELECT 
    ROW_NUMBER() OVER (ORDER BY trip_date) AS date_id,
    date,
    year,
    month,
    day,
    weekday
FROM Green_Trip_Data_Jan_2024;


INSERT INTO location_dim (location_id, borough, zone, service_zone)
SELECT 
    LocationID,
    Borough,
    Zone,
    service_zone
FROM taxi_zone_lookup;



select * from trips_fact;
select * from date_dim; 
select * from location_dim;


select distinct pickup_location_id from trips_fact order by pickup_location_id ASC;


SELECT 
	trip_date,
    COUNT(*) AS total_trips 
FROM trips_fact 
GROUP BY trip_date order by trip_date ASC;


SELECT 
TOP 5
    pickup_location_id,
	COUNT(*) AS count_pickup_location_id, 
	dropoff_location_id,
	COUNT(*) AS count_dropoff_location_id ,
	SUM(fare_amount) AS total_fare 
FROM trips_fact 
GROUP BY pickup_location_id, dropoff_location_id order by count_pickup_location_id DESC;


SELECT 
   pickup_location_id,
	COUNT(*) AS count_pickup_location_id, 
	dropoff_location_id,
	COUNT(*) AS count_dropoff_location_id ,
    AVG(trip_distance) AS avg_trip_distance 
FROM trips_fact
GROUP BY pickup_location_id, dropoff_location_id order by count_pickup_location_id DESC;



SELECT 
TOP 5
	pickup_location_id,
    COUNT(*) AS count_pickup_location_id 
FROM trips_fact 
GROUP BY pickup_location_id order by count_pickup_location_id DESC;




SELECT 
Top 1
	pickup_location_id,
	COUNT(*) AS count_pickup_location_id, 
	dropoff_location_id,
	COUNT(*) AS count_dropoff_location_id 
FROM trips_fact 
GROUP BY pickup_location_id, dropoff_location_id order by count_pickup_location_id DESC;


SELECT 
Top 5
	pickup_location_id,
	COUNT(*) AS count_pickup_location_id, 
	dropoff_location_id,
	COUNT(*) AS count_dropoff_location_id 
FROM trips_fact 
GROUP BY pickup_location_id, dropoff_location_id order by count_pickup_location_id DESC;




SELECT 
	TOP 5
    l.zone, 
    SUM(t.fare_amount) AS total_fare 
FROM trips_fact t
JOIN location_dim l ON t.pickup_location_id = l.location_id
GROUP BY l.zone
ORDER BY total_fare DESC;



SELECT 
    l.borough, 
    AVG(t.trip_distance) AS avg_trip_distance 
FROM trips_fact t
JOIN location_dim l ON t.pickup_location_id = l.location_id
GROUP BY l.borough;



SELECT 
    l.zone AS pickup_zone, 
    COUNT(*) AS pickup_count 
FROM trips_fact t
JOIN location_dim l ON t.pickup_location_id = l.location_id
GROUP BY l.zone
ORDER BY pickup_count DESC;


SELECT 
    l.zone AS dropoff_zone, 
    COUNT(*) AS dropoff_count 
FROM trips_fact t
JOIN location_dim l ON t.dropoff_location_id = l.location_id
GROUP BY l.zone
ORDER BY dropoff_count DESC;




SELECT 
    passenger_count, 
    SUM(tip_amount) AS total_tip 
FROM trips_fact 
GROUP BY passenger_count Order by total_tip DESC; 


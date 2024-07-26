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


SELECT 
	trip_date,
    COUNT(*) AS total_trips 
FROM trips_fact 
GROUP BY trip_date 
ORDER BY trip_date ASC;


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
GROUP BY l.borough 
ORDER BY avg_trip_distance DESC;


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
GROUP BY passenger_count 
ORDER BY total_tip DESC;
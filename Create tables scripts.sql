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

create database bikeshare
go

use BikeShare
go

CREATE TABLE rider 
	(rider_id INTEGER PRIMARY KEY, 
	first VARCHAR(50), 
	last VARCHAR(50), 
	address VARCHAR(100), 
	birthday DATE, 
	account_start_date DATE, 
	account_end_date DATE, 
	is_member varchar(50));

go

CREATE TABLE payment (
	payment_id INTEGER PRIMARY KEY, 
	date DATE, 
	amount decimal, 
	rider_id INTEGER);

go

CREATE TABLE station 
	(station_id VARCHAR(50) PRIMARY KEY, 
	 [name] VARCHAR(75), 
	 latitude FLOAT, 
	 longitude FLOAT)

go

CREATE TABLE trip 
	(trip_id VARCHAR(50) PRIMARY KEY, 
	 rideable_type VARCHAR(75), 
	 start_at TIME, 
	 ended_at TIME, 
	 start_station_id VARCHAR(50), 
	 end_station_id VARCHAR(50), 
	 rider_id INTEGER);


CREATE TABLE dbo.base_factTrip (
	rider_id int NULL,
	trip_id varchar(50) NULL,
	date_id date,
	start_at time(7) null,
	end_at time(7) null,
	start_station_id varchar(50) NULL,
	end_station_id varchar(50) NULL,
	rider_age varchar(75),
	trip_duration varchar(75)
)





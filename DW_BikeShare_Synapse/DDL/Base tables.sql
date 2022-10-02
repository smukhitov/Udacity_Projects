CREATE TABLE base_factPayment(
	payment_id int NOT NULL,
	rider_id int NULL,
	date_id date NULL,
	amount decimal(18, 2) NULL
)

CREATE TABLE base_factTrip (
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
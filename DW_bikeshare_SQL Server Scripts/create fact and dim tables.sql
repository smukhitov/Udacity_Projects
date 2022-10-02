DROP TABLE IF EXISTS dbo.factPayment;
DROP TABLE IF EXISTS dbo.factTrip;
DROP TABLE IF EXISTS dbo.dimRider;
DROP TABLE IF EXISTS dbo.dimStation;
DROP TABLE IF EXISTS dbo.dimTrip;


CREATE TABLE [dimStation] (
  [SK_station_id] int Primary Key not null,
  [station_id] varchar(50) not null,
  [name] varchar(255) not null,
  [latitude] float null,
  [longitude] float null
);

CREATE TABLE [dimRider] (
  [SK_rider_id] int Primary Key not null,
  [rider_id] int not null,
  [first] varchar(50) null,
  [last] varchar(50) null,
  [address] varchar(100) null,
  [birthday] date null,
  [account_start_date] date null,
  [account_end_date] date null,
  [is_member] varchar(10) null
);

CREATE TABLE [factPayment] (
  [payment_id] int not null,
  [SK_rider_id] int FOREIGN KEY references dimRider(SK_rider_id),
  [date_id] date FOREIGN KEY references dimDate(date_id),
  [amount] decimal(18,2) null
);

CREATE TABLE [factTrip] (
	[trip_id] [varchar](50) NOT NULL,
	[SK_rider_id] [int] FOREIGN KEY references dimRider(SK_rider_id),
	[SK_station_id] [int] FOREIGN KEY references dimStation (SK_station_id),
	 date_id date FOREIGN KEY references dimDate (date_id),
	[rideable_type] [varchar](75) NULL,
	[start_at] [time](7) NULL,
	[ended_at] [time](7) NULL,
	[start_station_id] [varchar](50) NULL,
	[end_station_id] [varchar](50) NULL,
	[rider_age] [varchar](75) NULL,
	[trip_duration] [varchar](75) NULL
);
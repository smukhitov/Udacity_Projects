CREATE TABLE [dbo].[etl_dimStation](
	[SK_station_id] [int] IDENTITY(1,1) NOT NULL,
	[station_id] nvarchar(255) NOT NULL,
	[newRecord] [bit] CONSTRAINT constraint_newRecord1 DEFAULT 1,
	[dateStamp] [datetime] 
) 
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)

CREATE TABLE [dbo].[etl_dimRider](
	[SK_rider_id] [int] IDENTITY(1,1) NOT NULL,
	[rider_id] [int] NOT NULL,
	[newRecord] [bit] CONSTRAINT constraint_newRecord2 DEFAULT 1,
	[dateStamp] [datetime] 
) 
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)

CREATE TABLE [dbo].[etl_dimTrip](
	[SK_trip_id] [int] IDENTITY(1,1) NOT NULL,
	[trip_id] [int] NOT NULL,
	[newRecord] [bit] CONSTRAINT constraint_newRecord3 DEFAULT 1,
	[dateStamp] [datetime] 
) 
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)

CREATE TABLE [dbo].[etl_factPayment](
	[payment_id] int not null,
	[rider_id] int not null,
	[date_id] date not null,
	[newRecord] [bit] CONSTRAINT constraint_newRecord4 DEFAULT 1,
	[dateStamp] [datetime] 
) 
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)

CREATE TABLE [dbo].[etl_factTrip](
	[SK_trip_id] [int] IDENTITY(1,1) NOT NULL,
	[rider_id] [int] NULL,
	[trip_id] [varchar](50) NULL,
	[date_id] [date] NULL,
	[start_at] [datetime] NULL,
	[end_at] [datetime] NULL,
	[start_station_id] [varchar](50) NULL,
	[end_station_id] [varchar](50) NULL,
	[newRecord] [bit] CONSTRAINT constraint_newRecord5 DEFAULT 1,
	[dateStamp] [datetime] NULL
) 
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)


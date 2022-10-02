CREATE TABLE [dimStation] (
  [SK_station_id] int IDENTITY(1,1) not null PRIMARY KEY NONCLUSTERED NOT ENFORCED,
  [station_id] nvarchar(255) not null,
  [name] varchar(255) not null,
  [latitude] float null,
  [longitude] float null
);
GO

CREATE TABLE [dimRider] (
  [SK_rider_id] int Primary Key NONCLUSTERED NOT ENFORCED not null,
  [rider_id] int not null,
  [first] varchar(50) null,
  [last] varchar(50) null,
  [address] varchar(100) null,
  [birthday] varchar(50) null,
  [account_start_date] varchar(50) null,
  [account_end_date] varchar(50) null,
  [is_member] varchar(10) null
);
GO

CREATE TABLE [factPayment] (
  [payment_id] int not null,
  [SK_rider_id] int NULL,
  [date_id] VARCHAR(50),
  [amount] decimal(18,2) null
);
GO

CREATE TABLE [factTrip] (
	[trip_id] [varchar](50) NOT NULL,
	[SK_rider_id] [int] NULL,
	[SK_station_id] [int] NULL,
	[date_id] [date] NULL,
	[rideable_type] [varchar](75) NULL,
	[start_at] [time](7) NULL,
	[ended_at] [time](7) NULL,
	[start_station_id] [varchar](50) NULL,
	[end_station_id] [varchar](50) NULL,
	[rider_age] [varchar](75) NULL,
	[trip_duration] [varchar](75) NULL
);
GO



CREATE TABLE dimDate (
	[date_id] [varchar](50)  NOT NULL,
    [dayofweek] int,
    [dayofmonth] int,
    [weekofyear] int,
	[quarter] int,
	[month] int,
	[year] int
)
GO

ALTER TABLE dimDate add CONSTRAINT PK_dimDate PRIMARY KEY NONCLUSTERED (date_id) NOT ENFORCED

DECLARE @StartDate DATE
DECLARE @EndDate DATE
SET @StartDate = '20130101'
SET @EndDate = '20210301'

WHILE @StartDate <= @EndDate
    BEGIN
        INSERT INTO [dimDate]
        SELECT
            
            @StartDate,
            DATEPART(WEEKDAY, @StartDate),
            DATEPART(DAY, @StartDate),
            DATEPART(WEEK, @StartDate),
            DATEPART(QUARTER, @StartDate),
            DATEPART(MONTH, @StartDate),
            DATEPART(YEAR, @StartDate)

        SET @StartDate = DATEADD(day, 1, @StartDate)
    END







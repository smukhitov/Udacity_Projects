CREATE TABLE [dbo].[etl_dimStation](
	[SK_station_id] [int] IDENTITY(1,1) NOT NULL,
	[station_id] [int] NOT NULL,
	[newRecord] [bit] NOT NULL,
	[dateStamp] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[etl_dimStation] ADD  CONSTRAINT [DF_etl_dimStation_newRecord]  DEFAULT ((1)) FOR [newRecord]
GO
ALTER TABLE [dbo].[etl_dimStation] ADD  CONSTRAINT [DF_etl_dimStation_dateStamp]  DEFAULT (getdate()) FOR [dateStamp]
GO


CREATE TABLE [dbo].[etl_dimRider](
	[SK_rider_id] [int] IDENTITY(1,1) NOT NULL,
	[rider_id] [int] NOT NULL,
	[newRecord] [bit] NOT NULL,
	[dateStamp] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[etl_dimRider] ADD  CONSTRAINT [DF_etl_dimRider_newRecord]  DEFAULT ((1)) FOR [newRecord]
GO
ALTER TABLE [dbo].[etl_dimRider] ADD  CONSTRAINT [DF_etl_dimRider_dateStamp]  DEFAULT (getdate()) FOR [dateStamp]
GO

CREATE TABLE [dbo].[etl_dimTrip](
	[SK_trip_id] [int] IDENTITY(1,1) NOT NULL,
	[trip_id] [int] NOT NULL,
	[newRecord] [bit] NOT NULL,
	[dateStamp] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[etl_dimTrip] ADD  CONSTRAINT [DF_etl_dimTrip_newRecord]  DEFAULT ((1)) FOR [newRecord]
GO
ALTER TABLE [dbo].[etl_dimTrip] ADD  CONSTRAINT [DF_etl_dimTrip_dateStamp]  DEFAULT (getdate()) FOR [dateStamp]
GO

CREATE TABLE [dbo].[etl_factPayment](
	[payment_id] int PRIMARY KEY not null,
	[rider_id] int not null,
	[date_id] date not null,
	[newRecord] [bit] NOT NULL,
	[dateStamp] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[etl_factPayment] ADD  CONSTRAINT [DF_etl_factPayment_newRecord]  DEFAULT ((1)) FOR [newRecord]
GO
ALTER TABLE [dbo].[etl_factPayment] ADD  CONSTRAINT [DF_etl_factPayment_dateStamp]  DEFAULT (getdate()) FOR [dateStamp]
GO






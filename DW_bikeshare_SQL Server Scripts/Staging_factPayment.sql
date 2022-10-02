DROP TABLE [dbo].[base_factTrip]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[base_factTrip]
( 
	[rider_id] [int]  NULL,
	[trip_id] [varchar](50)  NULL,
	rideable_type [varchar](255)  NULL,
	[date_id] [date]  NULL,
	[start_at] [time](7)  NULL,
	[end_at] [time](7)  NULL,
	[start_station_id] [varchar](50)  NULL,
	[end_station_id] [varchar](50)  NULL,
	[rider_age] [varchar](75)  NULL,
	[trip_duration] [varchar](75)  NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO

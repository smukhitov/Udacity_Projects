insert into bikeshare.dbo.dimRideType
(
		rideable_type
)

	select	src.rideable_type
	from (  select distinct rideable_type 
			from bikeshare.dbo.stg_trip
			except
			select rideable_type
			from bikeshare.dbo.dimRideType
		  ) as src
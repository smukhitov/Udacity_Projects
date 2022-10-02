USE bikeshare
GO


--reseed from source
insert into bikeshare.dbo.etl_dimTrip
(
	trip_id
)

	select distinct trip_id
	from	bikeshare.dbo.stg_trip

	except

	select  trip_id
	from	bikeshare.dbo.etl_dimTrip

--update the prod

update dt
set dt.SK_trip_id = x.SK_trip_id,
	dt.trip_id = x.trip_id,
	dt.start_at = x.start_at,
	dt.ended_at = x.ended_at,
	dt.start_station_id = x.start_station_id,
	dt.end_station_id = x.end_station_id

from ( 	select	distinct
				edt.SK_trip_id,
				stgt.trip_id,
				stgt.start_at,
				stgt.ended_at,
				stgt.start_station_id,
				stgt.end_station_id
		from bikeshare.dbo.stg_trip stgt
		inner join bikeshare.dbo.etl_dimTrip edt on edt.trip_id = stgt.trip_id

		except

		SELECT SK_trip_id, 
			   trip_id,
			   start_at,
			   ended_at,
			   start_station_id,
			   end_station_id
		FROM bikeshare.dbo.dimTrip
	 ) x inner join bikeshare.dbo.dimTrip dt on x.SK_trip_id = dt.SK_trip_id


--insert into prod
insert into bikeshare.dbo.dimTrip
(
			   SK_trip_id, 
			   trip_id,
			   start_at,
			   ended_at,
			   start_station_id,
			   end_station_id,
			   rideable_type_id
)

	select		distinct
				edt.SK_trip_id,
				stgt.trip_id,
				stgt.start_at,
				stgt.ended_at,
				stgt.start_station_id,
				stgt.end_station_id,
				drt.rideable_type_id

	from bikeshare.dbo.stg_trip stgt
	inner join bikeshare.dbo.etl_dimTrip edt on stgt.trip_id = edt.trip_id
	inner join bikeshare.dbo.dimRideType drt on stgt.rideable_type = drt.rideable_type
	where edt.newRecord = 1



--update etl table record status
update	bikeshare.dbo.etl_dimTrip
set		newRecord = 0
where	newRecord = 1
		and SK_trip_id in (select SK_trip_id from bikeshare.dbo.dimTrip)



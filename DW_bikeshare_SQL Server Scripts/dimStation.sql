USE bikeshare
GO


--reseed from source
insert into bikeshare.dbo.etl_dimStation
(
	station_id
)

	select distinct station_id
	from	bikeshare.dbo.stg_station

	except

	select  station_id
	from	bikeshare.dbo.etl_dimStation

--update the prod

update ds
set ds.SK_station_id = x.SK_station_id,
	ds.station_id = x.station_id,
	ds.name = x.name,
	ds.latitude = x.latitude,
	ds.longitude = x.longitude

from ( 	select	distinct
				eds.SK_station_id,
				stgs.station_id,
				stgs.name,
				stgs.latitude,
				stgs.longitude

		from bikeshare.dbo.stg_station stgs
		inner join bikeshare.dbo.etl_dimStation eds on eds.station_id = stgs.station_id

		except

		SELECT SK_station_id, 
			   station_id,
			   name,
			   latitude,
			   longitude
		FROM bikeshare.dbo.dimStation
	 ) x inner join bikeshare.dbo.dimStation ds on x.SK_station_id = ds.SK_station_id


--insert into prod
insert into [bikeshare].[dbo].[dimStation]
(
			   SK_station_id, 
			   station_id,
			   name,
			   latitude,
			   longitude

)

	select		distinct
				eds.SK_station_id,
				stgs.station_id,
				stgs.name,
				stgs.latitude,
				stgs.longitude

	from bikeshare.dbo.stg_station stgs
	inner join bikeshare.dbo.etl_dimStation eds on stgs.station_id = eds.station_id

	where eds.newRecord = 1



--update etl table record status
update	bikeshare.dbo.etl_dimStation
set		newRecord = 0
where	newRecord = 1
		and SK_station_id in (select SK_station_id from bikeshare.dbo.dimStation)



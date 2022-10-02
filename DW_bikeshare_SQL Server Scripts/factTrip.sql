--reseed from source

insert into dbo.etl_factTrip
(
	rider_id,
	trip_id,
	date_id,
	start_at,
	end_at,
	start_station_id,
	end_station_id
)

select distinct
	rider_id,
	trip_id,
	date_id,
	start_at,
	end_at,
	start_station_id,
	end_station_id	   
from dbo.base_factTrip

except

select	rider_id,
		trip_id,
		date_id,
		start_at,
		end_at,
		start_station_id,
		end_station_id
from	dbo.etl_factTrip

--update the existing fact from source table		

update f
set	f.trip_id = x.trip_id,
	f.SK_rider_id = x.SK_rider_id,
	f.SK_station_id = x.SK_station_id,
	f.date_id = x.date_id,
	f.rideable_type = x.rideable_type,
	f.start_at = x.start_at,
	f.ended_at = x.end_at,
	f.start_station_id = x.start_station_id,
	f.end_station_id = x.end_station_id,
	f.rider_age = x.rider_age,
	f.trip_duration = x.trip_duration
from ( 	select	 distinct
				 ft.trip_id,
				 er.SK_rider_id,
				 es1.SK_station_id,
				 stg.date_id,
				 stg.rideable_type,
				 stg.start_at,
				 stg.end_at,
				 stg.start_station_id,
				 stg.end_station_id,
				 stg.rider_age,
				 stg.trip_duration
		from dbo.base_factTrip stg
		inner join dbo.etl_factTrip ft on stg.trip_id = ft.trip_id
			and stg.rider_id = ft.rider_id
			and stg.start_at = ft.start_at
			and stg.end_at = ft.end_at
			and stg.start_station_id = ft.start_station_id
			and stg.end_station_id = ft.end_station_id
		left join etl_dimRider er on er.rider_id = ft.rider_id
		left join etl_dimStation es1 on es1.station_id = ft.start_station_id
		left join etl_dimStation es2 on es1.station_id = ft.end_station_id

		except

		select	   trip_id
				  ,SK_rider_id
				  ,SK_station_id
				  ,date_id
				  ,rideable_type
				  ,start_at
				  ,ended_at
				  ,start_station_id
				  ,end_station_id
				  ,rider_age
				  ,trip_duration
		from	dbo.factTrip
	 ) x inner join dbo.factTrip f on x.trip_id = f.trip_id

--insert into prod
insert into dbo.factTrip
(
				   trip_id
				  ,SK_rider_id
				  ,SK_station_id
				  ,date_id
				  ,rideable_type
				  ,start_at
				  ,ended_at
				  ,start_station_id
				  ,end_station_id
				  ,rider_age
				  ,trip_duration		
)

	select		 distinct
				 ft.trip_id,
				 er.SK_rider_id,
				 es1.SK_station_id,
				 stg.date_id,
				 stg.rideable_type,
				 stg.start_at,
				 stg.end_at,
				 stg.start_station_id,
				 stg.end_station_id,
				 stg.rider_age,
				 stg.trip_duration
		from dbo.base_factTrip stg
		inner join dbo.etl_factTrip ft on stg.trip_id = ft.trip_id
			and stg.rider_id = ft.rider_id
			and stg.start_at = ft.start_at
			and stg.end_at = ft.end_at
			and stg.start_station_id = ft.start_station_id
			and stg.end_station_id = ft.end_station_id
		left join etl_dimRider er on er.rider_id = ft.rider_id
		left join etl_dimStation es1 on es1.station_id = ft.start_station_id
		left join etl_dimStation es2 on es1.station_id = ft.end_station_id		

	where ft.newRecord = 1


--update etl table record status
update	etl_factTrip
set		newRecord = 0, dateStamp = GETDATE()
where	newRecord = 1
		and trip_id in ( select trip_id from factTrip)
insert into base_factTrip
(
	rider_id,
	trip_id,
	rideable_type,
	date_id,
	start_at,
	end_at,
	start_station_id,
	end_station_id,
	rider_age,
	trip_duration
)

select distinct   
	sr.rider_id,
	st.trip_id,
	st.rideable_type,
	dd.date_id,
	st.start_at,
	st.ended_at,
	ss1.station_id as start_station_id,
	ss2.station_id as end_station_id,
	DATEDIFF(year, sr.birthday, GETDATE()) as rider_age,
	DATEDIFF(minute, st.start_at, st.ended_at) as trip_duration
from stg_trip as st
left join stg_rider as sr on st.rider_id = sr.rider_id
left join dimDate as dd on dd.date_id = cast(st.start_at as date) 
left join stg_station as ss1 on ss1.station_id = st.start_station_id
left join stg_station as ss2 on ss2.station_id = st.end_station_id
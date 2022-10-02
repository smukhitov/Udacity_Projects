--reseed from source
insert into dbo.etl_dimRider
(
	rider_id
)

	select distinct rider_id
	from dbo.stg_payment

	except

	select  rider_id
	from	dbo.etl_dimRider

--update the existing the data in dimension table

update dr
set dr.SK_rider_id = x.SK_rider_id,
	dr.rider_id = x.rider_id,
	dr.first = x.first,
	dr.last = x.last,
	dr.address = x.address,
	dr.birthday = x.birthday,
	dr.account_start_date = x.account_start_date,
	dr.account_end_date = x.account_end_date

from ( 	select	distinct
				edr.SK_rider_id,
				stgr.rider_id,
				stgr.first,
				stgr.last,
				stgr.address,
				stgr.birthday,
				stgr.account_start_date,
				stgr.account_end_date,
				stgr.is_member

		from dbo.stg_rider stgr
		inner join dbo.etl_dimRider edr on edr.rider_id = stgr.rider_id

		except

		SELECT SK_rider_id 
			  ,[rider_id]
			  ,[first]
			  ,[last]
			  ,[address]
			  ,[birthday]
			  ,[account_start_date]
			  ,[account_end_date]
			  ,[is_member]
		FROM [dbo].[dimRider]
	 ) x inner join dbo.dimRider dr on x.SK_rider_id = dr.SK_rider_id


--insert into new records
insert into [dbo].[dimRider]
(
			   SK_rider_id 
			  ,[rider_id]
			  ,[first]
			  ,[last]
			  ,[address]
			  ,[birthday]
			  ,[account_start_date]
			  ,[account_end_date]
			  ,[is_member]

)

	select		distinct
				edr.SK_rider_id,
				stgr.rider_id,
				stgr.first,
				stgr.last,
				stgr.address,
				stgr.birthday,
				stgr.account_start_date,
				stgr.account_end_date,
				stgr.is_member
			

	from dbo.stg_rider stgr
	inner join dbo.etl_dimRider edr on stgr.rider_id = edr.rider_id

	where edr.newRecord = 1



--update etl table record status
update	dbo.etl_dimRider
set		newRecord = 0, dateStamp = GETDATE()
where	newRecord = 1
		and SK_rider_id in (select SK_rider_id from [dbo].[dimRider])
--reseed from source

insert into dbo.etl_factPayment
(
	   rider_id
	  ,payment_id
      ,date_id
)

select distinct
	    rider_id
	   ,payment_id
	   ,date_id	   
from dbo.base_factPayment
where rider_id is not null
except

select	 rider_id
		,payment_id
		,date_id
from	dbo.etl_factPayment

--update the existing dimension from source table		

update f
set	f.payment_id = x.payment_id,
	f.SK_rider_id = x.SK_rider_id,
	f.date_id = x.date_id,
	f.amount = x.amount

from ( 	select	 distinct
				 fp.payment_id 
				,er.SK_rider_id 
				,stg.date_id 
				,stg.amount
				
		from dbo.base_factPayment stg
		inner join dbo.etl_factPayment fp on stg.payment_id = fp.payment_id
			and stg.rider_id = fp.rider_id
			and stg.date_id = fp.date_id
		left join etl_dimRider er on fp.rider_id = er.rider_id  


		except

		select	   payment_id
				  ,SK_rider_id
				  ,date_id
				  ,amount		

		from	dbo.factPayment
	 ) x inner join dbo.factPayment f on x.payment_id = f.payment_id

--insert into prod
insert into dbo.factPayment
(
	 payment_id
	,SK_rider_id
	,date_id
	,amount		
)

	select		 fp.payment_id 
				,er.SK_rider_id 
				,stg.date_id 
				,stg.amount
				
		from dbo.base_factPayment stg
		inner join dbo.etl_factPayment fp on stg.payment_id = fp.payment_id
			and stg.rider_id = fp.rider_id
			and stg.date_id = fp.date_id
		left join etl_dimRider er on fp.rider_id = er.rider_id		

	where fp.newRecord = 1


--update etl table record status
update	etl_factPayment
set		newRecord = 0, dateStamp = getdate()
where	newRecord = 1
		and rider_id in ( select rider_id from factPayment)
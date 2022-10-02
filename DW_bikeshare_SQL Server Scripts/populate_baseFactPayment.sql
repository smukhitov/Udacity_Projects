insert into base_factPayment
(
	rider_id,
	payment_id,
	date_id,	
	amount	
)

select distinct   
	sr.rider_id,
	sp.payment_id,
	sp.date,
	sp.amount
from stg_payment as sp 
left join stg_rider as sr on sr.rider_id = sp.rider_id

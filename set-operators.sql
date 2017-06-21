/*
	Set operator in sql
	6/9/2017
	
	Requirements for set operations:
	1. all queries combined must have an equal number of expressions in target lists
	2. expressions should have similar data types
	3. expressions should in the same order
	
	be careful when using order by
*/

select top 1000 * 
from optPrice

-- Union
select optId, bid, ask
from optPrice
where 1 = 1
	and optId = 3
union all
select optId, bid, ask 
from optPrice
where 1 = 1
	and optId = 4

-- Except
select optId, bid, ask
from optPrice
where 1 = 1
	and optId = 3
except
select optId, bid, ask
from optPrice
where 1 = 1
	and optId = 3
	and bid >= 10

-- Intersect
select optId, bid, ask
from optPrice
where 1 = 1
	and optId = 3
	and bid between 10 and 12
intersect
select optId, bid, ask
from optPrice
where 1 = 1
	and optId = 3
	and ask between 11.5 and 12

/*
	exists operator
	just like boolean expression, return ture / false, and return corresponding results for true
*/
select op.bid, op.ask
from ovs.dbo.optPrice op
where exists( 
	select oc.optId
	from optContract oc
	where 1=1
		and oc.opraRoot = 'AAPL'
		and '20170620' between oc.startDate and oc.endDate
		and oc.strike > 100)

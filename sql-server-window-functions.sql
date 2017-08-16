/*
	Window functions in sql server (2008)
	6/9/2017
	
	Window function belong to a type of function a.k.a set function
	which means a function that applies to a set of rows.
	Supported by Oracle, Sybase, DB2, PostgreSQL (open source) etc
	
	https://www.simple-talk.com/sql/learn-sql-server/window-functions-in-sql-server/
*/

/*
	One of the most important benefits of window function is that
	we can access the details of rows from an aggregation
*/	

-- Suppose we have the data: where for each optId, there are a set of bid / ask price
select top 100 *
from optPrice

-- Get the average bid and ask price for each optId
select tmp.optId, AVG(tmp.mid) as avg_mid
from (
	select top 100 optId, bid, ask, .5*(bid + ask) as mid
	from optPrice 
	) tmp
group by tmp.optId

select optId, bid, ask, .5 * (bid + ask) as mid
	from optPrice as tmp

-- Slow query...
select top 100 optId, AVG(.5*(bid + ask)) as avg_mid
from optPrice
group by optId

/*
	Now what if we want to return the avg_mid to each row in optPrice?
  
	One way is write a subquery with group by clause for each aggregation
	then join with the main query correspondingly
	
	Or, get the aggregate table first and join it with original table
*/
select 
	op.optId,
	op.bid,
	op.ask,
	aa.avg_mid
from optPrice op, (
	select top 100 
		optId,
		AVG(.5*(bid + ask)) as avg_mid
	from optPrice
	group by optId
) aa
where 1 = 1
	and op.optId = aa.optId

/*
	Third method: use OVER()
	(slower query than above)	
*/
select top 10 optId,
	bid,
	ask,
	AVG(.5*(bid + ask)) over(partition by optId) as avg_mid
from optPrice

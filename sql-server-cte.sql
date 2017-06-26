/*
	CTE - common table expression
	only supported by sql server
	6/9/2017
	
	Two types: recursive and non-recursive
	
	How to define CTEs?
	adding a WITH() clause directly before statements like 
	SELECT, INSERT, UPDATE, DELETE, CREATE VIEW etc
	
	If more than one CTE is in the with, comma is needed to separate;
	For each CTE:
		1. name
		2. AS clause
		3. SELECT clause
		4. column names (separated by comma)
		
	
	https://www.simple-talk.com/sql/t-sql-programming/sql-server-cte-basics/
*/

-- Creating a non-recursive CTE
with cteExample (cte_optId, cte_bid, cte_ask, cte_close_)
as
(
	select optId, bid, ask, close_
	from optPrice
	where 1 = 1
		and optId between 3 and 6
)
select * 
from cteExample ctee join optPrice op on ctee.cte_optId = op.optId 
-- the above line must run together with the WITH() clause

/*
	After we define a CTE with WITH() clause, we can refer the CTE.
	However, we can refere a CTE only within the execution of the 
	statement that immediately follows the WITH() clause.
	After we've run the statement, the CTE result set is not available
	to other statements. 
*/
select * from cteExample
-- this query won't work

/*
	example of recursive cte:
	return the days between a start date and end date
*/
declare @startDate date
declare @endDate date
set @startDate = '20170605'
set @endDate = '20170616'
;with cte as (
	select @startDate as date_
	union all
	select DATEADD(DAY, 1, date_) as date_
	from cte where date_ < @endDate
)
select cte.date_
from cte

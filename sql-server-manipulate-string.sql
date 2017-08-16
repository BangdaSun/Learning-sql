/*
	charindex() function
  
	charindex(expressionToFind, expressionToSearch, [start location])
	return the location of first match
*/

declare @target char(3)
set @target = 'AIR'

select top 100 * 
select top 100 CHARINDEX(@target, opraTicker) as isFind
from ovs.dbo.optContract

declare 
	@sign char(1),
	@doc varchar(20)
	
set @sign = '$'
set @doc = 'I got $x + y = 1$ from $x = 0$ and $y = 1$'

select CHARINDEX(@sign, @doc) -- return 7

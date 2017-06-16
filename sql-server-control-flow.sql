/*
	declare varibales
*/
declare @a int
set @a = 3
-- if there is a 'go' here the following query won't work
select @a -- return 3

select top 1 @a 
from ovs.dbo.optContract -- return 3

-- 
declare @b int
set @b = (
	select top 1 @a
	from ovs.dbo.optContract
)

select @b -- return 3

/*
	if - else
*/
if (@a < 4) 
	select 'small a'
else
	select 'large a'

/*
	begin ... end
*/
begin 
	declare @salary float
	declare @hour int
	set @salary = 22
	set @hour = 40
	select @hour * @salary
end

select @salary -- won't work

/*
	case - (when) - end
*/
select top 100 exercise, COUNT(exercise)
from ovs.dbo.optContract
group by exercise

-- use a select statement with a simple case expression
select top 100 optId, type_ = 
	case 
		when exercise = 'A' then 'American'
		when exercise = 'E' then 'European'
	end
from ovs.dbo.optContract


-- use a select statement with a searched case expression
select top 100 optId, strike, statement_ = 
	case 
		when strike > 30 then 'high'
		when strike < 20 then 'low'
		else 'fair'
	end
from ovs.dbo.optContract

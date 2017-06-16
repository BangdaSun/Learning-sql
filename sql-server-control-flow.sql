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

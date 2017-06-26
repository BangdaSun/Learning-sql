/*
use dbname
go
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create/alter function myfun (  -- create can be used only once, to extend the function, use alter
	@var1 datatype,
    @var2 datatype,
    ...
) returns @tbl table (
    var1 datatype,
    var2 datatype,
    ...
) as 
begin

    [queries]

	return
end
*/
-- ==============================================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	return the days between a start date and end date
-- ==============================================================
alter function [dbo].[fnGetDay] 
(	
	-- Add the parameters for the function here
	@startDate date,
	@endDate   date
)
returns 
@tbl table (
	individualDate date
)
as
begin
	-- ======================= body of function ======================
	;with cteRange(dateRange) as (
		select @startDate
		union all
		select DATEADD(DAY, 1, dateRange)
		from cteRange
		where dateRange <= DATEADD(DAY, -1, @endDate)
	)
	insert into @tbl(individualDate)
	select dateRange 
	from cteRange
	return
end

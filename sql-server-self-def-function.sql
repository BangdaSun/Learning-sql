/*
  Define your own functions 
  it could be scalar functions, table functions, etc

  General format:
  
use dbname
go
SET ANSI_NULLS ON
go
SET QUOTED_IDENTIFIER ON
go

 -- create can be used only once, to extend the function, use alter
create/alter function myfun ( 
	@var1 datatype,
  @var2 datatype,
  ...
) returns @tbl table (
   var1 datatype,
   var2 datatype,
   ...
) as 
begin
   ...
   [queries]
   ...
	 return
end
*/

-- one example of table function:
-- --------------------------------------------------------------
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	return the days between a start date and end date
-- --------------------------------------------------------------
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
  -- ------------- body of function -----------------
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

/*
  Stored procedure
  
  wrapped up multiple sql statements
  more flexible and causal then function
  run faster than run the sql statements line by line

-- create and alter stored procedure
use dbname
go
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create/alter procedure my_proc (
  @input1 datatype,
  @input2 datatype,
  ...
) as 
begin
  ...
  [queries]
  ...
end

-- execute stored procedure
exec db.dbo.my_proc input1, input2

-- drop stored procedure
drop db.dbo.my_proc

*/

-- one example:
ALTER procedure [dbo].[getBoxStrategy]
  -- input
  @root          varchar(6),
  @expiry         date,
  @moneynessType  int,
  @moneynessLow   float,
  @moneynessHigh  float,
  @startdate      date,
  @enddate        date
as
begin
	-- output
  declare @tbl table (
    date_    date,
    date2_   date,
    opraRoot varchar(6),
    optId    int,
    putCall  varchar(1),
    strike   float,
    expDate  date,
    T        float,
    buySell  int,
    index_   int
  )
end

-- execution store procedure
-- declare @tbl first
-- vertical call
insert @tbl 
exec ntbt.dbo.getVerticalStrategy @root, @expiry, 'C', @moneynessType, @moneynessLow, @moneynessHigh, @startdate, @enddate
select * from @tbl
-- vertical put
insert @tbl
exec ntbt.dbo.getVerticalStrategy @root, @expiry, 'P', @moneynessType, @moneynessLow, @moneynessHigh, @startdate, @enddate
select * from @tbl

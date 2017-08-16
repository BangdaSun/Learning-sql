/*
  temporary table vs table variable
	
  temporary table: 
  create table #tmp (
    ...
  )
  insert into #tmp
  select *
    from table


  table variable:
  declare @table (
    ...
  )
	
  notice: use alias for table variable: @table tbl => tbl.col
*/

/*
  Example: rank the grade of student in each class
    over(),
    partition by ..., (? group by)
    order by...,
    row_number() - window function in sql server
*/
declare @tbl table (  -- create a table variable
  id int,
  class varchar(1),
  grade float
)
insert into @tbl values(1001, 'A', 90)
insert into @tbl values(1002, 'A', 89)
insert into @tbl values(1003, 'A', 75)
insert into @tbl values(1004, 'A', 92)
insert into @tbl values(1005, 'B', 84)
insert into @tbl values(1006, 'B', 90)
insert into @tbl values(1007, 'B', 94.5)
insert into @tbl values(1008, 'B', 89)
insert into @tbl values(1009, 'C', 88.5)
insert into @tbl values(1010, 'C', 64)
insert into @tbl values(1013, 'C', 87)
insert into @tbl values(1014, 'D', 90)
insert into @tbl values(1016, 'D', 91)
select tbl.class, tbl.grade, ROW_NUMBER() over(partition by tbl.class order by tbl.grade desc) as rank_ 
from @tbl tbl -- better use alias, and run the whole chunk simulateneously (return error if run separatedly)

-- compared with table variable: temporary table need to be named as #tbl, also need to be dropped after created and manipulated


/*
  apply operator
	
  allows user to invoke a table-valued function for each row and return an outer table of a query
  the parameter of the function would be values in rows of table
  (table function: return a table data type, can be powerful alternatives to views)

  cross apply
  select *
  from table cross apply tableFunction
*/

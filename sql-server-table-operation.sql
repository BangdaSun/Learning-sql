/*
	apply operator
	
	allows user to invoke a table-valued function for each row and return an outer table of a query
	(table function: return a table data type, can be powerful alternatives to views)
	
	select *
	from table cross apply tablefunc
*/

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
	
	notice: use sql alias: @table tbl => tbl.col
*/

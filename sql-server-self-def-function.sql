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

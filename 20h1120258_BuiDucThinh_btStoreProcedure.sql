
-------------------------------------------------------------------------------------------

create proc caculateSumTotalDue @nam datetime, @thang datetime
as
	begin
		select s.CustomerID,SUM(s.TotalDue) as sumofTotalDue 
		from Sales.SalesOrderHeader s
		where MONTH(OrderDate)=@thang and YEAR(OrderDate)=@nam
		group by CustomerID
	end

drop procedure caculateSumTotalDue
exec caculateSumTotalDue 2013,7
---------------------------------------------------------------------------------------------
CREATE PROCEDURE Sp_Update_Product @ProductId INT
AS
BEGIN
    IF EXISTS (SELECT * FROM Production.Product WHERE ProductID = @ProductId)
    BEGIN
        UPDATE Production.Product
        SET ListPrice = ListPrice * 1.1
        WHERE ProductID = @ProductId

        PRINT 'listPrice da tang len 10%.'
    END
    ELSE
    BEGIN
        PRINT 'Khong co san pham nay.'
    END
END

EXEC Sp_Update_Product @ProductId = 710
SELECT * FROM Production.Product WHERE ProductID = 710
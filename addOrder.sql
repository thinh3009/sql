CREATE TABLE Customers
{
        CustomerID smallint
        CustomerName varchar(50)
}
CREATE TABLE Orders
{
	OrderID smallint
        ProductName varchar(50)
	CustomerID smallint
}


CREATE PROCEDURE AddNewOrder 
	@OrderID smallint,
	@ProductName varchar(50),
	@CustomerName varchar(50),
	@Result smallint=1 Output
	AS

	DECLARE @CustomerID smallint
	BEGIN TRANSACTION
	If not Exists(SELECT CustomerID FROM Customers WHERE [Name]=@CustomerName)
	--This is a new customer. Insert this customer to the database
		BEGIN
			SET @CustomerID= (SELECT Max(CustomerID) FROM Customers)
			SET @CustomerID=@CustomerID+1
			INSERT INTO Customers VALUES(@CustomerID,@CustomerName)
			If Exists(SELECT OrderID FROM [Orders] WHERE OrderID=@OrderID)
			--This order exists and could not be added any more so Roll back
				BEGIN
					SELECT @Result=1
					ROLLBACK TRANSACTION
				END
			Else
			--This is a new order insert it now
				BEGIN
					INSERT INTO [Orders](OrderID,ProductName,CustomerID) VALUES(@OrderID,@ProductName,@CustomerID)
					SELECT @Result=0
					COMMIT TRANSACTION
				END
		END
	Else
	--The customer exists in DB go ahead and insert the order
		BEGIN
			If Exists(SELECT OrderID FROM [Orders] WHERE OrderID=@OrderID)
			--This order exists and could not be added any more so Roll back
				BEGIN
					SELECT @Result=1
					ROLLBACK TRANSACTION
				END
			Else
			--This is a new order insert it now
				BEGIN
					INSERT INTO [Orders](OrderID,ProductName,CustomerID) VALUES(@OrderID,@ProductName,@CustomerID)
					SELECT @Result=0
					COMMIT TRANSACTION
				END
		END
	Print @Result
	Return
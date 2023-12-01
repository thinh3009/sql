--foreign key
use QLBH
alter table [dbo].[SalesOrders]
add constraint FK_saleorder_CustomerID foreign key ([CustomerID]) references [dbo].[Customers]([CustomerID])

alter table [dbo].[SalesOrderDetails]
add constraint FK_SalesOrderDetails_invoiceNumber foreign key ([invoiceNumbers]) references [dbo].[SalesOrders]([invoiceNumber])

alter table [dbo].[SalesOrderDetails]
add constraint FK_SalesOrderDetails_invoiceNumber foreign key ([invoiceNumbers]) references [dbo].[SalesOrders]([invoiceNumber])

alter table SalesOrderDetails
add constraint Fk_SalesOrderDetails_stockID foreign key (StockID) references Stock

alter table Stock
add constraint Fk_Stock_stockID foreign key (ProductID) references Products

alter table ListTypesData
add constraint Fk_lstPriDat_ListTypes foreign key (ListTypeID) references ListTypes

--procedure
CREATE PROC them_product
    @productid smallint,
	@name nvarchar(100),
	@categoryid smallint,
	@supplieid smallint,
	@purchaseprice decimal,
	@saleprice decimal
AS 
BEGIN
	IF EXISTS (SELECT * FROM Products WHERE ProductID = @productid)
	BEGIN
		PRINT 'san pham da ton tai'
	END
	ELSE
	BEGIN
		INSERT INTO Products(ProductID, Name, CategoryID,SupplieID,PurchasePrice,SalePrice) VALUES (@productid,@name,@categoryid,@supplieid,@purchaseprice,@saleprice)
		PRINT 'them san pham thanh cong'
	END
END
select * from ProductSizes
SET IDENTITY_INSERT [QLBH].[dbo].[Products] ON;
exec them_product @productid =1,@name='chuot khong day',@categoryid=111,@supplieid=123,@purchaseprice=700000,@saleprice=10
exec them_product @productid =2,@name='laptop acer nitro 15 ',@categoryid=112,@supplieid=124,@purchaseprice=25000000,@saleprice=null
exec them_product @productid =3,@name='usb 256gb',@categoryid=113,@supplieid=125,@purchaseprice=200000,@saleprice=null
exec them_product @productid =4,@name='ban phim logitech',@categoryid=114,@supplieid=126,@purchaseprice=2100000,@saleprice=20

--xoa san pham
CREATE PROC xoa_product
    @productid smallint
AS 
BEGIN
	IF EXISTS (SELECT * FROM Products WHERE ProductID= @productid)
	begin
		DELETE FROM Products WHERE ProductID = @productid
		print 'xoa san pham thanh cong'
	end
	else
	begin
		print 'khong ton tai thong tin'
	end
END

--sua san pham
CREATE PROC sua_product
    @productid smallint,
	@name nvarchar(100),
	@categoryid smallint,
	@supplieid smallint,
	@purchaseprice decimal,
	@saleprice decimal
as
	BEGIN
		UPDATE Products
		SET Name=@name,CategoryID=@categoryid,SupplieID=@supplieid,PurchasePrice=@purchaseprice,SalePrice=@saleprice
		WHERE ProductID=@productid
	IF NOT EXISTS (SELECT * FROM Products WHERE ProductID = @productid)
	BEGIN
		PRINT 'khong ton tai san pham'
	END
	ELSE
	BEGIN
		PRINT 'sua thong tin san pham'
	END
    END

--them productSize

CREATE PROC them_productsize
    @productid smallint,
	@sizeid smallint
AS 
BEGIN
	IF EXISTS (SELECT * FROM ProductSizes WHERE ProductID = @productid)
	BEGIN
		PRINT 'san pham da ton tai'
	END
	ELSE
	BEGIN
		INSERT INTO ProductSizes(ProductID, SizeID) VALUES (@productid,@sizeid)
		PRINT 'them san pham thanh cong'
	END
END
exec them_productsize @productid=1,@sizeid=321
exec them_productsize @productid=2,@sizeid=322
exec them_productsize @productid=3,@sizeid=323
exec them_productsize @productid=4,@sizeid=324
--sua productsize
CREATE PROC sua_productsize
    @productid smallint,
	@sizeid smallint
as
	BEGIN
		UPDATE ProductSizes
		SET SizeID=@sizeid
		WHERE ProductID=@productid
	IF NOT EXISTS (SELECT * FROM ProductSizes WHERE ProductID = @productid)
	BEGIN
		PRINT 'khong ton tai san pham'
	END
	ELSE
	BEGIN
		PRINT 'sua thong tin san pham'
	END
    END
--xoa product size
CREATE PROC xoa_productsize
    @productid smallint
AS 
BEGIN
	IF EXISTS (SELECT * FROM ProductSizes WHERE ProductID= @productid)
	begin
		DELETE FROM ProductSizes WHERE ProductID = @productid
		print 'xoa san pham thanh cong'
	end
	else
	begin
		print 'khong ton tai thong tin'
	end
END
--them customer
CREATE PROC them_customer
    @customerid smallint,
	@name varchar(50),
	@mobile nvarchar(15),
	@address nvarchar(100)
AS 
BEGIN
	IF EXISTS (SELECT * FROM Customers WHERe CustomerID = @customerid)
	BEGIN
		PRINT 'khach hang da ton tai'
	END
	ELSE
	BEGIN
		INSERT INTO Customers(CustomerID, Name, Mobile,Address) VALUES (@customerid,@name,@mobile,@address)
		PRINT 'them khach hang thanh cong'
	END
END

exec them_customer @customerid=2002,@name='bui duc thinh',@mobile='0934827466',@address='45 nam ky khoi nghia, q1, tphcm'
exec them_customer @customerid=2003,@name='tran thanh duy',@mobile='0876435643',@address='2 xa gia hung, huyen nguyen xi, long an'
exec them_customer @customerid=2004,@name='ho hiep phat',@mobile='0994343212',@address='33 nguyen van troi,binh tan,tphcm'
exec them_customer @customerid=2005,@name='trinh minh dien',@mobile='0154878909',@address='4 vo thi sau, cau giay, ha noi'

--xoa khach hang
CREATE PROC xoa_customer
    @customerid smallint
AS 
BEGIN
	IF EXISTS (SELECT * FROM Customers WHERE CustomerID= @customerid)
	begin
		DELETE FROM Customers WHERE CustomerID = @customerid
		print 'xoa thong tin thanh cong'
	end
	else
	begin
		print 'khong ton tai thong tin'
	end
END
--sua khach hang
CREATE PROC sua_customer
	@customerid smallint,
	@name varchar(50),
	@mobile nvarchar(15),
	@address nvarchar(100)
as
	BEGIN
		UPDATE Customers
		SET Name=@name,Mobile=@mobile,Address=@address
		WHERE CustomerID=@customerid
	IF NOT EXISTS (SELECT * FROM Customers WHERE CustomerID = @customerid)
	BEGIN
		PRINT 'khong ton tai thong tin'
	END
	ELSE
	BEGIN
		PRINT 'sua thong tin thanh cong'
	END
    END
--them saleorder
CREATE PROC them_saleorder
    @invoicenumber smallint,
	@invoicedate datetime,
	@customerid smallint,
	@quantity decimal,
	@grandtotal decimal,
	@net decimal,
	@cash decimal,
	@balance decimal
AS 
BEGIN
	IF EXISTS (SELECT * FROM SalesOrders WHERe invoiceNumber= @invoicenumber)
	BEGIN
		PRINT 'don hang da ton tai'
	END
	ELSE
	BEGIN
		INSERT INTO SalesOrders(invoiceNumber, invoiceDate, CustomerID,Quantity,GrandTotal,Net,Cash,Balance) 
		VALUES (@invoicenumber,@invoicedate,@customerid,@quantity,@grandtotal,@net,@cash,@balance)
		PRINT 'them khach hang thanh cong'
	END
END


exec them_saleorder @invoicenumber=10,@invoicedate='2022-09-08',@customerid=2002,@quantity=1,@grandtotal=700000,@net=null,@cash=500000,@balance=null
exec them_saleorder @invoicenumber=11,@invoicedate='2022-05-12',@customerid=2003,@quantity=1,@grandtotal=25000000,@net=null,@cash=25000000,@balance=null
exec them_saleorder @invoicenumber=12,@invoicedate='2022-12-03',@customerid=2004,@quantity=1,@grandtotal=200000,@net=null,@cash=200000,@balance=null
exec them_saleorder @invoicenumber=13,@invoicedate='2022-01-08',@customerid=2005,@quantity=1,@grandtotal=2100000,@net=null,@cash=1000000,@balance=null
--sua saleorder
CREATE PROC sua_saleorder
    @invoicenumber smallint,
	@invoicedate datetime,
	@customerid smallint,
	@quantity decimal,
	@grandtotal decimal,
	@net decimal,
	@cash decimal,
	@balance decimal
as
	BEGIN
		UPDATE SalesOrders
		SET invoiceDate=@invoicedate,CustomerID=@customerid,Quantity=@quantity,GrandTotal=@grandtotal,Net=@net,Cash=@cash,Balance=@balance
		WHERE invoiceNumber=@invoicenumber
	IF NOT EXISTS (SELECT * FROM SalesOrders WHERE invoiceNumber = @invoicenumber)
	BEGIN
		PRINT 'khong ton tai thong tin'
	END
	ELSE
	BEGIN
		PRINT 'sua thong tin thanh cong'
	END
    END
--xoa saleorder
CREATE PROC xoa_saleorder
    @invoicenumber smallint
as
BEGIN
	IF EXISTS (SELECT * FROM SalesOrders WHERE invoiceNumber= @invoicenumber)
	begin
		DELETE FROM SalesOrders WHERE invoiceNumber = @invoicenumber
		print 'xoa thong tin thanh cong'
	end
	else
	begin
		print 'khong ton tai thong tin'
	end
END
--them saleorderdetail
create proc them_saleorferdetail
	@detailid smallint,
	@invoicenumber smallint,
	@stockID smallint,
	@price decimal,
	@quantity smallint,
	@totalprice decimal
AS 
BEGIN
	IF EXISTS (SELECT * FROM SalesOrderDetails WHERe DetailID= @detailid)
	BEGIN
		PRINT 'don hang da ton tai'
	END
	ELSE
	BEGIN
		INSERT INTO SalesOrderDetails(DetailID,invoiceNumbers,StockID,Price,Quantity,TotalPrice) 
		VALUES (@detailid,@invoicenumber,@stockID,@price,@quantity,@totalprice)
		PRINT 'them thong tin thanh cong'
	END
END


select * from SalesOrders
select * from Stock
exec them_saleorferdetail @detailid=1,@invoicenumber=10,@stockID=1,@price=700000,@quantity=1,@totalprice=700000
exec them_saleorferdetail @detailid=2,@invoicenumber=11,@stockID=2,@price=25000000,@quantity=1,@totalprice=25000000
exec them_saleorferdetail @detailid=3,@invoicenumber=12,@stockID=3,@price=200000,@quantity=1,@totalprice=200000
exec them_saleorferdetail @detailid=4,@invoicenumber=13,@stockID=4,@price=2100000,@quantity=1,@totalprice=2100000
--sua saleorderdetail
create proc sua_saleorferdetail
	@detailid smallint,
	@invoicenumber smallint,
	@stockID smallint,
	@price decimal,
	@quantity smallint,
	@totalprice decimal
as
	BEGIN
		UPDATE SalesOrderDetails
		SET invoiceNumbers=@invoicenumber,StockID=@stockID,Price=@price,Quantity=@quantity,TotalPrice=@totalprice
		WHERE DetailID=@detailid
	IF NOT EXISTS (SELECT * FROM SalesOrderDetails WHERE DetailID = @detailid)
	BEGIN
		PRINT 'khong ton tai thong tin'
	END
	ELSE
	BEGIN
		PRINT 'sua thong tin thanh cong'
	END
    END
--xoa saleorderdetail
create proc xoa_saleorferdetail
	@detailid smallint
AS 
BEGIN
	IF EXISTS (SELECT * FROM SalesOrderDetails WHERE DetailID= @detailid)
	begin
		DELETE FROM SalesOrderDetails WHERE DetailID = @detailid
		print 'xoa thong tin thanh cong'
	end
	else
	begin
		print 'khong ton tai thong tin'
	end
END
--sua listpricedata
create proc sua_listtypedata
	@listtypedataid smallint,
	@listtypeid smallint,
	@decreption nvarchar(100)
as
	BEGIN
		UPDATE ListTypesData
		SET ListTypeID= @listtypeid,Description= @decreption
		WHERE ListTypeDataID =@listtypedataid
	IF NOT EXISTS (SELECT * FROM ListTypesData WHERE ListTypeDataID = @listtypedataid)
	BEGIN
		PRINT 'khong ton tai thong tin'
	END
	ELSE
	BEGIN
		PRINT 'sua thong tin thanh cong'
	END
    END
--them listpricedata
create proc them_listtypedata
	@listtypedataid smallint,
	@listtypeid smallint,
	@decreption nvarchar(100)
AS 
BEGIN
	IF EXISTS (SELECT * FROM ListTypesData WHERe ListTypeDataID= @listtypedataid)
	BEGIN
		PRINT ' da ton tai'
	END
	ELSE
	BEGIN
		INSERT INTO ListTypesData(ListTypeDataID,ListTypeID,Description) 
		VALUES (@listtypedataid,@listtypeid,@decreption)
		PRINT 'them thong tin thanh cong'
	END
END
SET IDENTITY_INSERT [QLBH].[dbo].[ListTypesData] ON;
set IDENTITY_INSERT [QLBH].[dbo].[ListTypes] OFF;
exec them_listtypedata @listtypedataid=1,@listtypeid=1,@decreption=null
exec them_listtypedata @listtypedataid=2,@listtypeid=2,@decreption=null
exec them_listtypedata @listtypedataid=3,@listtypeid=3,@decreption=null
exec them_listtypedata @listtypedataid=4,@listtypeid=4,@decreption=null

--xoa listpricedata
create proc xoa_listtypedata
	@listtypedataid smallint
AS 
BEGIN
	IF EXISTS (SELECT * FROM ListTypesData WHERE ListTypeDataID= @listtypedataid)
	begin
		DELETE FROM ListTypesData WHERE ListTypeDataID = @listtypedataid
		print 'xoa thong tin thanh cong'
	end
	else
	begin
		print 'khong ton tai thong tin'
	end
END
--them listtype
create proc them_listtype
	@listtypeid smallint,
	@decreption nvarchar(100)
AS 
BEGIN
	IF EXISTS (SELECT * FROM ListTypes WHERe ListTypeID= @listtypeid)
	BEGIN
		PRINT ' da ton tai'
	END
	ELSE
	BEGIN
		INSERT INTO ListTypes(ListTypeID,Description) 
		VALUES (@listtypeid,@decreption)
		PRINT 'them thong tin thanh cong'
	END
END

exec them_listtype @listtypeid=1,@decreption=null
exec them_listtype @listtypeid=2,@decreption=null
exec them_listtype @listtypeid=3,@decreption=null
exec them_listtype @listtypeid=4,@decreption=null
--xoa listtype
create proc xoa_listtype
	@listtypeid smallint
AS 
BEGIN
	IF EXISTS (SELECT * FROM ListTypes WHERE ListTypeID= @listtypeid)
	begin
		DELETE FROM ListTypes WHERE ListTypeID = @listtypeid
		print 'xoa thong tin thanh cong'
	end
	else
	begin
		print 'khong ton tai thong tin'
	end
END
--sua listtype
create proc sua_listtype
	@listtypeid smallint,
	@decreption nvarchar(100)
as
	BEGIN
		UPDATE ListTypes
		SET Description= @decreption
		WHERE ListTypeID =@listtypeid
	IF NOT EXISTS (SELECT * FROM ListTypes WHERE ListTypeID = @listtypeid)
	BEGIN
		PRINT 'khong ton tai thong tin'
	END
	ELSE
	BEGIN
		PRINT 'sua thong tin thanh cong'
	END
    END
--them stock
create proc them_stock
	@stockid smallint,
	@productid smallint,
	@sizeid smallint,
	@quantity smallint,
	@purchaseprice decimal,
	@saleprice decimal
AS 
BEGIN
	IF EXISTS (SELECT * FROM Stock WHERe StockID= @stockid)
	BEGIN
		PRINT ' da ton tai'
	END
	ELSE
	BEGIN
		INSERT INTO Stock(StockID,ProductID,SizeID,Quantity,PurchasePrice,SalesPrice) 
		VALUES (@stockid,@productid,@sizeid,@quantity,@purchaseprice,@saleprice)
		PRINT 'them thong tin thanh cong'
	END
END

select * from Products
exec them_stock @stockid =1,@productid=1,@sizeid=321,@quantity=1,@purchaseprice=700000,@saleprice=10
exec them_stock @stockid =2,@productid=2,@sizeid=322,@quantity=1,@purchaseprice=25000000,@saleprice=null
exec them_stock @stockid =3,@productid=3,@sizeid=323,@quantity=1,@purchaseprice=200000,@saleprice=null
exec them_stock @stockid =4,@productid=4,@sizeid=324,@quantity=1,@purchaseprice=2100000,@saleprice=20
--sua stock
create proc sua_stock
	@stockid smallint,
	@productid smallint,
	@sizeid smallint,
	@quantity smallint,
	@purchaseprice decimal,
	@saleprice decimal
as
	BEGIN
		UPDATE Stock
		SET ProductID=@productid,SizeID=@sizeid,Quantity=@quantity,PurchasePrice=@purchaseprice,SalesPrice=@saleprice
		WHERE StockID=@stockid
	IF NOT EXISTS (SELECT * FROM Stock WHERE StockID = @stockid)
	BEGIN
		PRINT 'khong ton tai thong tin'
	END
	ELSE
	BEGIN
		PRINT 'sua thong tin thanh cong'
	END
    END
--xoa stock
create proc xoa_stock
	@stockid smallint
AS 
BEGIN
	IF EXISTS (SELECT * FROM Stock WHERE StockID= @stockid)
	begin
		DELETE FROM Stock WHERE StockID = @stockid
		print 'xoa thong tin thanh cong'
	end
	else
	begin
		print 'khong ton tai thong tin'
	end
END
-----------------------------------------------------------------------
use master 
/*kich ban backup database
-backup full 12h vao sang thu2 (1 lan trong ngay)
-differences backup 6h vao moi sang thu5 (1 lan trong ngay)
-log backup tai cac thoi diem 6h5,6h30,7h va 7h15 (4 lan trong ngay)
Truong mat dien vao luc 6h20 bi mat du lieu thi kich ban phuc hoi nhu sau:
	+backup full vao 12h sang thu2
	+sau do differences backup vao thoi diem 6h sang thu nam
	+cuoi cung log backup luc 6h30
*/

--dau tien full backup
BACKUP DATABASE [QLBH] 
TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\QLBH.bak' 
WITH NOFORMAT, NOINIT,  NAME = N'QLBH-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
select * from [QLBH].[dbo].[Products]
--them du lieu moi cho bang product
set IDENTITY_INSERT QLBH.dbo.Products ON;
set IDENTITY_INSERT QLBH.dbo.ListTypesData off;
exec them_product @productid =6,@name='may tinh pc',@categoryid=116,@supplieid=128,@purchaseprice=20000000,@saleprice=null
select * from QLBH.dbo.Products

--thuc hien different backup
BACKUP DATABASE [QLBH] 
TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\QLBH_diff.bak' 
WITH  DIFFERENTIAL , NOFORMAT, NOINIT,  NAME = N'QLBH-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
--them du lieu cho bang customer
set IDENTITY_INSERT QLBH.dbo.Customers ON;
set IDENTITY_INSERT QLBH.dbo.Products off;
select * from QLBH.dbo.Customers
exec them_customer @customerid =2006,@name='le van tam',@mobile='0945432345',@address='20 ngo tat to,tphcm'

--log backup
USE [master];
ALTER DATABASE [QLBH] 
SET RECOVERY FULL;
BACKUP log [QLBH] 
TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\QLBH_log.bak' 
WITH NOFORMAT, NOINIT,  NAME = N'DA-log Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
--gia su bi mat dien
--restore database
--dau tien ta restore tu fullbackup tai thoi diem 12h thu 2(sao luu full khong sao luu bang khac)
USE [master]
RESTORE DATABASE [QLBH] 
FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\QLBH.bak' 
WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 5
GO
select * from QLBH.dbo.Products
--dau tien ta restore tu fullbackup tai thoi diem 12h thu 2
USE [master]
RESTORE DATABASE [QLBH] 
FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\QLBH.bak' 
WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  REPLACE,  STATS = 5 /*norecovery neu muon sao luu bang khac*/
GO
--tiep theo sao luu du lieu diffbackup vao 6h sang t5
--restore with norecovey(sao luu neu con muon sao luu bang khac)
USE [master]
RESTORE DATABASE [QLBH] 
FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\QLBH_diff.bak' 
WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  REPLACE,  STATS = 5
GO
--restore log with norecovery (data base phai o che do full khong phair simple)
--sao luu tai thoi diem logbackup gan nhat vao luc 6h30 se lay lai duoc du lieu
RESTORE LOG [QLBH] 
FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\QLBH_log.bak' 
WITH  FILE = 1,  NOUNLOAD,  STATS = 10
GO
select * from [dbo].[Customers]
select * from [dbo].[Products]
----------------------------------------------------------------------------------
--transaction
begin transaction 
begin try
	--goi store procedure
	exec sua_product @productid=1,@name='chuot co day',@categoryid=111,@supplieid=123,@purchaseprice=4000000,@saleprice=null 
	--kiem tra khong co loi thi commit
	commit;
end try
begin catch
	--neu loi thi rollback
	rollback;
	--in thong tin loi
	print 'khong the sua thong tin'
end catch;
select * from [dbo].[Products]
-------------------------------------------------------
--phan quyen 
--quyen admin co quyen truy cap cac database
USE [master]
GO
CREATE LOGIN [admin] WITH PASSWORD=N'1' MUST_CHANGE, DEFAULT_DATABASE=[master], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO
USE [QLBH]
GO
CREATE USER [admin] FOR LOGIN [admin]
GO
USE [QLBH]
GO
ALTER ROLE [db_owner] ADD MEMBER [admin]
GO
--phan quyen cho bo phan ban hang (custommer,saleorders,saleorderDetail)
--bo phan ban hang chua co quyen thao tac database
USE [master]
GO
CREATE LOGIN [banhang] WITH PASSWORD=N'1', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO
USE [QLBH]
GO
CREATE USER [banhang] FOR LOGIN [banhang]
GO
--phan quyen cho bo phan kho (products,productSize)
USE [master]
GO
CREATE LOGIN [kho] WITH PASSWORD=N'1', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO
USE [QLBH]
GO
CREATE USER [kho] FOR LOGIN [kho]
GO
--phan quyen cho bo phan ke toan (stock,listtypes,listtypeData)
USE [master]
GO
CREATE LOGIN [ketoan] WITH PASSWORD=N'1', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO
USE [QLBH]
GO
CREATE USER [ketoan] FOR LOGIN [ketoan]
GO
--cap quyen tao co so du lieu cho bo phan kho
grant alter any database to kho
--Câu lệnh cấp quyền tạo bảng cho bo phan kho
grant create table to kho
--cap quyen tao co so du lieu cho bo phan ban hang
--revoke alter any database to banhang
grant alter any database to banhang
--Câu lệnh cấp quyền tạo bảng cho bo phan ban hang
grant create table to banhang
--cap quyen tao co so du lieu cho bo phan ke toan
grant alter any database to kho
--Câu lệnh cấp quyền tạo bảng cho bo phan ke toan
grant create table to kho

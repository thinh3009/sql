--datetime
USE [HOCSINH]
CREATE TABLE [dbo].[ThucPham](
	[soLuong] [int] NULL,
	[TenSP] [nvarchar](100) NULL,
	[PhanLoai] [nvarchar](50) NULL,
	[NgayNhap] [datetime] NULL
) ON [PRIMARY]
drop table ThucPham
insert into ThucPham values (2,'com chien','thuc pham','2021-09-23 10:30:15')
select * from ThucPham
--cong them ngay bang ham datedate
select getdate(),dateadd(day,-365,getdate())
--cong them thang
select getdate(),dateadd(month,3,getdate())
--datediff:lay khoang cach giua cac ngay
select DATEDIFF(day,GETDATE(),'2022-12-31')
--datepart:lay 1 phan cuar ngay thang
select DATEPART(month,getdate())
--getutdate:lay mui gio chuan
select GETUTCDATE()

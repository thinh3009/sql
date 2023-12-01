use QuanLyBanHang
create table SanPham
(
	MaSP int primary key,
	MaLoai int ,
	TenSP nvarchar (50)
)
alter table SanPham
add DonGia int not null;
create table LoaiSP
(
	MaLoai int primary key,
	TenLoai varchar(50),
	KieuLoai varchar(50),
)
create table NguoiBan
(
	MaNguoiBan int primary key,
	MaSP int,
	TenNguoiBan nvarchar(100),
	ThongTinLienHe varchar(50)
)

--create table BaoCaoBanHang 
--(
--	MaBaoCao int primary key,
--	MaKhachHang int,
--	MaDatHang int,
--	MaSP int,
--	MaThanhToan int,
--	NgayThanhToan date,
--)

create table DatHang 
(
	MaDatHang int primary key,
	MaKhachHang int,
	NgayDat  date,
)

create table VanChuyen
(
	MaVanChuyen int,
	MaDatHang int,
	MaKhachHang int,
	MaSP int,
	NgayVanChuyen date,
)
create table KhachHang 
(
	MaKhachHang int primary key,
	TenKhachHang nvarchar(100),
	ThongTinLienlac int,
	DiaChi nvarchar(100)
)
create table ThanhToan
(
	MaThanhToan int primary key,
	MaKhachHang int,
	PhuongThucThanhToan varchar(50),
	NgayThanhToan date,
)

create table username
(
	username nvarchar(100) primary key,
	[password] nvarchar(100) 
)

--foreign key
alter table NguoiBan
add constraint FK_NguoiBan_Masp foreign key (MaSP) references SanPham(MaSP)

alter table SanPham
add constraint FK_SanPham_MaLoai foreign key (MaLoai) references LoaiSP(MaLoai)

/*alter table BaoCaoBanHang 
add constraint FK_BaoCaoBanHang_MaKhachHang foreign key (MaKhachHang) references VanChuyen(date)*/
alter table VanChuyen 
add constraint FK_VanChuyen_MaDatHang foreign key (MaDatHang) references DatHang(MaDatHang)

alter table VanChuyen
add constraint FK_VanChuyen_MaKhachHang foreign key (MaKhachHang) references KhachHang(MaKhachHang)

--alter table BaoCaoBanHang 
--add constraint FK_BaoCaoBanHang_MaKhachHang foreign key (MaKhachHang) references KhachHang(MaKhachHang)

--alter table BaoCaoBanHang 
--add constraint FK_BaoCaoBanHang_MaThanhToan foreign key (MaThanhToan) references ThanhToan(MaThanhToan)

ALTER TABLE VanChuyen
ADD PRIMARY KEY ([MaVanChuyen]);

ALTER TABLE dbo.VanChuyen
ALTER COLUMN MaVanChuyen int NOT NULL

--procedure
--them loai hang
create proc them_LoaiSP
	@maloai int,
	@tenloai varchar(50),
	@kieuloai nvarchar(50)
AS 
BEGIN
	IF EXISTS (SELECT * FROM LoaiSP WHERE MaLoai = @maloai)
	BEGIN
		PRINT 'loai hang da ton tai'
	END
	ELSE
	BEGIN
		INSERT INTO LoaiSP(MaLoai, TenLoai, KieuLoai) VALUES (@maloai, @tenloai, @kieuloai)
		PRINT 'ghi loai hang thanh cong'
	END
END
exec them_LoaiSP @maloai=1,@tenloai='ghe',@kieuloai='do gia dung'
exec them_LoaiSP @maloai=2,@tenloai='ban',@kieuloai='do gia dung'
exec them_LoaiSP @maloai=3,@tenloai='xe',@kieuloai='phuong tien di lai'
exec them_LoaiSP @maloai=4,@tenloai='may tinh',@kieuloai='thiet bi dien tu'
exec them_LoaiSP @maloai=5,@tenloai='lo',@kieuloai='do gia dung'
exec them_LoaiSP @maloai=6,@tenloai='banh',@kieuloai='banh keo'

--cap nhat loai hang
alter procedure sua_LoaiSP 
	@maloai smallint,
    @tenloai varchar(50),
    @kieuloai varchar(50)
as
	BEGIN
		UPDATE LoaiSP 
		SET TenLoai = @tenloai,KieuLoai =@kieuloai 
		WHERE MaLoai = @maloai
	IF NOT EXISTS (SELECT * FROM LoaiSP WHERE MaLoai = @maloai)
	BEGIN
		PRINT 'khong ton tai ban ghi'
	END
	ELSE
	BEGIN
		PRINT 'sua don thanh cong'
	END
    END
--xoa loai hang
create procedure xoa_LoaiSP 
	@maloai smallint   
as
BEGIN
	IF EXISTS (SELECT * FROM LoaiSP WHERE MaLoai = @maloai)
	begin
		DELETE FROM LoaiSP WHERE MaLoai = @maloai
		print 'xoa loai san pham thanh cong'
	end
	else
	begin
		print 'khong ton tai thong tin'
	end
END
exec xoa_LoaiSP @maloai =4

--them san pham
select * from SanPham
alter proc them_SanPham
	@masp int,
	@maloai int,
	@tensp nvarchar(50),
	@dongia int
AS 
BEGIN
	IF EXISTS (SELECT * FROM SanPham WHERE MaSP = @masp)
	BEGIN
		PRINT 'san pham da ton tai'
	END
	ELSE
	BEGIN
		INSERT INTO SanPham(MaSP, MaLoai, TenSP,DonGia) VALUES (@masp, @maloai, @tensp,@dongia)
		PRINT 'them san pham thanh cong'
	END
END
exec them_SanPham @masp=1,@maloai=1,@tensp='ghe cong thai hoc',@dongia='2500000'
exec them_SanPham @masp=2,@maloai=2,@tensp='ban mini',@dongia='15000'
exec them_SanPham @masp=3,@maloai=3,@tensp='xe dap tre em',@dongia='300000'
exec them_SanPham @masp=4,@maloai=4,@tensp='may laptop acer nitro 15',@dongia='25000000'
exec them_SanPham @masp=5,@maloai=5,@tensp='lo vi song',@dongia='5000000'
exec them_SanPham @masp=6,@maloai=6,@tensp='banh quy bo danisa',@dongia='120000'

--xoa san pham
alter PROCEDURE xoa_sanpham
	@masp SMALLINT
AS 
BEGIN
	IF EXISTS (SELECT * FROM SanPham WHERE MaSP = @masp)
	begin
		DELETE FROM SanPham WHERE MaSP = @masp
		print 'xoa san pham thanh cong'
	end
	else
	begin
		print 'khong ton tai san pham de xoa'
	end
END
--cap nhat san pham
alter procedure sua_sanpham
	@masp smallint,
    @maloai smallint,
    @tensp varchar(50),
	@dongia int 

as
	BEGIN
		UPDATE SanPham 
		SET MaLoai=@maloai,TenSP=@tensp,DonGia=@dongia
		WHERE MaSP = @masp
	IF NOT EXISTS (SELECT * FROM SanPham WHERE MaSP = @masp)
	BEGIN
		PRINT 'khong ton tai san pham'
	END
	ELSE
	BEGIN
		PRINT 'sua san pham thanh cong'
	END
    END
--them nguoi ban
alter proc them_nguoiban
	@manguoiban smallint,
	@masp smallint,
	@tennguoiban varchar(50),
	@thongtinlienhe varchar(50)
AS 
BEGIN
	IF EXISTS (SELECT * FROM NguoiBan WHERE MaNguoiBan = @manguoiban)
	BEGIN
		PRINT 'da ton tai'
	END
	ELSE
	BEGIN
		INSERT INTO NguoiBan(MaNguoiBan, MaSP, TenNguoiBan,ThongTinLienHe) VALUES (@manguoiban, @masp, @tennguoiban,@thongtinlienhe)
		PRINT 'them thong tin nguoi ban thanh cong'
	END
END
exec them_nguoiban @manguoiban=1,@masp=1,@tennguoiban='nguyen van linh',@thongtinlienhe='0983456789'
exec them_nguoiban @manguoiban=2,@masp=2,@tennguoiban='le van hung',@thongtinlienhe='014598345'
exec them_nguoiban @manguoiban=3,@masp=3,@tennguoiban='bui van tuan',@thongtinlienhe='0342345565'
exec them_nguoiban @manguoiban=4,@masp=4,@tennguoiban='nguyen manh hung',@thongtinlienhe='0145673454'
exec them_nguoiban @manguoiban=5,@masp=5,@tennguoiban='ha van nam',@thongtinlienhe='0543567832'
exec them_nguoiban @manguoiban=6,@masp=6,@tennguoiban='le thi ha',@thongtinlienhe='0245435643'

--cap nhat nguoi ban
create proc sua_nguoiban
	@manguoiban smallint,
	@masp smallint,
	@tennguoiban varchar(50),
	@thongtinlienhe varchar(50)
as
	BEGIN
		UPDATE NguoiBan 
		SET MaSP=@masp,TenNguoiBan=@tennguoiban,ThongTinLienHe=@thongtinlienhe
		WHERE MaNguoiBan = @manguoiban
	IF NOT EXISTS (SELECT * FROM NguoiBan WHERE MaNguoiBan = @manguoiban)
	BEGIN
		PRINT 'khong ton tai nguoi ban'
	END
	ELSE
	BEGIN
		PRINT 'sua thong tin nguoi ban thanh cong'
	END
    END
--xoa nguoi ban
create proc xoa_nguoiban
	@manguoiban smallint
AS 
BEGIN
	IF EXISTS (SELECT * FROM NguoiBan WHERE MaNguoiBan= @manguoiban)
	begin
		DELETE FROM NguoiBan WHERE MaNguoiBan = @manguoiban
		print 'xoa thong tin thanh cong'
	end
	else
	begin
		print 'khong ton tai thong tin'
	end
end
--cap nhat van chuyen
create proc sua_vanchuyen
	@mavanchuyen smallint,
	@madathang smallint,
	@makhachhang int,
	@masp int,
	@ngayvanchuyen date
as
	BEGIN
		UPDATE VanChuyen
		SET MaDatHang=@madathang,MaKhachHang=@makhachhang,MaSP=@masp,NgayVanChuyen=@ngayvanchuyen
		WHERE MaVanChuyen=@mavanchuyen
	IF NOT EXISTS (SELECT * FROM VanChuyen WHERE MaVanChuyen = @mavanchuyen)
	BEGIN
		PRINT 'khong ton tai ma van chuyen'
	END
	ELSE
	BEGIN
		PRINT 'sua thong tin van chuyen thanh cong'
	END
    END
--xoa van chuyen
create proc xoa_vanChuyen
	@mavanchuyen smallint,
	@madathang smallint,
	@makhachhang int,
	@masp int,
	@ngayvanchuyen date
AS 
BEGIN
	IF EXISTS (SELECT * FROM vanchuyen WHERE MaVanChuyen= @mavanchuyen)
	begin
		DELETE FROM VanChuyen WHERE MaVanChuyen = @mavanchuyen
		print 'xoa thong tin thanh cong'
	end
	else
	begin
		print 'khong ton tai thong tin'
	end
END

--them van chuyen
create proc them_vanchuyen
	@mavanchuyen smallint,
	@madathang smallint,
	@makhachhang int,
	@masp int,
	@ngayvanchuyen date
AS 
BEGIN
	IF EXISTS (SELECT * FROM VanChuyen WHERE MaVanChuyen = @mavanchuyen)
	BEGIN
		PRINT 'ma van chuyen da ton tai'
	END
	--else if not exists (select * from )
	ELSE
	BEGIN
		INSERT INTO VanChuyen(MaVanChuyen, MaDatHang, MaKhachHang,MaSP,NgayVanChuyen) VALUES (@mavanchuyen,@madathang, @makhachhang, @masp,@ngayvanchuyen)
		PRINT 'them don van chuyen thanh cong'
	END
END
select * from DatHang
select * from SanPham
exec them_vanchuyen @mavanchuyen=123,@madathang=101,@makhachhang=2002,@masp=1,@ngayvanchuyen='2022-09-30'
exec them_vanchuyen @mavanchuyen=124,@madathang=102,@makhachhang=2005,@masp=2,@ngayvanchuyen='2022-10-13'
exec them_vanchuyen @mavanchuyen=125,@madathang=103,@makhachhang=2001,@masp=3,@ngayvanchuyen='2022-03-25'
exec them_vanchuyen @mavanchuyen=126,@madathang=104,@makhachhang=2006,@masp=4,@ngayvanchuyen='2022-04-19'
exec them_vanchuyen @mavanchuyen=127,@madathang=105,@makhachhang=2003,@masp=5,@ngayvanchuyen='2022-09-10'
exec them_vanchuyen @mavanchuyen=128,@madathang=106,@makhachhang=2004,@masp=6,@ngayvanchuyen='2022-01-20'
select * from VanChuyen
/*--them bao cao
create proc them_baocao
	@mabaocao smallint,
	@makhachhang smallint,
	@madathang smallint,
	@masp smallint,
	@mathanhtoan smallint,
	@ngaythanhtoan date
AS 
BEGIN
	IF EXISTS (SELECT * FROM BaoCaoBanHang WHERE MaBaoCao = @mabaocao)
	BEGIN
		PRINT 'ma bao cao da ton tai'
	END
	ELSE
	BEGIN
		INSERT INTO BaoCaoBanHang(MaBaoCao,MaKhachHang, MaDatHang, MaSP,MaThanhToan,NgayThanhToan) VALUES (@mabaocao,@makhachhang, @madathang, @masp,@mathanhtoan,@ngaythanhtoan)
		PRINT 'them bao cao thanh cong'
	END
END
exec them_baocao @mabaocao=1,@makhachhang=

--sua bao cao
create proc sua_baocao
	@mabaocao smallint,
	@makhachhang smallint,
	@madathang smallint,
	@masp smallint,
	@mathanhtoan smallint,
	@ngaythanhtoan date
as
	BEGIN
		UPDATE BaoCaoBanHang
		SET MaKhachHang=@makhachhang,MaDatHang=@madathang,MaSP=@masp,MaThanhToan=@mathanhtoan,NgayThanhToan=@ngaythanhtoan
		WHERE MaBaoCao=@mabaocao
	IF NOT EXISTS (SELECT * FROM BaoCaoBanHang WHERE MaBaoCao = @mabaocao)
	BEGIN
		PRINT 'khong ton tai ma bao cao'
	END
	ELSE
	BEGIN
		PRINT 'sua thong tin bao cao thanh cong'
	END
    END
--xoa bao cao
create proc xoa_baocao
	@mabaocao smallint
AS 
BEGIN
	IF EXISTS (SELECT * FROM BaoCaoBanHang WHERE MaBaoCao= @mabaocao)
	begin
		DELETE FROM BaoCaoBanHang WHERE MaBaoCao = @mabaocao
		print 'xoa bao cao thanh cong'
	end
	else
	begin
		print 'khong ton tai thong tin'
	end
END*/
--them dat hang
create proc them_dathang
	@madathang smallint,
	@makhachhang smallint,
	@ngaydat date
as
BEGIN
	IF EXISTS (SELECT * FROM DatHang WHERE MaDatHang = @madathang)
	BEGIN
		PRINT 'ma dat hang da ton tai'
	END
	ELSE
	BEGIN
		INSERT INTO DatHang(MaDatHang,MaKhachHang,NgayDat) VALUES (@madathang,@makhachhang,@ngaydat)
		PRINT 'them thanh cong'
	END
END
exec them_dathang @madathang=101,@makhachhang=2002,@ngaydat='2022-09-09'
exec them_dathang @madathang=102,@makhachhang=2005,@ngaydat='2022-09-12'
exec them_dathang @madathang=103,@makhachhang=2001,@ngaydat='2022-03-16'
exec them_dathang @madathang=104,@makhachhang=2006,@ngaydat='2022-04-04'
exec them_dathang @madathang=105,@makhachhang=2003,@ngaydat='2022-09-05'
exec them_dathang @madathang=106,@makhachhang=2004,@ngaydat='2022-01-12'

--sua dat hang
create proc sua_dathang
	@madathang smallint,
	@makhachhang smallint,
	@ngaydat date
as
	BEGIN
		UPDATE DatHang
		SET MaKhachHang=@makhachhang,NgayDat=@ngaydat
		WHERE MaDatHang=@madathang
	IF NOT EXISTS (SELECT * FROM DatHang WHERE MaDatHang = @madathang)
	BEGIN
		PRINT 'khong ton tai ma dat hang'
	END
	ELSE
	BEGIN
		PRINT 'sua thong tin dat hang thanh cong'
	END
    END

--xoa dat hang
create proc xoa_dathang
	@madathang smallint
AS 
BEGIN
	IF EXISTS (SELECT * FROM DatHang WHERE MaDatHang= @madathang)
	begin
		DELETE FROM DatHang WHERE MaDatHang = @madathang
		print 'xoa dat hang thanh cong'
	end
	else
	begin
		print 'khong ton tai thong tin'
	end
END
--them khach hang
create proc them_khachhang
	@makhachhang smallint,
	@tenkhachhang varchar(50),
	@thongtinlienlac int,
	@diachi nvarchar(100)
as
BEGIN
	IF EXISTS (SELECT * FROM KhachHang WHERE MaKhachHang = @makhachhang)
	BEGIN
		PRINT 'ma khach hang da ton tai'
	END
	ELSE
	BEGIN
		INSERT INTO KhachHang(MaKhachHang,TenKhachHang,ThongTinLienlac,DiaChi) VALUES (@makhachhang,@tenkhachhang,@thongtinlienlac,@diachi)
		PRINT 'them thong tin khach hang thanh cong'
	END
END
exec them_khachhang @makhachhang=2001,@tenkhachhang='bui duc thinh',@thongtinlienlac=0919123543,@diachi='2 binh hung hoa,dong nai'
exec them_khachhang @makhachhang=2002,@tenkhachhang='tran thanh duy',@thongtinlienlac=0834323432,@diachi='12 xo viet nghe tinh,tphcm'
exec them_khachhang @makhachhang=2003,@tenkhachhang='ho hiep phat',@thongtinlienlac=0343657832,@diachi='123/12 vo thi sau, q1, tphcm'
exec them_khachhang @makhachhang=2004,@tenkhachhang='trinh minh dien',@thongtinlienlac=0454438956,@diachi='34 le van viet,ha noi'
exec them_khachhang @makhachhang=2005,@tenkhachhang='tran van minh',@thongtinlienlac=0445654367,@diachi='345 nguyen gia tri,tphcm'
exec them_khachhang @makhachhang=2006,@tenkhachhang='le van tam',@thongtinlienlac=0654453267,@diachi='5 nguyen van troi,da nang'
--sua khach hang
create proc sua_khachhang
	@makhachhang smallint,
	@tenkhachhang varchar(50),
	@thongtinlienlac int,
	@diachi nvarchar(100)
as
	BEGIN
		UPDATE KhachHang
		SET TenKhachHang=@tenkhachhang,ThongTinLienlac=@thongtinlienlac
		WHERE MaKhachHang=@makhachhang
	IF NOT EXISTS (SELECT * FROM KhachHang WHERE MaKhachHang = @makhachhang)
	BEGIN
		PRINT 'khong ton tai ma khach hang'
	END
	ELSE
	BEGIN
		PRINT 'sua thong tin khach hang thanh cong'
	END
    END
--xoa thong tin khach hang
create proc xoa_khachhang
	@makhachhang smallint
AS 
BEGIN
	IF EXISTS (SELECT * FROM KhachHang WHERE MaKhachHang= @makhachhang)
	begin
		DELETE FROM KhachHang WHERE MaKhachHang = @makhachhang
		print 'xoa thong tin khach hang thanh cong'
	end
	else
	begin
		print 'khong ton tai thong tin'
	end
END

--them thanh toan
create proc them_thanhtoan
	@mathanhtoan smallint,
	@makhachhang smallint,
	@phuongthucthanhtoan varchar(50),
	@ngaythanhtoan date
as
BEGIN
	IF EXISTS (SELECT * FROM ThanhToan WHERE MaThanhToan = @mathanhtoan)
	BEGIN
		PRINT 'ma thanh toan da ton tai'
	END
	ELSE
	BEGIN
		INSERT INTO ThanhToan(MaThanhToan,MaKhachHang,PhuongThucThanhToan,NgayThanhToan) VALUES (@mathanhtoan,@makhachhang,@phuongthucthanhtoan,@ngaythanhtoan)
		print 'them thong tin thanh toan thanh cong'
	END
END
select * from KhachHang
select * from DatHang
select * from VanChuyen
exec them_thanhtoan @mathanhtoan =111,@makhachhang=2001,@phuongthucthanhtoan='the tin dung',@ngaythanhtoan='2022-09-09'
exec them_thanhtoan @mathanhtoan =112,@makhachhang=2002,@phuongthucthanhtoan='tien mat',@ngaythanhtoan='2022-09-30'
exec them_thanhtoan @mathanhtoan =113,@makhachhang=2003,@phuongthucthanhtoan='the ghi no',@ngaythanhtoan='2022-09-05'
exec them_thanhtoan @mathanhtoan =114,@makhachhang=2004,@phuongthucthanhtoan='the tin dung',@ngaythanhtoan='2022-01-12'
exec them_thanhtoan @mathanhtoan =115,@makhachhang=2005,@phuongthucthanhtoan='tien mat',@ngaythanhtoan='2022-10-13'
exec them_thanhtoan @mathanhtoan =116,@makhachhang=2006,@phuongthucthanhtoan='tien mat',@ngaythanhtoan='2022-04-19'
--sua thanh toan
create proc sua_thanhtoan
	@mathanhtoan smallint,
	@makhachhang smallint,
	@phuongthucthanhtoan varchar(50),
	@ngaythanhtoan date
as
	BEGIN
		UPDATE ThanhToan
		SET MaKhachHang=@makhachhang,PhuongThucThanhToan=@phuongthucthanhtoan
		WHERE MaThanhToan=@mathanhtoan
	IF NOT EXISTS (SELECT * FROM ThanhToan WHERE MaThanhToan = @mathanhtoan)
	BEGIN
		PRINT 'khong ton tai ma thanh toan'
	END
	ELSE
	BEGIN
		PRINT 'sua thong tin thanh toan thanh cong'
	END
    END
--xoa thanh toan
create proc xoa_thanhtoan
	@mathanhtoan smallint
AS 
BEGIN
	IF EXISTS (SELECT * FROM ThanhToan WHERE MaThanhToan= @mathanhtoan)
	begin
		DELETE FROM ThanhToan WHERE MaThanhToan = @mathanhtoan
		print 'xoa thong tin thanh toan thanh cong'
	end
	else
	begin
		print 'khong ton tai thong tin'
	end
END
--------------------------------------------------------------------------------
use master 
--backup test
BACKUP DATABASE [DA] 
TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\DA.bak' 
WITH NOFORMAT, NOINIT,  NAME = N'DA-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--them du lieu moi
insert into DA.dbo.DonDatHang values (129,'2002-10-03',4,2)
--gia su hu o cung hoac mat dien
USE [master];
ALTER DATABASE [DA] 
SET RECOVERY FULL;

BACKUP log [DA] 
TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\DA2.bak' 
WITH NOFORMAT, NOINIT,  NAME = N'DA-log Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
--restore
USE [master]
RESTORE DATABASE [DA] 
FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\DA.bak' 
WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 5
GO

--restore with norecovey(sao luu neu con muon sao luu bang khac)
USE [master]
RESTORE DATABASE [DA] 
FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\DA.bak' 
WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  REPLACE,  STATS = 5

GO

--restore log with norecovery (data base phai o che do full khong phair simple)
RESTORE LOG [DA] 
FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\DA2.bak' 
WITH  FILE = 1,  NOUNLOAD,  STATS = 10
GO
--phan quyen
select * from DA.dbo.DonDatHang

--admin
USE [master]
GO
CREATE LOGIN [admin] WITH PASSWORD=N'1' 
MUST_CHANGE, DEFAULT_DATABASE=[master], 
CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO

--transaction
create view v_loaisp 
as 
	select l.MaLoai,l.TenLoai,l.KieuLoai from QuanLyBanHang.dbo.LoaiSP l

create view v_sanpham
as
	select s.MaSP,s.MaLoai,s.TenSP,s.DonGia from QuanLyBanHang.dbo.SanPham s
select * from v_sanpham
--transaction
--lay cac san pham co gia duoi 1000000
select * from v_sanpham
alter proc them_SanPham
	@masp int,
	@maloai int,
	@tensp nvarchar(50),
	@dongia int
as
set nocount on;
begin transaction trans_themsp
if exists (select v.MaSP from v_sanpham v where v.MaSP=@masp )
	begin
		select * from v_sanpham where DonGia < 1000000
		print 'lay thanh cong san pham nho hon 1000000'
		commit
	end
else
	begin
		print 'khong co san pham nho hon 1000000'
		rollback
	end
----
select DonGia from v_sanpham
begin transaction;
declare @gia int
select p.DonGia from v_sanpham p
where p.DonGia < 1000000
if EXISTS (p.don)
	begin 
		update v_product
			set ListPrice = 15
			where Name like '%bike%'
		print N' da giam tat ca mat hang bike ve 15$'
		commit
	end
else
	begin
		print N'tong gia tri cua mat hang xe dap < tong gia tri tat ca mat hang'
		print N'khong giam gia mat hang bike'
		rollback
	end
go






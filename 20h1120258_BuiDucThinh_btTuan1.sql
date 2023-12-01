CREATE DATABASE SALES
use sales
--1.kieu du lieu tu dinh nghia
exec sp_addtype 'Mota', 'Nvarchar(40)'
exec sp_addtype 'IDKH', 'char(10)'
exec sp_addtype 'DT', 'char(12)'
--2. tao table
create table SanPham
(
	Masp char(6) not null,
	TenSp varchar(6),
	NgayNhap Date,
	DVT char(10),
	SoLuongTon Int,
	DonGiaNhap money,
)

create table HoaDon
(
	MaHD char(10) not null,
	NgayLap date,
	NgayGiao date,
	Makh IDKH,
	DienGiai Mota,
)

create table KhachHang
(
	MaKH IDKH not null,
	TenKH nvarchar(30),
	Diachi nvarchar(40),
	Dienthoai DT,
)

create table ChiTietHD
(
	MaHD char(10),
	Masp char(6),
	Soluong int,
)

--3.sua cot diengiai
alter table HoaDon
alter column DienGiai nvarchar(100)

--4
alter table SanPham
add TyLeHoaHong float

--5
alter table SanPham
drop column NgayNhap
--6
alter table SanPham add constraint PK_SanPham
primary key (MaSP)
alter table HoaDon add constraint PK_HoaDon
primary key (MaHD)
alter table KhachHang add constraint PK_KhachHang
primary key (MaKH)
alter table ChiTietHD add constraint PK_ChiTietHD
primary key (MaHD, MaSP)

alter table HoaDon add constraint fk_HoaDon
foreign key (MaKH) references KhachHang(MaKH)
on delete cascade on update cascade

alter table ChiTietHD add constraint fk_ChiTietHD_MaHD
foreign key (MaHD) references HoaDon(MaHD)
on delete cascade on update cascade

alter table ChiTietHD add constraint fk_ChiTietHD_MaSP
foreign key (MaSP) references SanPham(MaSP)
on delete cascade on update cascade
--7
--ngaygiao >= ngaylap
alter table HoaDon add constraint ck_HoaDon_NgayGiao 
check (NgayGiao >= NgayLap)
--Mahd gom 6 ky tu
alter table HoaDon add constraint ck_HoaDon_MaHD
check (MaHD like '[A-Z]{2}\d{4,}')--check (Mahd)
--gia tri mac dinh luon hien hanh
--alter table HoaDon
--add NgayLap date
alter table HoaDon add constraint df_HoaDon_NgayLap
default getdate() for NgayLap
alter table 
--8
--so luong ton nhap tu 0-500
alter table SanPham add constraint ck_SanPham
check (SoLuongTon between 0 and 500)
--don gia lon hon 0
alter table SanPham add constraint ck_SanPham_DonGiaNhap
check (DonGiaNhap > 0)
--ngaynhap la hien hanh
alter table SanPham
add NgayNhap date
alter table SanPham add constraint df_SanPham_NgayNhap
default getdate() for NgayNhap
--dvt
alter table SanPham 
add constraint in_DVT
check (DTV = 'kg', 'thung', 'cai', 'hop')
--9
--SanPham
select * from SanPham
truncate table SanPham
insert into SanPham (Masp,TenSp,DVT,SoLuongTon,DonGiaNhap,TyLeHoaHong,NgayNhap) values ('20h11', 'socola','hop',4,200000,3,GETDATE())
insert into SanPham (Masp,TenSp,DVT,SoLuongTon,DonGiaNhap,TyLeHoaHong,NgayNhap) values ('20h12', 'xaxi','thung',1,189000,2,GETDATE())
insert into SanPham (Masp,TenSp,DVT,SoLuongTon,DonGiaNhap,TyLeHoaHong,NgayNhap) values ('20h13', 'ca tra','kg',0,300000,6,GETDATE())

--KhachHang
truncate table KhachHang
select * from KhachHang
insert into KhachHang (MaKH, TenKH, Diachi, Dienthoai) values ('kh1','nguyen van luyen','2 dien bien phu,tphcm',0975943712)
insert into KhachHang (MaKH, TenKH, Diachi, Dienthoai) values ('kh2','le thanh minh','4 cong hoa,tphcm',0393425675)
insert into KhachHang (MaKH, TenKH, Diachi, Dienthoai) values ('kh3','nguyen van luyen','45 xo viet nghe tinh,tphcm',0942564332)
--HoaDon
select * from HoaDon
insert into HoaDon (MaHD, NgayLap,NgayGiao,Makh,DienGiai) values ('hd123456',GETDATE(),'2023-02-19','kh1','khong co')
insert into HoaDon (MaHD, NgayLap,NgayGiao,Makh,DienGiai) values ('hd123457',GETDATE(),'2023-02-19','kh2','khong co')
insert into HoaDon (MaHD, NgayLap,NgayGiao,Makh,DienGiai) values ('hd123458',GETDATE(),'2023-02-19','kh3','khong co')
--ChiTietHD
insert into ChiTietHD (MaHD,Masp,Soluong) values ('hd123456','sp123',3)
insert into ChiTietHD (MaHD,Masp,Soluong) values ('hd123455','sp124',4)
insert into ChiTietHD (MaHD,Masp,Soluong) values ('hd123457','sp125',7)
--10 
--Do đang có một constraint hiện hữu, cụ thể là ràng buộc khóa ngoại "PK_ChiTietHD_MaHD" từ bảng ChiTietHD. Điều này khiến dữ liệu mất đi tính nhất quán
--Nếu vẫn muốn xóa thì cần xóa những ràng buộc về khóa hiện hữu có liên quan đến các bảng khác. Sau khi xóa hết các ràng buộc về khóa thì có thể xóa dữ liệu cùng tất cả các dữ liệu liên quan và tạo lại các ràng buộc khóa mới
--11
--Do các ràng buộc về ký tự của mã hóa đơn trong bảng Hóa đơn, và MaHD trong ChiTietHD thì lại được ràng buộc khóa ngoại với 
--MaHD của bảng hóa đơn nên cũng phải chịu ràng buộc về ký tự của cột này
--12
ALTER DATABASE SALES MODIFY NAME = BanHang  
--khong the doi ten database
use da
select * from ChiTietDatHang
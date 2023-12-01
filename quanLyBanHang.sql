create table SanPham(
	MaSP int primary key,
	MaLoai int,
	TenSP nvarchar(50),
)
alter table SanPham
add constraint fk_sanPham_maLoai foreign key (MaLoai) references LoaiSp(MaLoai)



drop table SanPham
create table LoaiSp(
	MaLoai int primary key,
	TenLoai varchar(50),
	KieuLoai varchar(50),
)

create table NguoiBan(
	MaNguoiBan int primary key,
	MaSP int,
	TenNguoiBan nvarchar(100),
	ThongTinLienHe varchar(50),
)
alter table NguoiBan
add constraint fk_NguoiBan_masp foreign key (MaSP) references SanPham(MaSP)


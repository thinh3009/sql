create table DonHang
(
	maDonHang int primary key,
	tenHang nvarchar(100),
	soLuong int,
	donGia decimal,
)

create table PhanLoai
(
	maDonHang int,
	LoaiHang nvarchar(50),
	ngayNhap date,
)
drop table PhanLoai
drop table DonHang

	--------------------------------
--them don hang
alter PROCEDURE add_donhang
	@madon SMALLINT,
	@ten NVARCHAR(50),
	@soluong SMALLINT,
	@dongia INT
AS 
BEGIN
	IF EXISTS (SELECT * FROM DonHang WHERE maDonHang = @madon)
	BEGIN
		PRINT 'don hang da ton tai'
	END
	ELSE
	BEGIN
		INSERT INTO DonHang(maDonHang, tenHang, soLuong, donGia) VALUES (@madon, @ten, @soluong, @dongia)
		PRINT 'ghi don hang thanh cong'
	END
END

--xoa don hang
CREATE PROCEDURE delete_donhang
	@madon SMALLINT
AS 
BEGIN
	DELETE FROM DonHang WHERE maDonHang = @madon
END
--sua don hang
alter PROCEDURE update_donhang
	@madon SMALLINT,
	@ten NVARCHAR(50),
	@soluong SMALLINT,
	@dongia INT
AS 
BEGIN
	UPDATE DonHang SET tenHang = @ten, soLuong = @soluong, donGia = @dongia WHERE maDonHang = @madon
	IF NOT EXISTS (SELECT * FROM DonHang WHERE maDonHang = @madon)
	BEGIN
		PRINT 'khong co don hang de sua'
	END
	ELSE
	BEGIN
		INSERT INTO DonHang(maDonHang, tenHang, soLuong, donGia) VALUES (@madon, @ten, @soluong, @dongia)
		PRINT 'sua don hang thanh cong'
	END
END
EXEC delete_donhang @madon = 1
select * from DonHang
EXEC update_donhang @madon = 1, @ten = 'banh danisa', @soluong = 2, @dongia = 400000
--phanloai
--them
ALTER PROCEDURE add_phanLoai
    @madon smallint,
    @loaihang nvarchar(50),
    @ngaynhap date
AS
BEGIN
    IF EXISTS (SELECT * from DonHang where maDonHang=@madon)
    BEGIN
		INSERT INTO PhanLoai (maDonHang, LoaiHang, ngayNhap) VALUES (@madon, @loaihang, @ngaynhap)
        PRINT 'them thanh cong'
    END
	else
    BEGIN
        PRINT 'khong co don'
    END
END
--sua phan loai
alter procedure update_phanloai 
	@madon smallint,
    @loaihang nvarchar(50),
    @ngaynhap date
as
	BEGIN
		UPDATE PhanLoai SET maDonHang = @madon, LoaiHang = @loaihang, ngayNhap =@ngaynhap WHERE maDonHang = @madon
	IF NOT EXISTS (SELECT * FROM PhanLoai WHERE maDonHang = @madon)
	BEGIN
		PRINT 'khong ton tai ban ghi'
	END
	ELSE
	BEGIN
		INSERT INTO PhanLoai(maDonHang,LoaiHang, ngayNhap) VALUES (@madon,@loaihang, @ngaynhap)
		PRINT 'sua don thanh cong'
	END
    END
--delete phanloai
CREATE PROCEDURE delete_phanloai
	@madon SMALLINT
AS 
BEGIN
	DELETE FROM PhanLoai WHERE maDonHang = @madon
END
exec delete_phanloai @madon=3
exec update_phanloai @madon =3,@loaihang='do gia dung',@ngaynhap='2023-09-02'



exec add_phanLoai @madon=2,@loaihang='thuc pham chuc nang',@ngaynhap='2023-03-12'
exec add_donhang @madon=2,@ten='lo vi song',@soluong=1,@dongia=6000000
exec update_donhang @madon=4,@ten='duy set',@soluong=1,@dongia=500000
exec delete_donhang @madon=1
truncate table DonHang
truncate table PhanLoai
select * from DonHang
select * from PhanLoai
------------------------------------------------------------------------------------------------------------------
SELECT @@SERVERNAME

-------------------------------------------------------------------------------------------------------------------

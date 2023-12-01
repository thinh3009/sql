
CREATE TABLE KHACHHANG (
    MAKH varchar(10) PRIMARY KEY,
    TENKH nvarchar(50),
    DIACHI nvarchar(100),
    DIENTHOAI varchar(20)
);

CREATE TABLE SANPHAM (
    MASP varchar(10) PRIMARY KEY,
    TENSP nvarchar(50),
    DVT nvarchar(20),
    SLCON int,
    DONGIA money
);

CREATE TABLE DONDATHANG (
    MADDH varchar(10) PRIMARY KEY,
    NGAYDH date,
    MAKH varchar(10),
    TINHTRANG varchar(20),
    FOREIGN KEY (MAKH) REFERENCES KHACHHANG(MAKH)
);

CREATE TABLE CHITIETDATHANG (
    MADDH varchar(10),
    MASP varchar(10),
    SL int,
    PRIMARY KEY (MADDH, MASP),
    FOREIGN KEY (MADDH) REFERENCES DONDATHANG(MADDH),
    FOREIGN KEY (MASP) REFERENCES SANPHAM(MASP)
);
--cau a
create view view_donHang
as
select d.MaKH,k.TenKH from DonDatHang d inner join KhachHang k on d.MaKH=k.MaKH
where YEAR(d.NgayDatHang)=2021;
select * from view_donHang

--cau b
CREATE PROCEDURE sp_ThemDonHang
    @MaKH varchar(10),
    @NgayDatHang date,
    @TinhTrang nvarchar(50),
    @MaSP varchar(10),
    @SoLuong int
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION
        DECLARE @MaDDH varchar(10)
        -- Thêm đơn hàng
        INSERT INTO DONDATHANG (NGAYDH, MAKH, TINHTRANG)
        VALUES (@NgayDatHang, @MaKH, @TinhTrang)

        SET @MaDDH = SCOPE_IDENTITY()

        -- Thêm chi tiết đơn hàng
        INSERT INTO CHITIETDATHANG (MADDH, MASP, SL)
        VALUES (@MaDDH, @MaSP, @SoLuong)
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        -- Rollback Transaction nếu dính lỗi
        ROLLBACK TRANSACTION
        -- Hiển thị thông báo lỗi
        PRINT 'Lỗi procedure: ' + ERROR_MESSAGE();
    END CATCH
END

EXEC 
sp_ThemDonHang '4', '2023-04-17', '2', '203', 10;
--cau c
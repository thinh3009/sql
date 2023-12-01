CREATE TABLE TIEPTHI_NEW
(
  MANV int,
  TENSP nvarchar(50),
  constraint pk_manv_tensp primary key (MANV,TENSP)
);
alter table tiepthi_new add constraint pk_manv_tiepthi primary key (MANV,TENSP)
alter table tiepthi_new drop constraint pk_manv_tiepthi primary key (TENSP)
alter table tiepthi_new 
add constraint fk_tensp foreign key (TENSP) references SANPHAM(TENSP)
alter table TIEPTHI_NEW
add constraint fk_manhanvien foreign key (MANV) references NHANVIEN(MANV)


--drop table TIEPTHI_NEW
CREATE TABLE SANPHAM
(
  TENSP nvarchar(50) primary key,
  DONGGIA int,
  DVT nvarchar(30),
);
CREATE TABLE NHANVIEN
(
  MANV int primary key,
  TENNV nvarchar(6)
);
drop table NHANVIEN
CREATE TABLE HOADON
(
  SOHD int,
  MANV int,
  NGAY date not null,
  KHUVUC nvarchar(10),
  primary key(SOHD,MANV)
);
alter table HOADON
add constraint fk_manv_hoadon foreign key (MANV) references NHANVIEN(MANV)
CREATE TABLE CTHOADON
(
  SOHD int,
  MANV int,
  TENSP varchar(50) ,
  SOLUONG int,
  primary key(SOHD,MANV,TENSP)
);
--alter table cthoadon
--add constraint fk_sohd_cthoadon foreign key (MANV) references TIEPTHI_NEW(MANV)

--alter table cthoadon
--add constraint fk_manv_cthoadon foreign key (MANV) references HOADON(MANV)

alter table cthoadon
add constraint fk_sohd_cthoadon foreign key (MANV) references TIEPTHI_NEW(MANV);

alter table cthoadon
add constraint fk_manv_cthoadon foreign key (MANV) references HOADON(MANV);

WITH TotalSales AS (
    SELECT
        NHANVIEN.TENNV AS 'Tên Nhân Viên',
        SANPHAM.TENSP AS 'Tên Sản Phẩm',
        SUM(CAST(CTHOADON.SOLUONG AS int)) AS 'Tổng Số Lượng',
        ROW_NUMBER() OVER (PARTITION BY NHANVIEN.TENNV ORDER BY SUM(CAST(CTHOADON.SOLUONG AS int)) DESC) AS RowNum
    FROM
        NHANVIEN
    JOIN
        TIEPTHI ON NHANVIEN.MANV = TIEPTHI.MANV
    JOIN
        CTHOADON ON TIEPTHI.MANV = CTHOADON.MANV
    JOIN
        SANPHAM ON CTHOADON.TENSP = SANPHAM.TENSP
    GROUP BY
        NHANVIEN.TENNV, SANPHAM.TENSP
)
SELECT
    'Tên Nhân Viên' AS 'Nhóm',
    'Tên Sản Phẩm' AS 'Tên',
    'Tổng Số Lượng' AS 'Số Lượng'
UNION ALL
SELECT
    'Tên Nhân Viên' AS 'Nhóm',
    'Tên Sản Phẩm' AS 'Tên',
    'Tổng Số Lượng' AS 'Số Lượng'
UNION ALL
SELECT
    '----------------------' AS 'Nhóm',
    '----------------------' AS 'Tên',
    '----------------------' AS 'Số Lượng'
UNION ALL
SELECT
    'Tên Nhân Viên',
    'Tên Sản Phẩm',
    'Tổng Số Lượng'
FROM
    TotalSales
WHERE
    RowNum = 1;



SELECT
    NV.TENNV AS 'Tên Nhân Viên',
    SP.TENSP AS 'Tên Sản Phẩm'
FROM
    NHANVIEN NV
JOIN
    SANPHAM SP ON NV.MANV = SP.TENSP -- Điều kiện phân công tiếp thị sản phẩm
WHERE
    NOT EXISTS (
        SELECT 1
        FROM CTHOADON C
        WHERE C.MANV = NV.MANV AND C.TENSP = SP.TENSP
    );


ALTER TABLE SANPHAM
ADD SOLUONG int;

UPDATE SANPHAM
SET SOLUONG = SOLUONG + 1
WHERE DONGGIA BETWEEN 15000 AND 20000
  AND TENSP IN (
    SELECT TENSP
    FROM HOADON
    WHERE KHUVUC = 'Q2'
  );
-------------------------------------------------------------------------------------




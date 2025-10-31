create database Baitaplonlaptrinhweb

ALTER TABLE dbo.NguoiDung ADD IsAdmin bit NOT NULL DEFAULT(0)
    CREATE TABLE dbo.NguoiDung (
        Id         INT IDENTITY(1,1) PRIMARY KEY,
        HoTen      NVARCHAR(100) NOT NULL,
        Email      NVARCHAR(100) NOT NULL,
        MatKhau    NVARCHAR(255) NOT NULL,   -- theo yêu cầu: lưu chuỗi bình thường
        SoDienThoai NVARCHAR(20)  NULL,
        NgayTao    DATETIME NOT NULL DEFAULT GETDATE()
    );
    -- Khóa duy nhất theo Email để chặn trùng
    CREATE UNIQUE INDEX UX_NguoiDung_Email ON dbo.NguoiDung(Email);

INSERT INTO dbo.NguoiDung (HoTen, Email, MatKhau, SoDienThoai)
VALUES (N'Quản trị viên', N'admin123@gmail.com', N'admin123', N'0123456789');

UPDATE dbo.NguoiDung
SET IsAdmin = 1
WHERE Email = 'admin123@gmail.com';

	CREATE TABLE dbo.NhaCungCap
(
    MaNCC  INT IDENTITY(1,1) PRIMARY KEY,
    TenNCC NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE dbo.LoaiSanPham
(
    MaLoaiSP INT IDENTITY(1,1) PRIMARY KEY,
    TenLoai  NVARCHAR(50) NOT NULL UNIQUE
);
GO

CREATE TABLE dbo.SanPham
(
    MaSP            INT IDENTITY(1,1) PRIMARY KEY,
    TenSP           NVARCHAR(200) NOT NULL,
    Gia             DECIMAL(18,2) NOT NULL,

    MaNCC           INT NOT NULL,        -- sẽ thêm FK sau
    MaLoaiSP        INT NOT NULL,        -- sẽ thêm FK sau

    -- Thuộc tính phần cứng
    CPU             NVARCHAR(100)  NULL,
    RAMGB           INT            NULL,
    SSDGB           INT            NULL,
    HDDGB           INT            NULL,
    GPU             NVARCHAR(100)  NULL,
    ManHinhInch     DECIMAL(4,1)   NULL,
    DoPhanGiai      NVARCHAR(30)   NULL,
    TanSoQuetHz     INT            NULL,
    TrongLuongKg    DECIMAL(4,2)   NULL,
    MauSac          NVARCHAR(30)   NULL,

    SoLuong         INT NOT NULL DEFAULT(0),
    AnhChinh        NVARCHAR(255) NULL,
    MoTa            NVARCHAR(MAX) NULL,

    NgayTao         DATETIME2(0) NOT NULL DEFAULT SYSDATETIME()
);

ALTER TABLE dbo.SanPham
ADD CONSTRAINT FK_SanPham_NhaCungCap 
    FOREIGN KEY (MaNCC) REFERENCES dbo.NhaCungCap(MaNCC);

ALTER TABLE dbo.SanPham
ADD CONSTRAINT FK_SanPham_LoaiSanPham
    FOREIGN KEY (MaLoaiSP) REFERENCES dbo.LoaiSanPham(MaLoaiSP);
GO

INSERT INTO dbo.NhaCungCap(TenNCC)
VALUES (N'Lenovo'), (N'ASUS'), (N'Dell'), (N'MSI'), (N'Acer');

INSERT INTO dbo.LoaiSanPham(TenLoai)
VALUES (N'Laptop');

DECLARE @LoaiLaptop INT = (SELECT MaLoaiSP FROM dbo.LoaiSanPham WHERE TenLoai = N'Laptop');
DECLARE @NCC_Lenovo INT = (SELECT MaNCC FROM dbo.NhaCungCap WHERE TenNCC = N'Lenovo');
DECLARE @NCC_ASUS   INT = (SELECT MaNCC FROM dbo.NhaCungCap WHERE TenNCC = N'ASUS');
DECLARE @NCC_Dell   INT = (SELECT MaNCC FROM dbo.NhaCungCap WHERE TenNCC = N'Dell');
DECLARE @NCC_MSI    INT = (SELECT MaNCC FROM dbo.NhaCungCap WHERE TenNCC = N'MSI');
DECLARE @NCC_Acer   INT = (SELECT MaNCC FROM dbo.NhaCungCap WHERE TenNCC = N'Acer');
INSERT INTO dbo.SanPham
(
    TenSP, Gia, MaNCC, MaLoaiSP,
    CPU, RAMGB, SSDGB, GPU, ManHinhInch, DoPhanGiai, TanSoQuetHz,
    TrongLuongKg, MauSac, SoLuong, AnhChinh, MoTa
)
VALUES
(N'Lenovo Legion Pro 5 16IRX9', 25000000, @NCC_Lenovo, @LoaiLaptop,
 N'i5-12400HX', 16, 512, N'RTX 4060 6GB', 16.0, N'FHD', 160,
 2.40, N'Grey', 10, N'anh/sp_legion_pro5.jpg', N'Gaming tản tốt, phím ổn'),

(N'ASUS ROG Strix 16', 45000000, @NCC_ASUS, @LoaiLaptop,
 N'i7-12900HX', 32, 1024, N'RTX 4070 8GB', 16.0, N'QHD', 165,
 2.50, N'Black', 8, N'anh/sp_rog_strix16.jpg', N'Máy gaming cao cấp'),

(N'Lenovo Yoga 9i', 35000000, @NCC_Lenovo, @LoaiLaptop,
 N'Ryzen 7 7840HS', 32, 1024, N'Radeon 780M', 14.0, N'QHD', 120,
 1.40, N'Grey', 12, N'anh/sp_yoga9i.jpg', N'2-in-1 mỏng nhẹ'),

(N'Dell XPS 14', 40000000, @NCC_Dell, @LoaiLaptop,
 N'i7-1260P', 16, 512, N'Iris Xe', 14.0, N'FHD', 60,
 1.60, N'Silver', 6, N'anh/sp_xps14.jpg', N'Flagship mỏng nhẹ'),

(N'ThinkPad X1 Carbon', 23000000, @NCC_Lenovo, @LoaiLaptop,
 N'i5-1240U', 32, 512, N'Iris Xe', 14.0, N'QHD', 60,
 1.20, N'Black', 20, N'anh/sp_x1_carbon.jpg', N'Văn phòng cao cấp'),

(N'MSI Modern 15', 19990000, @NCC_MSI, @LoaiLaptop,
 N'Ryzen 7 5700U', 16, 512, N'Vega 8', 15.6, N'FHD', 60,
 1.70, N'Grey', 15, N'anh/sp_msi_modern15.jpg', N'Văn phòng giá tốt'),

(N'Acer Nitro 5', 21000000, @NCC_Acer, @LoaiLaptop,
 N'i7-12500H', 16, 1024, N'RTX 3050 Ti', 15.6, N'QHD', 144,
 2.50, N'Black', 7, N'anh/sp_acer_nitro5.jpg', N'Gaming phổ thông');
GO

/* ==================== INDEX PHỤ ==================== */
CREATE INDEX IX_SanPham_MaLoaiSP ON dbo.SanPham(MaLoaiSP);
CREATE INDEX IX_SanPham_MaNCC    ON dbo.SanPham(MaNCC);
CREATE INDEX IX_SanPham_Gia      ON dbo.SanPham(Gia);
CREATE INDEX IX_SanPham_TenSP    ON dbo.SanPham(TenSP);
GO

/* ==================== PROC LỌC + PHÂN TRANG ==================== */
IF OBJECT_ID('dbo.usp_SanPham_FilterPage', 'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_SanPham_FilterPage;
GO

CREATE PROCEDURE dbo.usp_SanPham_FilterPage
    @MaLoaiSP   INT             = NULL,
    @MaNCC      INT             = NULL,
    @MinGia     DECIMAL(18,2)   = NULL,
    @MaxGia     DECIMAL(18,2)   = NULL,
    @SearchText NVARCHAR(200)   = NULL,
    @Sort       NVARCHAR(20)    = N'moi-nhat',  -- 'gia-asc' | 'gia-desc' | 'ten-asc' | 'ten-desc' | 'moi-nhat'
    @PageIndex  INT             = 1,
    @PageSize   INT             = 9
AS
BEGIN
    SET NOCOUNT ON;
    IF @PageIndex < 1 SET @PageIndex = 1;
    IF @PageSize  < 1 SET @PageSize  = 9;

    ;WITH F AS
    (
        SELECT  sp.MaSP, sp.TenSP, sp.Gia, sp.AnhChinh,
                sp.CPU, sp.RAMGB, sp.SSDGB, sp.GPU, sp.ManHinhInch, sp.DoPhanGiai, sp.TanSoQuetHz,
                sp.NgayTao,
                ncc.TenNCC
        FROM    dbo.SanPham sp
        INNER JOIN dbo.NhaCungCap ncc ON ncc.MaNCC = sp.MaNCC
        WHERE   (@MaLoaiSP IS NULL OR sp.MaLoaiSP = @MaLoaiSP)
            AND (@MaNCC    IS NULL OR sp.MaNCC    = @MaNCC)
            AND (@MinGia   IS NULL OR sp.Gia      >= @MinGia)
            AND (@MaxGia   IS NULL OR sp.Gia      <= @MaxGia)
            AND (@SearchText IS NULL OR sp.TenSP LIKE N'%' + @SearchText + N'%')
    )
    SELECT  *
    FROM    F
    ORDER BY
        CASE WHEN @Sort = N'gia-asc'  THEN Gia    END ASC,
        CASE WHEN @Sort = N'gia-desc' THEN Gia    END DESC,
        CASE WHEN @Sort = N'ten-asc'  THEN TenSP  END ASC,
        CASE WHEN @Sort = N'ten-desc' THEN TenSP  END DESC,
        CASE WHEN @Sort = N'moi-nhat' THEN NgayTao END DESC,
        MaSP DESC
    OFFSET (@PageIndex - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;

    -- tổng bản ghi cho phân trang
    SELECT COUNT(*) AS TotalRows
    FROM dbo.SanPham sp
    WHERE   (@MaLoaiSP IS NULL OR sp.MaLoaiSP = @MaLoaiSP)
        AND (@MaNCC    IS NULL OR sp.MaNCC    = @MaNCC)
        AND (@MinGia   IS NULL OR sp.Gia      >= @MinGia)
        AND (@MaxGia   IS NULL OR sp.Gia      <= @MaxGia)
        AND (@SearchText IS NULL OR sp.TenSP LIKE N'%' + @SearchText + N'%');
END
GO


DECLARE @LoaiLaptop INT = (SELECT MaLoaiSP FROM dbo.LoaiSanPham WHERE TenLoai = N'Laptop');
DECLARE @NCC_Lenovo INT = (SELECT MaNCC FROM dbo.NhaCungCap WHERE TenNCC = N'Lenovo');
DECLARE @NCC_ASUS   INT = (SELECT MaNCC FROM dbo.NhaCungCap WHERE TenNCC = N'ASUS');
DECLARE @NCC_Dell   INT = (SELECT MaNCC FROM dbo.NhaCungCap WHERE TenNCC = N'Dell');
DECLARE @NCC_MSI    INT = (SELECT MaNCC FROM dbo.NhaCungCap WHERE TenNCC = N'MSI');
DECLARE @NCC_Acer   INT = (SELECT MaNCC FROM dbo.NhaCungCap WHERE TenNCC = N'Acer');
INSERT INTO dbo.SanPham
(
  TenSP, Gia, MaNCC, MaLoaiSP,
  CPU, RAMGB, SSDGB, HDDGB, GPU,
  ManHinhInch, DoPhanGiai, TanSoQuetHz,
  TrongLuongKg, MauSac, SoLuong, AnhChinh, MoTa
)
VALUES
-- 1
(N'Lenovo IdeaPad 5 14ABA7', 16990000, @NCC_Lenovo, @LoaiLaptop,
 N'Ryzen 5 7530U', 16, 512, NULL, N'Radeon Graphics',
 14.0, N'FHD', 60,
 1.38, N'Silver', 12, N'anh/sp_ideapad5_14.jpg', N'Văn phòng mỏng nhẹ, pin ổn'),

-- 2
(N'Lenovo ThinkBook 14 G4+', 20990000, @NCC_Lenovo, @LoaiLaptop,
 N'i5-1240P', 16, 512, NULL, N'Iris Xe',
 14.0, N'FHD', 60,
 1.40, N'Grey', 10, N'anh/sp_thinkbook14_g4.jpg', N'Doanh nhân gọn gàng, build ổn'),

-- 3
(N'ASUS TUF Gaming A15 2023', 27990000, @NCC_ASUS, @LoaiLaptop,
 N'Ryzen 7 7735HS', 16, 512, NULL, N'RTX 4060 8GB',
 15.6, N'FHD', 144,
 2.20, N'Black', 8, N'anh/sp_tuf_a15_2023.jpg', N'Gaming bền bỉ, tản ổn'),

-- 4
(N'ASUS Zenbook 14 OLED UX3402', 29990000, @NCC_ASUS, @LoaiLaptop,
 N'i7-1260P', 16, 512, NULL, N'Iris Xe',
 14.0, N'2.8K', 90,
 1.39, N'Blue', 7, N'anh/sp_zenbook14_oled.jpg', N'Màn OLED sắc nét, mỏng nhẹ'),

-- 5
(N'Dell Inspiron 14 5420', 18990000, @NCC_Dell, @LoaiLaptop,
 N'i5-1235U', 16, 512, NULL, N'Iris Xe',
 14.0, N'FHD', 60,
 1.50, N'Silver', 9, N'anh/sp_inspiron14_5420.jpg', N'Văn phòng cơ bản, ổn định'),

-- 6
(N'Dell G15 5520', 25990000, @NCC_Dell, @LoaiLaptop,
 N'i5-12500H', 16, 512, NULL, N'RTX 3050 4GB',
 15.6, N'FHD', 120,
 2.60, N'Dark Grey', 5, N'anh/sp_dell_g15_5520.jpg', N'Gaming phổ thông, hiệu năng tốt'),

-- 7
(N'MSI Katana 15 B13', 28990000, @NCC_MSI, @LoaiLaptop,
 N'i7-13620H', 16, 512, NULL, N'RTX 4060 8GB',
 15.6, N'FHD', 144,
 2.25, N'Black', 6, N'anh/sp_msi_katana15.jpg', N'Khung chắc, khởi điểm gaming hợp lý'),

-- 8
(N'MSI Prestige 14 Evo', 25990000, @NCC_MSI, @LoaiLaptop,
 N'i7-1360P', 16, 512, NULL, N'Iris Xe',
 14.0, N'FHD', 60,
 1.29, N'White', 4, N'anh/sp_msi_prestige14.jpg', N'Mỏng nhẹ doanh nhân, bàn phím êm'),

-- 9
(N'Acer Swift 3 SF314', 16990000, @NCC_Acer, @LoaiLaptop,
 N'Ryzen 5 5625U', 16, 512, NULL, N'Radeon Graphics',
 14.0, N'FHD', 60,
 1.20, N'Gold', 11, N'anh/sp_acer_swift3.jpg', N'Nhẹ, pin ổn, giá dễ chịu'),

-- 10
(N'Acer Predator Helios 300 PH315', 32990000, @NCC_Acer, @LoaiLaptop,
 N'i7-12700H', 16, 1024, NULL, N'RTX 3060 6GB',
 15.6, N'QHD', 165,
 2.50, N'Black', 3, N'anh/sp_predator_helios300.jpg', N'Gaming hiệu năng cao, tản mạnh'),

-- 11
(N'Lenovo LOQ 15IRH8', 23990000, @NCC_Lenovo, @LoaiLaptop,
 N'i5-12450H', 16, 512, NULL, N'RTX 4050 6GB',
 15.6, N'FHD', 144,
 2.40, N'Grey', 10, N'anh/sp_lenovo_loq15.jpg', N'Gaming giá hợp lý, dễ tiếp cận');
GO


/* ---- BƯỚC 1: Thêm 2 cột mới để lưu cấu hình cho Bàn phím/PC ---- */
ALTER TABLE dbo.SanPham
ADD SpecLine1 NVARCHAR(100) NULL;

ALTER TABLE dbo.SanPham
ADD SpecLine2 NVARCHAR(100) NULL;
GO

/* ---- BƯỚC 2: Thêm 2 loại sản phẩm mới ---- */
INSERT INTO dbo.LoaiSanPham(TenLoai)
VALUES (N'Bàn phím'), (N'PC');
GO

/* ---- BƯỚC 3: Thêm dữ liệu mẫu cho Bàn phím và PC (lấy từ HTML tĩnh của bạn) ---- */
DECLARE @NCC_ASUS INT = (SELECT MaNCC FROM dbo.NhaCungCap WHERE TenNCC = N'ASUS');
DECLARE @NCC_Dell INT = (SELECT MaNCC FROM dbo.NhaCungCap WHERE TenNCC = N'Dell');
DECLARE @NCC_Lenovo INT = (SELECT MaNCC FROM dbo.NhaCungCap WHERE TenNCC = N'Lenovo');

DECLARE @LoaiBanPhim INT = (SELECT MaLoaiSP FROM dbo.LoaiSanPham WHERE TenLoai = N'Bàn phím');
DECLARE @LoaiPC INT = (SELECT MaLoaiSP FROM dbo.LoaiSanPham WHERE TenLoai = N'PC');

INSERT INTO dbo.SanPham
(
    TenSP, Gia, MaNCC, MaLoaiSP, AnhChinh,
    SpecLine1, SpecLine2, SoLuong
)
VALUES
(N'Bàn phím cơ Aula S2022 Đen Blue Switch', 399000, @NCC_ASUS, @LoaiBanPhim, N'anh/banphim2.jpg',
 N'Kiểu dáng: Full Size', N'Kết nối: Dây USB', 50),

(N'Bàn phím cơ KENOO ESPORT EK87', 459000, @NCC_ASUS, @LoaiBanPhim, N'anh/banphim5.jpg',
 N'Kiểu dáng: Tenkeyless (nhỏ gọn)', N'Kết nối: Dây USB', 30),

(N'PC HP Pro Tower 280 G9 B91LVAT', 10490000, @NCC_Dell, @LoaiPC, N'anh/pc2.jpg',
 N'CPU: i3 13100 | GPU: Intel UHD 730', N'RAM: 8GB | SSD: 256GB | Win 11', 20),

(N'PC Dell Slim DS-14100-8-512G', 12190000, @NCC_Dell, @LoaiPC, N'anh/pc8.jpg',
 N'CPU: i3 14100 | GPU: Intel UHD', N'RAM: 8GB | SSD: 512GB | Win 11', 15),
 
(N'PC Lenovo ThinkCentre M70t G5', 13690000, @NCC_Lenovo, @LoaiPC, N'anh/pc5.jpg',
 N'CPU: i5 14400 | GPU: Intel UHD 730', N'RAM: 8GB | SSD: 512GB', 10);
GO




-- Bước 1: Tạo bảng MaGiamGia
CREATE TABLE dbo.MaGiamGia (
    MaGiam INT PRIMARY KEY IDENTITY(1,1),
    GiamGia INT NOT NULL -- ví dụ: 20 là giảm 20%
);
GO

-- Bước 2: Thêm cột MaGiam vào bảng SanPham và tạo Foreign Key
ALTER TABLE dbo.SanPham
ADD MaGiam INT NULL;
GO

ALTER TABLE dbo.SanPham
ADD CONSTRAINT FK_SanPham_MaGiamGia
FOREIGN KEY (MaGiam) REFERENCES dbo.MaGiamGia(MaGiam);
GO

-- Bước 3: Thêm cột GiaGoc nếu chưa có (cần để hiển thị giá gốc bị gạch)
-- Kiểm tra xem cột GiaGoc đã tồn tại chưa
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'SanPham' AND COLUMN_NAME = 'GiaGoc')
BEGIN
    ALTER TABLE dbo.SanPham
    ADD GiaGoc DECIMAL(18,2) NULL;
END
GO

-- Bước 4: Cập nhật GiaGoc cho các sản phẩm chưa có (nếu cần)
-- Giả sử giá gốc cao hơn giá hiện tại 25% (bạn có thể điều chỉnh logic này)
UPDATE dbo.SanPham
SET GiaGoc = Gia * 1.25
WHERE GiaGoc IS NULL;
GO

-- Bước 5: Thêm các mức giảm giá vào bảng MaGiamGia
INSERT INTO dbo.MaGiamGia (GiamGia) VALUES (10), (15), (20), (25), (35);
GO

-- Bước 6: Áp dụng mã giảm giá cho một số sản phẩm ví dụ
DECLARE @MaGiam15 INT, @MaGiam25 INT, @MaGiam35 INT;
SELECT @MaGiam15 = MaGiam FROM dbo.MaGiamGia WHERE GiamGia = 15;
SELECT @MaGiam25 = MaGiam FROM dbo.MaGiamGia WHERE GiamGia = 25;
SELECT @MaGiam35 = MaGiam FROM dbo.MaGiamGia WHERE GiamGia = 35;

-- Áp dụng giảm giá 25% cho 'Acer Nitro 5' và cập nhật lại Gia/GiaGoc cho khớp
UPDATE dbo.SanPham
SET MaGiam = @MaGiam25,
    Gia = 15750000, -- 21.000.000 * (1 - 0.25)
    GiaGoc = 21000000
WHERE TenSP LIKE N'%Acer Nitro 5%';

-- Áp dụng giảm giá 35% cho 'Dell Inspiron 3000' và cập nhật lại Gia/GiaGoc
UPDATE dbo.SanPham
SET MaGiam = @MaGiam35,
    Gia = 9750000, -- 15.000.000 * (1 - 0.35)
    GiaGoc = 15000000
WHERE TenSP LIKE N'%Dell Inspiron 3000%';

-- Áp dụng giảm giá 15% cho 'PC Lenovo ThinkCentre M70t G5'
UPDATE dbo.SanPham
SET MaGiam = @MaGiam15,
    Gia = 11636500, -- 13.690.000 * (1 - 0.15)
    GiaGoc = 13690000
WHERE TenSP LIKE N'%PC Lenovo ThinkCentre M70t G5%';

-- Áp dụng giảm giá 20% cho 'PC Dell Slim DS-14100-8-512G'
DECLARE @MaGiam20 INT;
SELECT @MaGiam20 = MaGiam FROM dbo.MaGiamGia WHERE GiamGia = 20;
UPDATE dbo.SanPham
SET MaGiam = @MaGiam20,
    Gia = 9752000, -- 12.190.000 * (1 - 0.20)
    GiaGoc = 12190000
WHERE TenSP LIKE N'%PC Dell Slim DS-14100-8-512G%';

GO




-- Bước 1: Tạo bảng MaGiamGia (Nếu chưa có)
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'MaGiamGia')
BEGIN
    CREATE TABLE dbo.MaGiamGia (
        MaGiam INT PRIMARY KEY IDENTITY(1,1),
        GiamGia INT NOT NULL
    );
END
GO

-- Bước 2: Thêm cột MaGiam vào SanPham (Nếu chưa có)
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'SanPham' AND COLUMN_NAME = 'MaGiam')
BEGIN
    ALTER TABLE dbo.SanPham ADD MaGiam INT NULL;
    ALTER TABLE dbo.SanPham ADD CONSTRAINT FK_SanPham_MaGiamGia FOREIGN KEY (MaGiam) REFERENCES dbo.MaGiamGia(MaGiam);
END
GO

-- Bước 3: Thêm cột GiaGoc (Nếu chưa có)
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'SanPham' AND COLUMN_NAME = 'GiaGoc')
BEGIN
    ALTER TABLE dbo.SanPham ADD GiaGoc DECIMAL(18,2) NULL;
END
GO

-- Bước 4: Thêm cột SpecLine1, SpecLine2 (Nếu chưa có)
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'SanPham' AND COLUMN_NAME = 'SpecLine1')
BEGIN
    ALTER TABLE dbo.SanPham ADD SpecLine1 NVARCHAR(100) NULL;
END
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'SanPham' AND COLUMN_NAME = 'SpecLine2')
BEGIN
    ALTER TABLE dbo.SanPham ADD SpecLine2 NVARCHAR(100) NULL;
END
GO

-- Bước 5: Cập nhật GiaGoc (Chỉ chạy 1 lần nếu cần)
UPDATE dbo.SanPham SET GiaGoc = Gia * 1.25 WHERE GiaGoc IS NULL;
GO

-- Bước 6: Thêm dữ liệu MaGiamGia (Chỉ chạy 1 lần nếu cần)
IF NOT EXISTS (SELECT 1 FROM dbo.MaGiamGia WHERE GiamGia IN (10, 15, 20, 25, 35))
BEGIN
    INSERT INTO dbo.MaGiamGia (GiamGia) VALUES (10), (15), (20), (25), (35);
END
GO

-- Bước 7: Cập nhật giảm giá cho sản phẩm (Chỉ chạy 1 lần nếu cần)
DECLARE @MaGiam15 INT = (SELECT MaGiam FROM dbo.MaGiamGia WHERE GiamGia = 15);
DECLARE @MaGiam20 INT = (SELECT MaGiam FROM dbo.MaGiamGia WHERE GiamGia = 20);
DECLARE @MaGiam25 INT = (SELECT MaGiam FROM dbo.MaGiamGia WHERE GiamGia = 25);
DECLARE @MaGiam35 INT = (SELECT MaGiam FROM dbo.MaGiamGia WHERE GiamGia = 35);

UPDATE dbo.SanPham SET MaGiam = @MaGiam25, Gia = GiaGoc * (1 - 0.25) WHERE TenSP LIKE N'%Acer Nitro 5%' AND MaGiam IS NULL;
UPDATE dbo.SanPham SET MaGiam = @MaGiam35, Gia = GiaGoc * (1 - 0.35) WHERE TenSP LIKE N'%Dell Inspiron 3000%' AND MaGiam IS NULL;
UPDATE dbo.SanPham SET MaGiam = @MaGiam15, Gia = GiaGoc * (1 - 0.15) WHERE TenSP LIKE N'%PC Lenovo ThinkCentre M70t G5%' AND MaGiam IS NULL;
UPDATE dbo.SanPham SET MaGiam = @MaGiam20, Gia = GiaGoc * (1 - 0.20) WHERE TenSP LIKE N'%PC Dell Slim DS-14100-8-512G%' AND MaGiam IS NULL;
GO


select * from NguoiDung

USE Baitaplonlaptrinhweb;
GO

-- View hiển thị thống nhất giá & thông tin
CREATE OR ALTER VIEW dbo.vSanPhamHienThi AS
SELECT 
    sp.MaSP, sp.TenSP, sp.Gia, sp.GiaGoc, sp.AnhChinh,
    sp.CPU, sp.RAMGB, sp.SSDGB, sp.HDDGB, sp.GPU,
    sp.ManHinhInch, sp.DoPhanGiai, sp.TanSoQuetHz,
    sp.SpecLine1, sp.SpecLine2, sp.MoTa, sp.NgayTao,
    ncc.TenNCC, lsp.TenLoai,
    mg.GiamGia,
    CAST(
      COALESCE(
        CASE WHEN mg.GiamGia IS NOT NULL AND sp.GiaGoc IS NOT NULL
             THEN sp.GiaGoc * (1 - mg.GiamGia/100.0)
        END,
        sp.Gia
      ) AS DECIMAL(18,2)
    ) AS GiaHienThi
FROM dbo.SanPham sp
JOIN dbo.NhaCungCap   ncc ON ncc.MaNCC    = sp.MaNCC
JOIN dbo.LoaiSanPham  lsp ON lsp.MaLoaiSP = sp.MaLoaiSP
LEFT JOIN dbo.MaGiamGia mg ON mg.MaGiam   = sp.MaGiam;
GO

-- Proc lấy chi tiết theo MaSP
CREATE OR ALTER PROCEDURE dbo.usp_SanPham_GetById
    @MaSP INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT *
    FROM dbo.vSanPhamHienThi
    WHERE MaSP = @MaSP;
END
GO



USE Baitaplonlaptrinhweb;
GO

-- View đã có trong script của bạn; nếu thiếu MaSP/TenNCC/... thì ensure lại:
/*CREATE OR ALTER VIEW dbo.vSanPhamHienThi AS
SELECT 
    sp.MaSP, sp.TenSP, sp.Gia, sp.GiaGoc, sp.AnhChinh,
    sp.CPU, sp.RAMGB, sp.SSDGB, sp.HDDGB, sp.GPU,
    sp.ManHinhInch, sp.DoPhanGiai, sp.TanSoQuetHz,
    sp.SpecLine1, sp.SpecLine2, sp.MoTa, sp.NgayTao,
    sp.MaNCC, sp.MaLoaiSP,        -- thêm cho tiện join lọc liên quan
    ncc.TenNCC, lsp.TenLoai,
    mg.GiamGia,
    CAST(
      COALESCE(
        CASE WHEN mg.GiamGia IS NOT NULL AND sp.GiaGoc IS NOT NULL
             THEN sp.GiaGoc * (1 - mg.GiamGia/100.0)
        END,
        sp.Gia
      ) AS DECIMAL(18,2)
    ) AS GiaHienThi
FROM dbo.SanPham sp
JOIN dbo.NhaCungCap   ncc ON ncc.MaNCC    = sp.MaNCC
JOIN dbo.LoaiSanPham  lsp ON lsp.MaLoaiSP = sp.MaLoaiSP
LEFT JOIN dbo.MaGiamGia mg ON mg.MaGiam   = sp.MaGiam;
GO
*/

-- Đảm bảo có view + proc này
CREATE OR ALTER VIEW dbo.vSanPhamHienThi AS
SELECT sp.MaSP, sp.TenSP, sp.Gia, sp.GiaGoc, sp.AnhChinh,
       sp.CPU, sp.RAMGB, sp.SSDGB, sp.HDDGB, sp.GPU,
       sp.ManHinhInch, sp.DoPhanGiai, sp.TanSoQuetHz,
       sp.TrongLuongKg, sp.MoTa, sp.NgayTao,
       sp.MaNCC, sp.MaLoaiSP,
       ncc.TenNCC, lsp.TenLoai,
       mg.GiamGia,
       CAST(COALESCE(CASE WHEN mg.GiamGia IS NOT NULL AND sp.GiaGoc IS NOT NULL
                          THEN sp.GiaGoc * (1 - mg.GiamGia/100.0) END, sp.Gia) AS DECIMAL(18,2)) AS GiaHienThi
FROM dbo.SanPham sp
JOIN dbo.NhaCungCap ncc ON ncc.MaNCC = sp.MaNCC
JOIN dbo.LoaiSanPham lsp ON lsp.MaLoaiSP = sp.MaLoaiSP
LEFT JOIN dbo.MaGiamGia mg ON mg.MaGiam = sp.MaGiam;
GO

CREATE OR ALTER PROCEDURE dbo.usp_SanPham_GetById @MaSP INT
AS
BEGIN
  SET NOCOUNT ON;
  SELECT * FROM dbo.vSanPhamHienThi WHERE MaSP = @MaSP;
END
GO






-- Proc chi tiết theo MaSP (nếu chưa tạo)
CREATE OR ALTER PROCEDURE dbo.usp_SanPham_GetById
    @MaSP INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM dbo.vSanPhamHienThi WHERE MaSP = @MaSP;
END
GO

-- Proc sản phẩm liên quan: ưu tiên cùng thương hiệu, rồi cùng loại
CREATE OR ALTER PROCEDURE dbo.usp_SanPham_GetRelated
    @MaSP INT,
    @TopN INT = 10
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @MaLoai INT, @MaNCC INT;
    SELECT @MaLoai = MaLoaiSP, @MaNCC = MaNCC
    FROM dbo.SanPham WHERE MaSP = @MaSP;

    ;WITH C AS (
        SELECT v.*,
               CASE 
                 WHEN v.MaNCC = @MaNCC THEN 0
                 WHEN v.MaLoaiSP = @MaLoai THEN 1
                 ELSE 2
               END AS OrdKey
        FROM dbo.vSanPhamHienThi v
        WHERE v.MaSP <> @MaSP
          AND (v.MaNCC = @MaNCC OR v.MaLoaiSP = @MaLoai)
    )
    SELECT TOP (@TopN)
        MaSP, TenSP, GiaHienThi, GiaGoc, AnhChinh, SpecLine1, SpecLine2
    FROM C
    ORDER BY OrdKey ASC, NgayTao DESC, MaSP DESC;
END
GO

USE Baitaplonlaptrinhweb;
GO

-- địa chỉ--
IF OBJECT_ID('dbo.DiaChiNguoiDung','U') IS NULL
BEGIN
  CREATE TABLE dbo.DiaChiNguoiDung (
    Id           INT IDENTITY(1,1) PRIMARY KEY,
    UserId       INT NOT NULL REFERENCES dbo.NguoiDung(Id),
    HoTen        NVARCHAR(100) NOT NULL,
    SDT          NVARCHAR(20)  NOT NULL,
    Email        NVARCHAR(150) NOT NULL,
    DiaChi       NVARCHAR(300) NOT NULL,
    PhuongThucTT NVARCHAR(30)  NULL,
    GhiChu       NVARCHAR(500) NULL,
    IsDefault    BIT NOT NULL CONSTRAINT DF_DiaChi_IsDefault DEFAULT(0),
    NgayTao      DATETIME NOT NULL CONSTRAINT DF_DiaChi_NgayTao DEFAULT(GETDATE())
  );

  CREATE INDEX IX_DiaChi_User
    ON dbo.DiaChiNguoiDung(UserId, IsDefault DESC, Id DESC);

  CREATE UNIQUE INDEX UX_DiaChi_DefaultPerUser
    ON dbo.DiaChiNguoiDung(UserId)
    WHERE IsDefault = 1;
END
GO

-- Đơn hàng
IF OBJECT_ID('dbo.DonHang','U') IS NULL
BEGIN
  CREATE TABLE dbo.DonHang(
    Id            INT IDENTITY(1,1) PRIMARY KEY,
    MaDon         VARCHAR(20) NOT NULL UNIQUE,
    UserId        INT NULL REFERENCES dbo.NguoiDung(Id),
    HoTen         NVARCHAR(100) NOT NULL,
    SDT           NVARCHAR(20)  NOT NULL,
    Email         NVARCHAR(100) NOT NULL,
    DiaChi        NVARCHAR(255) NOT NULL,
    PhuongThucTT  NVARCHAR(30)  NOT NULL,
    GhiChu        NVARCHAR(500) NULL,
    TongTien      DECIMAL(18,2) NOT NULL,
    TrangThai     NVARCHAR(30)  NOT NULL DEFAULT N'Đã thanh toán',
    NgayTao       DATETIME      NOT NULL DEFAULT GETDATE()
  );
END
GO

IF COL_LENGTH('dbo.DonHang','AddressId') IS NULL
  ALTER TABLE dbo.DonHang ADD AddressId INT NULL;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name='FK_DonHang_Address')
BEGIN
  ALTER TABLE dbo.DonHang
    ADD CONSTRAINT FK_DonHang_Address
    FOREIGN KEY (AddressId) REFERENCES dbo.DiaChiNguoiDung(Id)
    ON DELETE SET NULL   -- xoá địa chỉ thì đơn vẫn giữ lịch sử
    ON UPDATE NO ACTION;
END
GO

-- Chi tiết đơn hàng
IF OBJECT_ID('dbo.DonHangCT','U') IS NULL
BEGIN
  CREATE TABLE dbo.DonHangCT(
    Id         INT IDENTITY(1,1) PRIMARY KEY,
    DonHangId  INT NOT NULL REFERENCES dbo.DonHang(Id) ON DELETE CASCADE,
    MaSP       INT NOT NULL,
    TenSP      NVARCHAR(200) NOT NULL,
    DonGia     DECIMAL(18,2) NOT NULL,
    SoLuong    INT NOT NULL,
    ThanhTien  DECIMAL(18,2) NOT NULL
  );
  CREATE INDEX IX_DonHangCT_DonHangId ON dbo.DonHangCT(DonHangId);
END
GO

-- Hóa đơn
IF OBJECT_ID('dbo.HoaDon','U') IS NULL
BEGIN
  CREATE TABLE dbo.HoaDon(
    Id            INT IDENTITY(1,1) PRIMARY KEY,
    DonHangId     INT NOT NULL REFERENCES dbo.DonHang(Id) ON DELETE CASCADE,
    SoHoaDon      VARCHAR(20) NOT NULL UNIQUE,
    NgayLap       DATETIME NOT NULL DEFAULT GETDATE(),
    TongTien      DECIMAL(18,2) NOT NULL,
    PhuongThucTT  NVARCHAR(30) NOT NULL
  );
END
GO

-- Chi tiết hóa đơn
IF OBJECT_ID('dbo.HoaDonCT','U') IS NULL
BEGIN
  CREATE TABLE dbo.HoaDonCT(
    Id         INT IDENTITY(1,1) PRIMARY KEY,
    HoaDonId   INT NOT NULL REFERENCES dbo.HoaDon(Id) ON DELETE CASCADE,
    MaSP       INT NOT NULL,
    TenSP      NVARCHAR(200) NOT NULL,
    DonGia     DECIMAL(18,2) NOT NULL,
    SoLuong    INT NOT NULL,
    ThanhTien  DECIMAL(18,2) NOT NULL
  );
  CREATE INDEX IX_HoaDonCT_HoaDonId ON dbo.HoaDonCT(HoaDonId);
END
GO

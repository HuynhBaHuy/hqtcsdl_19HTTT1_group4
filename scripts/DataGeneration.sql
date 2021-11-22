-- Script date 21/11/2021 9:15:05 CH
--

GO
USE OnlineOrderingSystem
GO

--
-- Inserting data into table dbo.KHACH_HANG
--
INSERT dbo.KHACH_HANG(MaKH, TenKH, SoDT) VALUES (N'2', N'Hùng', N'0323287574')
INSERT dbo.KHACH_HANG(MaKH, TenKH, SoDT) VALUES (N'7', N'Quyên', N'0679471638')
INSERT dbo.KHACH_HANG(MaKH, TenKH, SoDT) VALUES (N'8', N'Hiền', N'0377878368')
INSERT dbo.KHACH_HANG(MaKH, TenKH, SoDT) VALUES (N'3', N'Kiệt', N'0325373415')
INSERT dbo.KHACH_HANG(MaKH, TenKH, SoDT) VALUES (N'1', N'Trang', N'0877528832')
GO

--
-- Inserting data into table dbo.KHU_VUC
--
INSERT dbo.KHU_VUC(MaKV, Quan, Tinh) VALUES (N'7', N'1	', N'TPHCM')
INSERT dbo.KHU_VUC(MaKV, Quan, Tinh) VALUES (N'6', N'Bình Tân', N'TPHCM')
INSERT dbo.KHU_VUC(MaKV, Quan, Tinh) VALUES (N'8', N'2', N'TPHCM')
INSERT dbo.KHU_VUC(MaKV, Quan, Tinh) VALUES (N'5', N'Bình Thạnh', N'TPHCM')
INSERT dbo.KHU_VUC(MaKV, Quan, Tinh) VALUES (N'2', N'3', N'TPHCM')
GO

--
-- Inserting data into table dbo.LOAI_HANG
--
INSERT dbo.LOAI_HANG(MaLoai, TenLoai) VALUES (N'3', N'Electronics')
INSERT dbo.LOAI_HANG(MaLoai, TenLoai) VALUES (N'5', N'Outdoors')
INSERT dbo.LOAI_HANG(MaLoai, TenLoai) VALUES (N'9', N'Baby')
INSERT dbo.LOAI_HANG(MaLoai, TenLoai) VALUES (N'1', N'Audible')
INSERT dbo.LOAI_HANG(MaLoai, TenLoai) VALUES (N'2', N'Patio')
GO

--
-- Inserting data into table dbo.DOI_TAC
--
INSERT dbo.DOI_TAC(MaDT, TenDT, NguoiDaiDien, MaKV, SoChiNhanh, SLDH, MaLoai, DiaChiKD, SoDT, Email, MaSoThue) VALUES (N'4', N'Bách', N'Thùy', N'7', 9, 155, N'9', N'Hai Bà Trưng', N'0777734529', N'SixtaMyrick855@nowhere.com', N'515')
INSERT dbo.DOI_TAC(MaDT, TenDT, NguoiDaiDien, MaKV, SoChiNhanh, SLDH, MaLoai, DiaChiKD, SoDT, Email, MaSoThue) VALUES (N'8', N'Thu', N'Cương', N'5', 6, 50, N'1', N'Thanh Trì', N'0357931292', N'hcec8@nowhere.com', N'922')
INSERT dbo.DOI_TAC(MaDT, TenDT, NguoiDaiDien, MaKV, SoChiNhanh, SLDH, MaLoai, DiaChiKD, SoDT, Email, MaSoThue) VALUES (N'6', N'Huyền', N'Bình', N'7', 7, 50, N'5', N'Gia Lâm', N'0375795832', N'seriad12@example.com', N'894')
INSERT dbo.DOI_TAC(MaDT, TenDT, NguoiDaiDien, MaKV, SoChiNhanh, SLDH, MaLoai, DiaChiKD, SoDT, Email, MaSoThue) VALUES (N'1', N'Anh', N'Ngọc', N'8', 6, 97, N'9', N'3', N'0133223216', N'Kilpatrick362@nowhere.com', N'341')
INSERT dbo.DOI_TAC(MaDT, TenDT, NguoiDaiDien, MaKV, SoChiNhanh, SLDH, MaLoai, DiaChiKD, SoDT, Email, MaSoThue) VALUES (N'7', N'Mỹ', N'Hân', N'8', 10, 113, N'5', N'Tân Phú', N'0584267625', N'Quinn_V.Kuykendall@nowhere.com', N'227')
GO

--
-- Inserting data into table dbo.TAI_XE
--
INSERT dbo.TAI_XE(MaTX, HoTen, Cmnd, SoDT, DiaChi, BienSo, MaKV, Email, TaiKhoanNH) VALUES (N'4', N'Tùng', N'475852141830', N'0131126132', N'1	', N'51QL-40595', N'7', N'HomerBustos9@example.com', N'593637956')
INSERT dbo.TAI_XE(MaTX, HoTen, Cmnd, SoDT, DiaChi, BienSo, MaKV, Email, TaiKhoanNH) VALUES (N'2', N'Tuệ', N'017210543179', N'0877586768', N'Bình Tân', N'51SW-96679', N'6', N'DanaABrannon8@example.com', N'221725785')
INSERT dbo.TAI_XE(MaTX, HoTen, Cmnd, SoDT, DiaChi, BienSo, MaKV, Email, TaiKhoanNH) VALUES (N'6', N'Vi', N'031794749852', N'0493211423', N'2', N'51II-78811', N'5', N'Calkins@nowhere.com', N'708143496')
INSERT dbo.TAI_XE(MaTX, HoTen, Cmnd, SoDT, DiaChi, BienSo, MaKV, Email, TaiKhoanNH) VALUES (N'5', N'Tuyết', N'151261518799', N'0748831348', N'Bình Thạnh', N'51JR-99924', N'6', N'Elbert.Jordan483@nowhere.com', N'206245994')
INSERT dbo.TAI_XE(MaTX, HoTen, Cmnd, SoDT, DiaChi, BienSo, MaKV, Email, TaiKhoanNH) VALUES (N'3', N'Hồng', N'473034020671', N'0423463168', N'3', N'51YA-73506', N'5', N'Seay11@example.com', N'528562859')
GO

--
-- Inserting data into table dbo.CHI_NHANH
--
INSERT dbo.CHI_NHANH(MaCN, MaDT, MaKV, DiaChiCuThe) VALUES (N'3', N'1', N'6', N'Lê Thánh Tôn')
INSERT dbo.CHI_NHANH(MaCN, MaDT, MaKV, DiaChiCuThe) VALUES (N'1', N'1', N'8', N'Nguyễn Thị Lựu	')
INSERT dbo.CHI_NHANH(MaCN, MaDT, MaKV, DiaChiCuThe) VALUES (N'5', N'4', N'7', N'Thi Sách')
INSERT dbo.CHI_NHANH(MaCN, MaDT, MaKV, DiaChiCuThe) VALUES (N'7', N'8', N'7', N'Cô Giang 	')
INSERT dbo.CHI_NHANH(MaCN, MaDT, MaKV, DiaChiCuThe) VALUES (N'6', N'6', N'6', N'Lê Thị Hồng Gấm	')
GO

--
-- Inserting data into table dbo.DON_HANG
--
INSERT dbo.DON_HANG(MaDH, MaDT, MaKH, HinhThuc_ThanhToan, TenDuong, MaKV, TongPhiSP, PhiVanChuyen, TinhTrangDH) VALUES (N'9', N'7', N'8', N'Check', N'Nguyễn Hữu Cầu	', N'8', 6695.69, 10630, N'Đang nhận hàng')
INSERT dbo.DON_HANG(MaDH, MaDT, MaKH, HinhThuc_ThanhToan, TenDuong, MaKV, TongPhiSP, PhiVanChuyen, TinhTrangDH) VALUES (N'4', N'8', N'8', N'WebMoney', N'Nguyễn Cửu Vân	', N'8', 1340.34, 4234.23, N'Đang giao hàng')
INSERT dbo.DON_HANG(MaDH, MaDT, MaKH, HinhThuc_ThanhToan, TenDuong, MaKV, TongPhiSP, PhiVanChuyen, TinhTrangDH) VALUES (N'2', N'6', N'8', N'Credit Card', N'Phan Kế Bính', N'2', 2794.79, 5140.14, N'Đang xử lý hàng')
INSERT dbo.DON_HANG(MaDH, MaDT, MaKH, HinhThuc_ThanhToan, TenDuong, MaKV, TongPhiSP, PhiVanChuyen, TinhTrangDH) VALUES (N'6', N'4', N'3', N'WebMoney', N'Nguyễn Siêu	', N'2', 3465.46, 10670, N'Đang nhận hàng')
INSERT dbo.DON_HANG(MaDH, MaDT, MaKH, HinhThuc_ThanhToan, TenDuong, MaKV, TongPhiSP, PhiVanChuyen, TinhTrangDH) VALUES (N'1', N'8', N'8', N'WebMoney', N'Thạch Thị Thanh', N'8', 1640.64, 3446.45, N'Đang giao hàng')
GO

--
-- Inserting data into table dbo.HOP_DONG
--
INSERT dbo.HOP_DONG(MaHD, MaDT, SoCNDangKy, TG_HieuLucHD, PhanTramHoaHong) VALUES (N'1', N'7', N'4', '2025-02-10', 10000)
INSERT dbo.HOP_DONG(MaHD, MaDT, SoCNDangKy, TG_HieuLucHD, PhanTramHoaHong) VALUES (N'4', N'1', N'1', '2025-01-03', 10000)
INSERT dbo.HOP_DONG(MaHD, MaDT, SoCNDangKy, TG_HieuLucHD, PhanTramHoaHong) VALUES (N'3', N'4', N'6', '2027-05-29', 9781.78)
INSERT dbo.HOP_DONG(MaHD, MaDT, SoCNDangKy, TG_HieuLucHD, PhanTramHoaHong) VALUES (N'9', N'6', N'8', '2025-08-12', 23341.34)
GO

--
-- Inserting data into table dbo.CT_HOPDONG
--
INSERT dbo.CT_HOPDONG(MaHD, MaCN) VALUES (N'1', N'1')
INSERT dbo.CT_HOPDONG(MaHD, MaCN) VALUES (N'9', N'6')
INSERT dbo.CT_HOPDONG(MaHD, MaCN) VALUES (N'4', N'5')
INSERT dbo.CT_HOPDONG(MaHD, MaCN) VALUES (N'3', N'7')
GO

--
-- Inserting data into table dbo.GIAO_HANG
--
INSERT dbo.GIAO_HANG(MaTX, MaDH, HoaHong) VALUES (N'6', N'1', 8779087.7909)
INSERT dbo.GIAO_HANG(MaTX, MaDH, HoaHong) VALUES (N'4', N'2', 2324647.2465)
INSERT dbo.GIAO_HANG(MaTX, MaDH, HoaHong) VALUES (N'5', N'9', 8826923.2692)
INSERT dbo.GIAO_HANG(MaTX, MaDH, HoaHong) VALUES (N'2', N'6', 5795051.9505)
INSERT dbo.GIAO_HANG(MaTX, MaDH, HoaHong) VALUES (N'3', N'4', 79359.6186)
GO

--
-- Inserting data into table dbo.SAN_PHAM
--
INSERT dbo.SAN_PHAM(MaSP, MaCN, TenSanPham, Loai, Gia) VALUES (N'4', N'5', N'Xì dầu', N'1', 10000)
INSERT dbo.SAN_PHAM(MaSP, MaCN, TenSanPham, Loai, Gia) VALUES (N'1', N'3', N'Trà hòa tan', N'2', 10000)
INSERT dbo.SAN_PHAM(MaSP, MaCN, TenSanPham, Loai, Gia) VALUES (N'5', N'3', N'Dầu gội', N'1', 29396.4)
INSERT dbo.SAN_PHAM(MaSP, MaCN, TenSanPham, Loai, Gia) VALUES (N'8', N'3', N'Bàn chải đánh răng', N'2', 10004)
INSERT dbo.SAN_PHAM(MaSP, MaCN, TenSanPham, Loai, Gia) VALUES (N'6', N'6', N'Máy quạt', N'1', 10920)
GO

--
-- Inserting data into table dbo.CT_DONHANG
--
INSERT dbo.CT_DONHANG(MaDH, MaSP, SoLuong) VALUES (N'6', N'5', 6)
INSERT dbo.CT_DONHANG(MaDH, MaSP, SoLuong) VALUES (N'4', N'4', 3)
INSERT dbo.CT_DONHANG(MaDH, MaSP, SoLuong) VALUES (N'1', N'8', 6)
INSERT dbo.CT_DONHANG(MaDH, MaSP, SoLuong) VALUES (N'2', N'1', 4)
INSERT dbo.CT_DONHANG(MaDH, MaSP, SoLuong) VALUES (N'9', N'6', 9)

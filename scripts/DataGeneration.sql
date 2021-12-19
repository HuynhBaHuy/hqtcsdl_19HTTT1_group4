USE [OnlineOrderingSystem]
GO
INSERT [dbo].[LOAI_HANG] ([MaLoai], [TenLoai]) VALUES (N'001', N'Túi Xách')
INSERT [dbo].[LOAI_HANG] ([MaLoai], [TenLoai]) VALUES (N'002', N'Điện Thoại')
INSERT [dbo].[LOAI_HANG] ([MaLoai], [TenLoai]) VALUES (N'003', N'Laptop')
INSERT [dbo].[LOAI_HANG] ([MaLoai], [TenLoai]) VALUES (N'004', N'Máy tính PC')
INSERT [dbo].[LOAI_HANG] ([MaLoai], [TenLoai]) VALUES (N'005', N'Linh kiện PC')
INSERT [dbo].[LOAI_HANG] ([MaLoai], [TenLoai]) VALUES (N'006', N'Thời Trang')
INSERT [dbo].[LOAI_HANG] ([MaLoai], [TenLoai]) VALUES (N'007', N'Phụ kiện thời trang')
INSERT [dbo].[LOAI_HANG] ([MaLoai], [TenLoai]) VALUES (N'008', N'Mỹ phẩm')
INSERT [dbo].[LOAI_HANG] ([MaLoai], [TenLoai]) VALUES (N'009', N'Đồ gia dụng')
INSERT [dbo].[LOAI_HANG] ([MaLoai], [TenLoai]) VALUES (N'010', N'Nội thất')
GO
INSERT [dbo].[KHU_VUC] ([MaKV], [Quan], [Tinh]) VALUES (N'001', N'1', N'TPHCM')
INSERT [dbo].[KHU_VUC] ([MaKV], [Quan], [Tinh]) VALUES (N'002', N'2', N'TPHCM')
INSERT [dbo].[KHU_VUC] ([MaKV], [Quan], [Tinh]) VALUES (N'003', N'3', N'TPHCM')
INSERT [dbo].[KHU_VUC] ([MaKV], [Quan], [Tinh]) VALUES (N'004', N'4', N'TPHCM')
INSERT [dbo].[KHU_VUC] ([MaKV], [Quan], [Tinh]) VALUES (N'005', N'5', N'TPHCM')
INSERT [dbo].[KHU_VUC] ([MaKV], [Quan], [Tinh]) VALUES (N'006', N'Đống Đa ', N'Hà Nội')
INSERT [dbo].[KHU_VUC] ([MaKV], [Quan], [Tinh]) VALUES (N'007', N'Thanh Xuân', N'Hà Nội')
INSERT [dbo].[KHU_VUC] ([MaKV], [Quan], [Tinh]) VALUES (N'008', N'Hà Đông', N'Hà Nội')
INSERT [dbo].[KHU_VUC] ([MaKV], [Quan], [Tinh]) VALUES (N'009', N'Mê Linh', N'Hà Nội')
INSERT [dbo].[KHU_VUC] ([MaKV], [Quan], [Tinh]) VALUES (N'010', N'Hoàn Kiếm', N'Hà Nội')
INSERT [dbo].[KHU_VUC] ([MaKV], [Quan], [Tinh]) VALUES (N'011', N'Liên Chiểu ', N'Đà Nẵng')
INSERT [dbo].[KHU_VUC] ([MaKV], [Quan], [Tinh]) VALUES (N'012', N'Ngũ Hành Sơn', N'Đà Nẵng')
GO
INSERT [dbo].[DOI_TAC] ([MaDT], [TenDT], [NguoiDaiDien], [MaKV], [SoChiNhanh], [SLDH], [MaLoai], [DiaChiKD], [SoDT], [Email], [MaSoThue]) VALUES (N'001', N'Công ty Thanh Hân', N'Thùy', N'001', 2, 56, N'005', N'04 Hai Bà Trưng', N'0777734529', N'SixtaMyrick855@nowhere.com', N'515')
INSERT [dbo].[DOI_TAC] ([MaDT], [TenDT], [NguoiDaiDien], [MaKV], [SoChiNhanh], [SLDH], [MaLoai], [DiaChiKD], [SoDT], [Email], [MaSoThue]) VALUES (N'002', N'Công ty ExpressVN', N'Cương', N'002', 1, 12, N'006', N'12/33 Thanh Trì', N'0357931292', N'hcec8@nowhere.com', N'922')
INSERT [dbo].[DOI_TAC] ([MaDT], [TenDT], [NguoiDaiDien], [MaKV], [SoChiNhanh], [SLDH], [MaLoai], [DiaChiKD], [SoDT], [Email], [MaSoThue]) VALUES (N'003', N'Công ty Bình Minh', N'Bình', N'004', 1, 33, N'002', N'32 Gia Lâm', N'0375795832', N'seriad12@example.com', N'894')
INSERT [dbo].[DOI_TAC] ([MaDT], [TenDT], [NguoiDaiDien], [MaKV], [SoChiNhanh], [SLDH], [MaLoai], [DiaChiKD], [SoDT], [Email], [MaSoThue]) VALUES (N'004', N'Công ty Kho Bãi VN', N'Ngọc', N'006', 1, 15, N'008', N'92 Đào Duy Từ ', N'0133223216', N'Kilpatrick362@nowhere.com', N'341')
INSERT [dbo].[DOI_TAC] ([MaDT], [TenDT], [NguoiDaiDien], [MaKV], [SoChiNhanh], [SLDH], [MaLoai], [DiaChiKD], [SoDT], [Email], [MaSoThue]) VALUES (N'005', N'Công ty Long An', N'Hân', N'010', 2, 4, N'009', N'09 Nguyễn Chí Thanh', N'0584267625', N'Quinn_V.Kuykendall@nowhere.com', N'227')
INSERT [dbo].[DOI_TAC] ([MaDT], [TenDT], [NguoiDaiDien], [MaKV], [SoChiNhanh], [SLDH], [MaLoai], [DiaChiKD], [SoDT], [Email], [MaSoThue]) VALUES (N'006', N'Công ty Thanh Main', N'Thanh', N'001', 1, 32, N'001', N'09 Bà Triệu', N'0939201223', N'thanh_main@gmail.com', N'321')
GO
INSERT [dbo].[CHI_NHANH] ([MaCN], [MaDT], [MaKV], [DiaChiCuThe]) VALUES (N'001', N'001', N'003', N'Lê Thánh Tôn')
INSERT [dbo].[CHI_NHANH] ([MaCN], [MaDT], [MaKV], [DiaChiCuThe]) VALUES (N'002', N'001', N'005', N'Nguyễn Thị Lựu')
INSERT [dbo].[CHI_NHANH] ([MaCN], [MaDT], [MaKV], [DiaChiCuThe]) VALUES (N'003', N'003', N'002', N'Thi Sách')
INSERT [dbo].[CHI_NHANH] ([MaCN], [MaDT], [MaKV], [DiaChiCuThe]) VALUES (N'004', N'004', N'005', N'Cô Giang')
INSERT [dbo].[CHI_NHANH] ([MaCN], [MaDT], [MaKV], [DiaChiCuThe]) VALUES (N'005', N'005', N'001', N'Lê Thị Hồng Gấm')
INSERT [dbo].[CHI_NHANH] ([MaCN], [MaDT], [MaKV], [DiaChiCuThe]) VALUES (N'006', N'002', N'003', N'Nguyễn Thị Minh Khai')
INSERT [dbo].[CHI_NHANH] ([MaCN], [MaDT], [MaKV], [DiaChiCuThe]) VALUES (N'007', N'005', N'005', N'Thanh Hoài')
INSERT [dbo].[CHI_NHANH] ([MaCN], [MaDT], [MaKV], [DiaChiCuThe]) VALUES (N'008', N'006', N'006', N'Mai An Vương')
GO
INSERT [dbo].[HOP_DONG] ([MaHD], [MaDT], [SoCNDangKy], [TG_HieuLucHD], [PhanTramHoaHong]) VALUES (N'001', N'001', 2, CAST(N'2025-02-10' AS Date), 10)
INSERT [dbo].[HOP_DONG] ([MaHD], [MaDT], [SoCNDangKy], [TG_HieuLucHD], [PhanTramHoaHong]) VALUES (N'002', N'002', 1, CAST(N'2025-01-03' AS Date), 12)
INSERT [dbo].[HOP_DONG] ([MaHD], [MaDT], [SoCNDangKy], [TG_HieuLucHD], [PhanTramHoaHong]) VALUES (N'003', N'003', 1, CAST(N'2020-05-29' AS Date), 30)
INSERT [dbo].[HOP_DONG] ([MaHD], [MaDT], [SoCNDangKy], [TG_HieuLucHD], [PhanTramHoaHong]) VALUES (N'004', N'004', 1, CAST(N'2021-08-12' AS Date), 25)
INSERT [dbo].[HOP_DONG] ([MaHD], [MaDT], [SoCNDangKy], [TG_HieuLucHD], [PhanTramHoaHong]) VALUES (N'005', N'005', 2, CAST(N'2021-05-01' AS Date), 21)
INSERT [dbo].[HOP_DONG] ([MaHD], [MaDT], [SoCNDangKy], [TG_HieuLucHD], [PhanTramHoaHong]) VALUES (N'006', N'006', 1, CAST(N'2021-02-02' AS Date), 20)
GO
INSERT [dbo].[KHACH_HANG] ([MaKH], [TenKH], [SoDT]) VALUES (N'001', N'Thảo', N'0904212321')
INSERT [dbo].[KHACH_HANG] ([MaKH], [TenKH], [SoDT]) VALUES (N'002', N'Huy', N'0903211223')
INSERT [dbo].[KHACH_HANG] ([MaKH], [TenKH], [SoDT]) VALUES (N'003', N'Khang', N'0902042013')
INSERT [dbo].[KHACH_HANG] ([MaKH], [TenKH], [SoDT]) VALUES (N'004', N'Ly', N'0902112321')
INSERT [dbo].[KHACH_HANG] ([MaKH], [TenKH], [SoDT]) VALUES (N'005', N'Thanh', N'0992311234')
INSERT [dbo].[KHACH_HANG] ([MaKH], [TenKH], [SoDT]) VALUES (N'006', N'Quân', N'0992100231')
INSERT [dbo].[KHACH_HANG] ([MaKH], [TenKH], [SoDT]) VALUES (N'007', N'My', N'0123122102')
INSERT [dbo].[KHACH_HANG] ([MaKH], [TenKH], [SoDT]) VALUES (N'008', N'Vy', N'0299120932')
INSERT [dbo].[KHACH_HANG] ([MaKH], [TenKH], [SoDT]) VALUES (N'009', N'Ny', N'0889732102')
INSERT [dbo].[KHACH_HANG] ([MaKH], [TenKH], [SoDT]) VALUES (N'010', N'Xuân', N'0990211232')
GO
INSERT [dbo].[DON_HANG] ([MaDH], [MaDT], [MaKH], [HinhThuc_ThanhToan], [TenDuong], [MaKV], [TongPhiSP], [PhiVanChuyen], [TinhTrangDH]) VALUES (N'001', N'001', N'003', N'Check', N'Nguyễn Hữu Cầu	', N'001', 690, 10, N'Nhập kho quận 1, TPHCM')
INSERT [dbo].[DON_HANG] ([MaDH], [MaDT], [MaKH], [HinhThuc_ThanhToan], [TenDuong], [MaKV], [TongPhiSP], [PhiVanChuyen], [TinhTrangDH]) VALUES (N'002', N'004', N'001', N'WebMoney', N'Nguyễn Cửu Vân	', N'003', 1300.34, 22.3, N'Đang giao hàng')
INSERT [dbo].[DON_HANG] ([MaDH], [MaDT], [MaKH], [HinhThuc_ThanhToan], [TenDuong], [MaKV], [TongPhiSP], [PhiVanChuyen], [TinhTrangDH]) VALUES (N'003', N'005', N'002', N'Credit Card', N'Phan Kế Bính', N'006', 2700.79, 51.1, N'Hoàn trả hàng')
INSERT [dbo].[DON_HANG] ([MaDH], [MaDT], [MaKH], [HinhThuc_ThanhToan], [TenDuong], [MaKV], [TongPhiSP], [PhiVanChuyen], [TinhTrangDH]) VALUES (N'004', N'001', N'004', N'WebMoney', N'Nguyễn Siêu	', N'001', 3200.46, 13.12, N'Nhập kho quận 1, TPHCM')
INSERT [dbo].[DON_HANG] ([MaDH], [MaDT], [MaKH], [HinhThuc_ThanhToan], [TenDuong], [MaKV], [TongPhiSP], [PhiVanChuyen], [TinhTrangDH]) VALUES (N'005', N'001', N'005', N'WebMoney', N'Thạch Thị Thanh', N'001', 142, 12.45, N'Nhập kho quận 1, TPHCM')
INSERT [dbo].[DON_HANG] ([MaDH], [MaDT], [MaKH], [HinhThuc_ThanhToan], [TenDuong], [MaKV], [TongPhiSP], [PhiVanChuyen], [TinhTrangDH]) VALUES (N'006', N'001', N'002', N'Credit Card ', N'Phan Thanh Tùng', N'003', 321.3, 33.3, N'Nhập kho quận 3, TPHCM')
INSERT [dbo].[DON_HANG] ([MaDH], [MaDT], [MaKH], [HinhThuc_ThanhToan], [TenDuong], [MaKV], [TongPhiSP], [PhiVanChuyen], [TinhTrangDH]) VALUES (N'007', N'002', N'003', N'Cash', N'Phan Đăng Lưu', N'001', 32.44, 11.4, N'Đang giao hàng')
INSERT [dbo].[DON_HANG] ([MaDH], [MaDT], [MaKH], [HinhThuc_ThanhToan], [TenDuong], [MaKV], [TongPhiSP], [PhiVanChuyen], [TinhTrangDH]) VALUES (N'008', N'001', N'005', N'Cash', N'Minh Khai', N'003', 55.3, 12.2, N'Nhập kho quận 3, TPHCM')
INSERT [dbo].[DON_HANG] ([MaDH], [MaDT], [MaKH], [HinhThuc_ThanhToan], [TenDuong], [MaKV], [TongPhiSP], [PhiVanChuyen], [TinhTrangDH]) VALUES (N'009', N'001', N'001', N'Cash', N'Hoàn Triểu', N'009', 32.2, 11, N'Nhập kho quận Mê Linh, Hà Nội')
GO
INSERT [dbo].[CT_HOPDONG] ([MaHD], [MaCN]) VALUES (N'001', N'001')
INSERT [dbo].[CT_HOPDONG] ([MaHD], [MaCN]) VALUES (N'001', N'002')
INSERT [dbo].[CT_HOPDONG] ([MaHD], [MaCN]) VALUES (N'002', N'006')
INSERT [dbo].[CT_HOPDONG] ([MaHD], [MaCN]) VALUES (N'003', N'003')
INSERT [dbo].[CT_HOPDONG] ([MaHD], [MaCN]) VALUES (N'004', N'004')
INSERT [dbo].[CT_HOPDONG] ([MaHD], [MaCN]) VALUES (N'005', N'005')
INSERT [dbo].[CT_HOPDONG] ([MaHD], [MaCN]) VALUES (N'005', N'007')
INSERT [dbo].[CT_HOPDONG] ([MaHD], [MaCN]) VALUES (N'006', N'008')
GO
INSERT [dbo].[SAN_PHAM] ([MaSP], [MaCN], [TenSanPham], [Loai], [Gia]) VALUES (N'001', N'002', N'Túi xách Louis Vuiton', N'001', 10.3)
INSERT [dbo].[SAN_PHAM] ([MaSP], [MaCN], [TenSanPham], [Loai], [Gia]) VALUES (N'002', N'002', N'Túi xách Gucci', N'001', 132.2)
INSERT [dbo].[SAN_PHAM] ([MaSP], [MaCN], [TenSanPham], [Loai], [Gia]) VALUES (N'003', N'001', N'Túi xách Hermes', N'001', 29.2)
INSERT [dbo].[SAN_PHAM] ([MaSP], [MaCN], [TenSanPham], [Loai], [Gia]) VALUES (N'004', N'003', N'Iphone 12', N'002', 2000)
INSERT [dbo].[SAN_PHAM] ([MaSP], [MaCN], [TenSanPham], [Loai], [Gia]) VALUES (N'005', N'006', N'Áo sơ mi Zara', N'006', 22.3)
GO
INSERT [dbo].[CT_DONHANG] ([MaDH], [MaSP], [SoLuong]) VALUES (N'001', N'001', 6)
INSERT [dbo].[CT_DONHANG] ([MaDH], [MaSP], [SoLuong]) VALUES (N'002', N'001', 4)
INSERT [dbo].[CT_DONHANG] ([MaDH], [MaSP], [SoLuong]) VALUES (N'004', N'003', 9)
INSERT [dbo].[CT_DONHANG] ([MaDH], [MaSP], [SoLuong]) VALUES (N'004', N'004', 3)
INSERT [dbo].[CT_DONHANG] ([MaDH], [MaSP], [SoLuong]) VALUES (N'005', N'005', 6)
INSERT [dbo].[CT_DONHANG] ([MaDH], [MaSP], [SoLuong]) VALUES (N'006', N'004', 2)
INSERT [dbo].[CT_DONHANG] ([MaDH], [MaSP], [SoLuong]) VALUES (N'007', N'003', 1)
INSERT [dbo].[CT_DONHANG] ([MaDH], [MaSP], [SoLuong]) VALUES (N'008', N'002', 3)
INSERT [dbo].[CT_DONHANG] ([MaDH], [MaSP], [SoLuong]) VALUES (N'009', N'005', 2)
GO
INSERT [dbo].[TAI_XE] ([MaTX], [HoTen], [Cmnd], [SoDT], [DiaChi], [BienSo], [MaKV], [Email], [TaiKhoanNH]) VALUES (N'001', N'Minh Tùng', N'475852141830', N'0131126132', N'1 Nguyễn Minh', N'51QL-40595', N'001', N'HomerBustos9@example.com', N'593637956')
INSERT [dbo].[TAI_XE] ([MaTX], [HoTen], [Cmnd], [SoDT], [DiaChi], [BienSo], [MaKV], [Email], [TaiKhoanNH]) VALUES (N'002', N'Thanh Tuệ', N'017210543179', N'0877586768', N'21 Nguyễn Văn Cừ', N'51SW-96679', N'002', N'DanaABrannon8@example.com', N'221725785')
INSERT [dbo].[TAI_XE] ([MaTX], [HoTen], [Cmnd], [SoDT], [DiaChi], [BienSo], [MaKV], [Email], [TaiKhoanNH]) VALUES (N'003', N'Hiền Nhung', N'031794749852', N'0493211423', N'32 Cao lỗ', N'51II-78811', N'005', N'Calkins@nowhere.com', N'708143496')
INSERT [dbo].[TAI_XE] ([MaTX], [HoTen], [Cmnd], [SoDT], [DiaChi], [BienSo], [MaKV], [Email], [TaiKhoanNH]) VALUES (N'004', N'Xuân Khang', N'151261518799', N'0748831348', N'84/2 Nguyễn Thị Minh Khai', N'51JR-99924', N'003', N'Elbert.Jordan483@nowhere.com', N'206245994')
INSERT [dbo].[TAI_XE] ([MaTX], [HoTen], [Cmnd], [SoDT], [DiaChi], [BienSo], [MaKV], [Email], [TaiKhoanNH]) VALUES (N'005', N'Đặng Nam', N'473034020671', N'0423463168', N'32/1 Điện Biên Phủ', N'51YA-73506', N'006', N'Seay11@example.com', N'528562859')
GO
INSERT [dbo].[GIAO_HANG] ([MaTX], [MaDH], [HoaHong]) VALUES (N'001', N'007', 4.2000)
INSERT [dbo].[GIAO_HANG] ([MaTX], [MaDH], [HoaHong]) VALUES (N'004', N'002', 5.2000)
INSERT [dbo].[GIAO_HANG] ([MaTX], [MaDH], [HoaHong]) VALUES (N'005', N'003', 2.2000)
GO

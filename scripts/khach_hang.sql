CREATE TABLE DON_HANG (
	MaDH varchar(20),
	MaDT varchar(20),
	TongPhiSP float,
	PhiVanChuyen float,
	TinhTrangDH nvarchar(50)

	PRIMARY KEY (MADH)
)

CREATE TABLE CT_DONHANG (
	MaDH varchar(20),
	MaSP varchar(20),
	SoLuong int

	PRIMARY KEY (MADH, MASP)
	CONSTRAINT CHK_SoLuong CHECK (SoLuong > 0)
)

CREATE TABLE DAT_HANG (
	MaDH varchar(20),
	MaKH varchar(20),
	HinhThuc_ThanhToan nvarchar(50) NOT NULL,
	TenDuong nvarchar(50) NOT NULL,
	MaKV varchar(20)

	PRIMARY KEY (MADH)
)

CREATE TABLE KHU_VUC (
	MaKV varchar(20),
	Quan nvarchar(50) NOT NULL,
	Tinh nvarchar(50) NOT NULL

	PRIMARY KEY(MAKV)
)

CREATE TABLE SAN_PHAM (
	MaSP varchar(20),
	TenSanPham nvarchar(50),
	Loai varchar(20),
	Gia float

	PRIMARY KEY(MaSP)

	CONSTRAINT CHK_Gia CHECK (Gia > 0)
)
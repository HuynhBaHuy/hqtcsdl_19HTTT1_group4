
CREATE TABLE DOI_TAC(
	MaDT varchar(20),
	Ten_DT nvarchar(50),
	NguoiDaiDien nvarchar(50),
	SoChiNhanh int,
	SLDonHangMoiNgay int,
	LoaiHang nvarchar(50),
	DiaChiKD nvarchar(50),
	SDT varchar(15),
	Email varchar(50)

	PRIMARY KEY(MaDT),
	CONSTRAINT chek_phonenumber CHECK (SoDT not like '%[^0-9]%')
)

CREATE TABLE HOP_DONG(
	MaDT varchar(20),
	MaThue_DT varchar(20),
	NguoiDaiDien nvarchar(50),
	SoChiNhanh varchar(15),
	DiaChiChiNhanh nvarchar(100),
	Loai_HD nvarchar(10),
	TG_HieuLucHD nvarchar(10),
	PhiHoaHong float

	PRIMARY KEY(MaDT, MaThue_DT)
)
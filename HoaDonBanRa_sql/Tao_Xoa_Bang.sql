-- Tạo bảng Client
CREATE TABLE Client(
    MaKH VARCHAR(100) PRIMARY KEY,
    CusName VARCHAR(255),
    Buyer VARCHAR(255),
    CusAddress VARCHAR(255),
    CusPhone VARCHAR(255),
    CusTaxCode VARCHAR(255),
    CusEmail VARCHAR(255),
    CusEmailCC VARCHAR(255),
    CusBankName VARCHAR(255),
    CusBankNo VARCHAR(255)
);

-- Tạo bảng CurrencyType
CREATE TABLE CurrencyType(
    DonViTienTe INT PRIMARY KEY AUTO_INCREMENT,
    TenDonViTienTe VARCHAR(255)
);

-- Tạo bảng ProductProperties
CREATE TABLE ProductProperties(
    ProdAttr INT PRIMARY KEY AUTO_INCREMENT,
    TenHinhThucThanhToan VARCHAR(255)
);

-- Tạo bảng TaxPercentage
CREATE TABLE TaxPercentage(
    VATRate INT PRIMARY KEY AUTO_INCREMENT,
    TenThueSuat VARCHAR(100)
);

-- Tạo bảng PaymentMethod
CREATE TABLE PaymentMethod(
    ID_PM INT PRIMARY KEY AUTO_INCREMENT,
    phuongthucthanhtoan VARCHAR(100)
);

-- Tạo bảng Invoice
CREATE TABLE Invoice(
    Fkey VARCHAR(50) PRIMARY KEY,
    ApiInvPattern VARCHAR(255) NOT NULL,
    ApiInvSerial VARCHAR(255) NOT NULL,
    Total DOUBLE NOT NULL,
    DiscountAmount DOUBLE,
    Amount DOUBLE NOT NULL,
    VATAmount DOUBLE NOT NULL,
    AmountInWords VARCHAR(255) NOT NULL,
    SO VARCHAR(255),
    NOTE VARCHAR(255),
    TyGia DOUBLE,
    MaKH  VARCHAR(100) NOT NULL,
    ID_PM INT NOT NULL,
    DonViTienTe INT NOT NULL,
    FOREIGN KEY (MaKH) REFERENCES Client(MaKH),
    FOREIGN KEY (ID_PM) REFERENCES PaymentMethod(ID_PM),
    FOREIGN KEY (DonViTienTe) REFERENCES CurrencyType(DonViTienTe)
);

-- sản phẩm
CREATE TABLE Products(
    Code VARCHAR(50) PRIMARY KEY,
    ProdName VARCHAR(255),
    ProdUnit VARCHAR(255),
    ProdQuantity DOUBLE,
    DiscountAmount DOUBLE,
    Discount DOUBLE ,
    ProdPrice DOUBLE ,
    DiscountedTax DOUBLE,
    VATAmount DOUBLE,
    Total DOUBLE,
    Amount DOUBLE,
    Remark VARCHAR(255)
);

-- chi tiết hóa đơn
CREATE TABLE ChiTietHoaDonBanRa(
	Fkey VARCHAR(50) NOT NULL,
	ProdAttr INT NOT NULL,
	VATRate INT NOT NULL,
	Code VARCHAR(50) NOT NULL,
	FOREIGN KEY (Fkey) REFERENCES Invoice(Fkey),
	FOREIGN KEY (ProdAttr) REFERENCES ProductProperties(ProdAttr),
	FOREIGN KEY (VATRate) REFERENCES TaxPercentage(VATRate),
    FOREIGN KEY (Code) REFERENCES Products(Code)
);

-- Xoa bang
DROP TABLE Client;
DROP TABLE CurrencyType;
DROP TABLE ProductProperties;
DROP TABLE TaxPercentage;
DROP TABLE PaymentMethod;
DROP TABLE Invoice;
DROP TABLE Products;
DROP TABLE ChiTietHoaDonBanRa;
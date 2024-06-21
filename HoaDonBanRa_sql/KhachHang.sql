-- Lấy thông tin khách hàng dựa trên ID
SELECT *
FROM Client
WHERE MaKH = ''

-- Thêm thông tin khách hàng
INSERT INTO 
	Client(MaKH ,CusName, Buyer, CusAddress, 
			CusPhone, CusTaxCode, CusEmail,
			CusEmailCC, CusBankName, CusBankNo)
	VALUE(
	'KH0001','Nguyen Van A',' C.TY MinhHuyPro', 'Q. Ninh kiều, TP.Cần Thơ',
	'0123456789', '12547896357', 'nguyenvana@gmail.com',
	'','',''
	);
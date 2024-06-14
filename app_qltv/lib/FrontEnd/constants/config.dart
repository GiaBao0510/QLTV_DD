
const url = "http://192.168.1.19:3000";

const login = "$url/login"; //Đăng nhập
const logout = "$url/exit"; //Đăng xuất
const CheckValidity = "$url/refresh-token"; //Kiểm tra tính hợp lệ
const CheckLoggedIn = "$url/checkloggedin"; //Kiểm tra tính hợp lệ

// ------------------- Mat Bao
const urlMatBao = "https://api-demo.matbao.in";

//Tai khoan - mat khau
const ApiUserName = 'admin';
const ApiPassword = 'Gtybf@12sd';

//0. Đăng nhập
const loginMatBao = '/api/v2/invoice/login_api';
//1.Them hoa don - nhap <<
const ImportHoaDonNhap = "/api/v3/invoice/importInvTemp";
//2.Phat hanh hoa don
const PublishInvoice = "/api/v2/invoice/importAndPublishInv";
//3.Huy hoa don
const CancelInvoice = '/api/v2/invoice/CancelInvoice';
//4.Dieu chinh hoa don
const InvoiceAdjustment = '/api/v2/invoice/ChangeInvoice';
//5.Thay the hoa don
const RepalceInvoice = 'api/v2/invoice/ReplaceInvoice';
//6.Get Fkey
const GetFkey = 'api/v2/invoice/GetFkey';
//7. Tai file
const DownloadFilePDF = '/api/v2/invoice/DownloadPdf';
//8.Lay so hoa don sap phat hanh
const GetTheInvoiceNumberToBeIssued = 'api/v2/invoice/GetInvoiceNo';
//9. Lấy thông tin hóa đơn theo danh sách mã tra cứu fkey
const GetInformationAccordingToLookUpCodeFKeyList =
    "/api/v2/invoice/GetInvoiceNoByMultiFkey";
//10. Phát hành phiếu xuất kho
const PublishGoodsDeliveryNote = '/api/v2/invoice/importAndPublishPXK';
//11. Import phiếu xuất kho nháp
const ImportDaftGoodsDeliveryNote = '/api/v3/invoice/importInvTempPXK';
//12. Thêm mới/ Cập nhật khách hàng
const Add_updateCustomerInformation = '/api/v1/customer/updateCustomer';
//13.Xóa hóa đơn - nháp <<
const DeleteDraftInvoice = '/api/v3/invoice/deleteInvTemp';
//14. Phát hành hóa đơn - (nháp) <<
const PublishDraftInvoice = "/api/v1/digitalsignature/signinv";
//15. Ký XML
const SignXML = "api/v2/digitalsignature/signxml256";
//16. Download file XML
const DownloadFileXML = '/api/v2/invoice/DownloadXml';
//17. Thông báo sai xót
const ErrorNotification = 'base_url_api/api/v3/invoice/thongBaoSaiSot';
//18.Lấy thông tin XML chưa ký
const GetXmlNotSign = '/api/v2/invoice/GetXmlNotSign';
//19.Cập nhật thông tin XML đã ký
const UpdateXmlSigned = '/api/v2/invoice/UpdateXmlSigned';
//20. Tạo thông tin Webhook
const createWebhook = '/api/v3/invoice/createWebhook';
//21. Tạo biên bản hủy, điều chỉnh, thay thế
const CreateBBHoaDon = '/api/v2/invoice/CreateBBHoaDon';

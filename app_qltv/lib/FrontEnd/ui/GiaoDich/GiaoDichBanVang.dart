import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:number_to_vietnamese_words/number_to_vietnamese_words.dart';
import 'package:app_qltv/FrontEnd/ui/components/search_bar.dart';
import 'package:app_qltv/FrontEnd/ui/components/transitions.dart';
import 'package:app_qltv/FrontEnd/ui/components/FormatCurrency.dart';
import 'package:app_qltv/FrontEnd/Service/ThuVien.dart';
import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:app_qltv/FrontEnd/model/GiaoDich/BanVang_model.dart';
import 'package:app_qltv/FrontEnd/controller/GiaoDich/BanVang_controller.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/khachhang.dart';
import 'package:app_qltv/FrontEnd/controller/danhmuc/khachhang_manager.dart';
import 'package:app_qltv/FrontEnd/model/HoaDonBanRa/ImportDraftInvoice_model.dart';


class BanVang extends StatefulWidget {
  static const routerName = '/giaodichbanvang';
  const BanVang({super.key});

  @override
  State<BanVang> createState() => _BanVangState();
}

class _BanVangState extends State<BanVang> {
  //   --- Thuộc tính   ---
  final _formKey = GlobalKey<FormState>();
  late Future<List<Khachhang>> _khachHangFuture;
  final TextEditingController _searchController = TextEditingController();
  List<Khachhang> _filteredKhachHang = [];
  List<Khachhang> _khachHangList = [];
  late Future<TruocKhiThucHienBanVang_model> _thongTinHangHoaFuture;
  final TextEditingController _tongtien = TextEditingController(),
                              _tienbot = TextEditingController(),
                              _thanhtoan = TextEditingController(),
                              _tenKhachHang = TextEditingController(),
                              _IDkhachHang = TextEditingController();
  int _currentPage = 1;
  int _pageSize = 10;
  int _totalKhachhang = 0;
  int _totalRows = 0;

    //Tạo danh sách sản phẩm
  List<Products_model> _list_SanPham = [];

    //Lấy thông tin sản phẩm
  Products_model _SanPham = Products_model(
      code: '', ProdName: '', ProdUnit: '', ProdQuantity: 1.0,
      DiscountAmount: 0.0, Discount: 0.0, ProdPrice: 0.0, VATRate: 0.0,
      VATAmount: 0.0, Total: 0.0, Amount: 0.0, ProdAttr: 1, Remark: '');

    //Lây thong tin hoa don nhap
  late ImportDraftInvoice_Model _HoaDonNhap = ImportDraftInvoice_Model(
      ApiUserName: ApiUserName, ApiPassword: ApiPassword,
      ApiInvPattern: '1', ApiInvSerial: 'C24TAT',
      Fkey: '', ArisingDate: CurrentDateAndTime() , SO: '', MaKH: '',
      CusName: '', Buyer: '', CusAddress: '', CusPhone: '', CusTaxCode: '',
      CusEmail: '', CusEmailCC: '', CusBankName: '', CusBankNo: '', PaymentMethod: '1', Product: _list_SanPham,
      Total: 0.0, DiscountAmount: 0.0, VATAmount: 0.0, Amount: 0.0, Extra: '',
      DonViTienTe: 704, TyGia: 0.0, AmountInWords: '');

    //Lấy thông tin trước khi bán vàng
  late TruocKhiThucHienBanVang_model _ThongTinHangHoa ;

    //Lấy thông tin nếu sau khi bán vàng
  late SauKhiThucHienBangVang_model _ThongTinhThucHienBanVang = SauKhiThucHienBangVang_model(
      KH_ID: '',
      TONG_TIEN: 0.0, KHACH_DUA: 0.0, THOI_LAI: 0.0,
      TONG_SL: 1.1, CAN_TONG: 0.0, TL_HOT: 0.0,
      GIA_CONG: 0.0, TIEN_BOT: 0.0,
      THANH_TOAN: 0.0, HANGHOAID: '',
      HANGHOAMA: '', HANG_HOA_TEN: '',
      SO_LUONG: 1.0, DON_GIA: 0.0, THANH_TIEN: 0.0,
      NHOMHANGID: '', LOAIVANG: '');

  // --- Phương thức/ Hàm ----

    //1. Load dữ liệu
  Future<void> _LoadData() async{
    //Lấy thông tin hàng hóa
    _thongTinHangHoaFuture = Provider.of<BanvangController>(context, listen: false)
        .ThongTinSanPham();
    _thongTinHangHoaFuture.then((thongtin){
      setState(() {
        _ThongTinHangHoa = thongtin;
      });
    });
    print('Đã check thông tin sản phâẩm');

    //Lưu lại thoog tin sản phẩm cho MATBAO
    setState(() {
      _SanPham = _SanPham.copyWith(code: _ThongTinHangHoa.MA);
      _SanPham = _SanPham.copyWith(ProdName: _ThongTinHangHoa.TEN_HANG);
      _SanPham = _SanPham.copyWith(ProdPrice: _ThongTinHangHoa.DON_GIA_BAN);
      _SanPham = _SanPham.copyWith(ProdQuantity: 1.0);
      _SanPham = _SanPham.copyWith(Total: _ThongTinHangHoa.THANH_TIEN);
      _SanPham = _SanPham.copyWith(VATAmount: _ThongTinHangHoa.THANH_TIEN);
      _SanPham = _SanPham.copyWith(Amount: _ThongTinHangHoa.THANH_TIEN);
      _SanPham = _SanPham.copyWith(ProdUnit: 'Chiếc');
      _SanPham = _SanPham.copyWith(ProdAttr: 1);
    });

    //_list_SanPham.add(_SanPham);
  }

    //2.Load danh sách khách hàng
  Future<void> _loadKhachhang({int page = 1}) async{
    final manager = Provider.of<KhachhangManage>(context, listen: false);
    //Lấy thông tin khách hàng
    _khachHangFuture = Provider.of<KhachhangManage>(context, listen: false)
        .fetchKhachhang(page: page, pageSize: _pageSize);
    _khachHangFuture.then((clients){
      setState(() {
        _khachHangList = clients;
        _filteredKhachHang = clients;
        _currentPage = page;
        _totalRows = manager.totalRows;
      });
    });
  }

    //3.Đếm số tỏng khách hàng
    Future<void> _loadTotalKhachhang() async{
      final totalKhachhang = await Provider.of<KhachhangManage>(context, listen: false).fetchTotalKhachhang();

      setState(() {
        _totalKhachhang = totalKhachhang;
      });
    }

    //4. Tạo bộ lọc tìm khách hàng dựa trên tên
  void _filterKhachhang(){
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredKhachHang = _khachHangList.where((client){
        return client.kh_ten!.toLowerCase().contains(query);
      }).toList();
    });
  }

    //5. Cập nhật gi trị thanh toán
  void _updateThanhToan(){
    final tongTien = double.tryParse(_tongtien.text) ?? 0.0;
    final tienBot = double.tryParse(_tienbot.text) ?? 0.0;
    final thanhToan = tongTien - tienBot;
    _thanhtoan.text = thanhToan.toStringAsFixed(2);
  }

  @override
  void initState() {
    super.initState();
    _tongtien.text = _ThongTinhThucHienBanVang.TONG_TIEN.toString();
    _tienbot.text = _ThongTinhThucHienBanVang.TIEN_BOT.toString();
    _tenKhachHang.text = "";
    _IDkhachHang.text = "";
    _updateThanhToan();
    _tongtien.addListener(_updateThanhToan);
    _tienbot.addListener(_updateThanhToan);
    _LoadData();
    _loadKhachhang();
    _searchController.addListener(_filterKhachhang);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tongtien.dispose();
    _tienbot.dispose();
    _thanhtoan.dispose();
    _tenKhachHang.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 228, 200, 126),
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.left_chevron,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const FittedBox(
          fit: BoxFit.fitWidth,
          child: Text('Giao dịch bán vàng'),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            //Màu nền
            Positioned(
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                        gradient:LinearGradient(
                          colors: [Color(0xffe6e6e6), Color(0xffc6c7c2)],
                          stops: [0, 1],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    )
                )
            ),

            //Phần nhận thông tin
            FutureBuilder<TruocKhiThucHienBanVang_model>(
              future: _thongTinHangHoaFuture,
              builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(fontSize: 10),
                      ));
                }else{
                  return ListView(
                    children: [
                      Column(
                        children: [

                          //Khung hiển thị thông tin
                          Container(
                              margin: EdgeInsets.all(15),
                              padding: EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                gradient: LinearGradient(
                                  colors: [Color(0xfff09819), Color(0xffedde5d)],
                                  stops: [0, 1],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                          text: 'Mã:',
                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
                                          children: <TextSpan>[
                                            TextSpan(text: ' ${_ThongTinHangHoa.MA}', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15) )
                                          ]
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                          text: 'Tên hàng:',
                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
                                          children: <TextSpan>[
                                            TextSpan(text: ' ${_ThongTinHangHoa.TEN_HANG}', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15) )
                                          ]
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                          text: 'Loại:',
                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
                                          children: <TextSpan>[
                                            TextSpan(text: ' ${_ThongTinHangHoa.LOAIVANG}', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15) )
                                          ]
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                          text: 'Cân tổng:',
                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
                                          children: <TextSpan>[
                                            TextSpan(text: ' ${ formatCurrencyDouble(_ThongTinHangHoa.CAN_TONG ?? 0.0)}', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15) )
                                          ]
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                          text: 'TL hột:',
                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
                                          children: <TextSpan>[
                                            TextSpan(text: ' ${ formatCurrencyDouble(_ThongTinHangHoa.TL_HOT ?? 0.0) }', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15) )
                                          ]
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                          text: 'Trừ hột:',
                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
                                          children: <TextSpan>[
                                            TextSpan(text: ' ${ formatCurrencyDouble(_ThongTinHangHoa.TRU_HOT ?? 0.0)}', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15) )
                                          ]
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                          text: 'Giá công:',
                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
                                          children: <TextSpan>[
                                            TextSpan(text: ' ${formatCurrencyDouble(_ThongTinHangHoa.GIA_CONG ?? 0.0)}', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15) )
                                          ]
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                          text: 'Đơn giá:',
                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
                                          children: <TextSpan>[
                                            TextSpan(text: ' ${formatCurrencyDouble(_ThongTinHangHoa.DON_GIA_BAN ?? 0.0)}', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15) )
                                          ]
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: const TextSpan(
                                          text: 'Số lượng:',
                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
                                          children: <TextSpan>[
                                            TextSpan(text: ' ${1}', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15) )
                                          ]
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                          text: 'Thành Tiền:',
                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
                                          children: <TextSpan>[
                                            TextSpan(text: ' ${formatCurrencyDouble(_ThongTinHangHoa.THANH_TIEN ?? 0.0)}', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15) )
                                          ]
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),


                          BangDienThongTin(context),
                        ],
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  //0.Form nhập tiền
  Widget BangDienThongTin(BuildContext context){

    //Cập nhật lại thông tin sau khi quét mã
    _ThongTinhThucHienBanVang = _ThongTinhThucHienBanVang.copyWith(KH_ID: '');
    _ThongTinhThucHienBanVang = _ThongTinhThucHienBanVang.copyWith(TONG_TIEN: _ThongTinHangHoa.THANH_TIEN);
    _ThongTinhThucHienBanVang = _ThongTinhThucHienBanVang.copyWith(KHACH_DUA: 0.0);
    _ThongTinhThucHienBanVang = _ThongTinhThucHienBanVang.copyWith(THOI_LAI: 0.0);
    _ThongTinhThucHienBanVang = _ThongTinhThucHienBanVang.copyWith(TONG_SL: 1.1);
    _ThongTinhThucHienBanVang = _ThongTinhThucHienBanVang.copyWith(CAN_TONG: _ThongTinHangHoa.CAN_TONG);
    _ThongTinhThucHienBanVang = _ThongTinhThucHienBanVang.copyWith(TL_HOT: _ThongTinHangHoa.TL_HOT);
    _ThongTinhThucHienBanVang = _ThongTinhThucHienBanVang.copyWith(GIA_CONG: _ThongTinHangHoa.GIA_CONG);
    _ThongTinhThucHienBanVang = _ThongTinhThucHienBanVang.copyWith(TIEN_BOT: 0.0);
    _ThongTinhThucHienBanVang = _ThongTinhThucHienBanVang.copyWith(THANH_TOAN: 0.0);
    _ThongTinhThucHienBanVang = _ThongTinhThucHienBanVang.copyWith(HANGHOAID: _ThongTinHangHoa.HANGHOAID);
    _ThongTinhThucHienBanVang = _ThongTinhThucHienBanVang.copyWith(HANGHOAMA: _ThongTinHangHoa.MA);
    _ThongTinhThucHienBanVang = _ThongTinhThucHienBanVang.copyWith(HANG_HOA_TEN: _ThongTinHangHoa.TEN_HANG);
    _ThongTinhThucHienBanVang = _ThongTinhThucHienBanVang.copyWith(SO_LUONG: 1.0);
    _ThongTinhThucHienBanVang = _ThongTinhThucHienBanVang.copyWith(DON_GIA: _ThongTinHangHoa.DON_GIA_BAN);
    _ThongTinhThucHienBanVang = _ThongTinhThucHienBanVang.copyWith(THANH_TIEN: _ThongTinHangHoa.THANH_TIEN);
    _ThongTinhThucHienBanVang = _ThongTinhThucHienBanVang.copyWith(NHOMHANGID: _ThongTinHangHoa.NHOMHANGID);
    _ThongTinhThucHienBanVang = _ThongTinhThucHienBanVang.copyWith(LOAIVANG: _ThongTinHangHoa.LOAIVANG);
    _tongtien.text = _ThongTinHangHoa.THANH_TIEN.toString();
    _thanhtoan.text = _ThongTinHangHoa.THANH_TIEN.toString();

    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Form(
        key: _formKey,
        child: Column(children: [
          Align(
            alignment: Alignment.center,
            child: FittedBox(
              child: Text('Thông tin giao dịch', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
          ),

          const SizedBox(height: 15,),
          Row(
            children: [
              Expanded(
                flex: 2,
                  child: TextFormField(
                    controller: _tenKhachHang,
                    decoration: const InputDecoration(
                      labelText: 'Tên khách hàng:',
                      labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 15.0),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    readOnly: true,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Vui lòng chọn khách hàng để thanh toán";
                      }
                      return null;
                    },
                    onSaved: (value){
                      _ThongTinhThucHienBanVang = _ThongTinhThucHienBanVang.copyWith(KH_ID: _IDkhachHang.text);
                    },
                  ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                  flex: 1,
                  child:  Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: TextButton(
                      onPressed: (){
                        BangChonKhachHang(context);
                      },
                      child: Align(
                        alignment: Alignment.center,
                          child: Text('Chọn khách hàng', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                      ),
                    ),
                  )
              ),
            ],
          ),

          const SizedBox(height: 15,),
          TextFormField(
            controller: _tongtien,
            decoration: const InputDecoration(
              labelText: 'Tổng tiền:',
              labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 15.0),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            onSaved: (value){
              _ThongTinhThucHienBanVang = _ThongTinhThucHienBanVang.copyWith(TONG_TIEN: double.tryParse(value ?? '') ?? 0.0 );
            },
          ),

          const SizedBox(height: 15,),
          TextFormField(
            controller: _tienbot,
            decoration: const InputDecoration(
              labelText: 'Tiền bớt:',
              labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 15.0),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            onSaved: (value){
              _ThongTinhThucHienBanVang = _ThongTinhThucHienBanVang.copyWith(TIEN_BOT: double.tryParse(value ?? '') ?? 0.0 );
            },
          ),

          const SizedBox(height: 15,),
          TextFormField(
            controller: _thanhtoan,
            decoration:const InputDecoration(
              labelText: 'Thanh toán:',
              labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 15.0),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            onSaved: (value){
              _ThongTinhThucHienBanVang = _ThongTinhThucHienBanVang.copyWith(THANH_TOAN: double.tryParse(value ?? '') ?? 0.0);
            },
          ),

          const SizedBox(height: 25,),
          TextButton(
            onPressed: (){
              _SaveThanhToan(context);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(
                  colors: [Color(0xffe65c00), Color(0xfff9d423)],
                  stops: [0, 1],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
              width: double.infinity,
              child:Text(
                'Thanh toán',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18) ,
                textAlign: TextAlign.center,
              ),
            )
          ),


          const SizedBox(height: 15,),
        ],)
      ),
    );
  }

  //1.Bảng chọn thông tin khách hàng
  Future<void> BangChonKhachHang(BuildContext context) async{
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Chọn khách hàng', style: TextStyle(decoration: TextDecoration.underline),),
            content: FractionallySizedBox(
              widthFactor: 1,
              child: Scrollbar(
                child: ListView(
                  children: [
                    Column(children: [
                      ShowListClient(),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                              child: ElevatedButton(
                                onPressed: (){
                                  _loadKhachhang(page: _currentPage -1);
                                },
                                child: const Text('<'),
                              )
                          ),
                          const SizedBox(width: 20,),
                          Visibility(
                              child: ElevatedButton(
                                onPressed: (){
                                  _loadKhachhang(page: _currentPage +1);
                                },
                                child: const Text('>'),
                              )
                          ),
                        ],
                      )

                    ],),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  //2.Show list Khách hàng
  FutureBuilder<List<Khachhang>> ShowListClient(){
    return FutureBuilder<List<Khachhang>>(
        future: _khachHangFuture,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }else{
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.indigo),
                  columns: [
                    DataColumn(label: Text('Tên', style: TextStyle(color: Colors.white),), ),
                    DataColumn(label: Text('Điện thoại', style: TextStyle(color: Colors.white)) ),
                    DataColumn(label: Text('Địa chỉ', style: TextStyle(color: Colors.white)) ),
                  ],
                  rows: [
                    ..._filteredKhachHang.map((client){
                      return DataRow(
                        onLongPress: (){
                          setState(() {
                            _tenKhachHang.text = client.kh_ten ?? '';
                            _IDkhachHang.text = client.kh_id ?? '';
                          });
                          Navigator.pop(context);
                        },
                          cells: [
                            DataCell(Text('${client.kh_ten}')),
                            DataCell(Text('${client.kh_sdt}')),
                            DataCell(Text('${client.kh_dia_chi}')),
                          ]
                      );
                    })
                  ]
              ),
            );
          }
        }
    );
  }

  //3.Save thông tin
  Future<void> _SaveThanhToan(BuildContext context) async{
    final isValid = _formKey.currentState!.validate();
    if(!isValid){
      return;
    }
    _ThongTinhThucHienBanVang = _ThongTinhThucHienBanVang.copyWith(KH_ID: _IDkhachHang.text);
    print('Thông tin cap nhật OK: ${_ThongTinhThucHienBanVang.toMap()}');

    //Lưu lại thông tin nếu hợp lệ
    print('Thông tin sản phẩm: ${_SanPham.toMap()}');
    _list_SanPham.forEach((e) {
      print(e.ProdPrice);
    });


    _formKey.currentState!.save();

    // try{
    //   final banVangController = Provider.of<BanvangController>(context, listen: false);
    //   await banVangController.ThucHienGiaoDichBanVang(_ThongTinhThucHienBanVang);
    //
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: const Text('Thanh toán thành công',style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center, ),
    //       backgroundColor: Colors.grey,
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(15.0),
    //         side: const BorderSide(
    //             color: Colors.grey, width: 2.0), // bo viền 15px
    //       ),
    //       behavior: SnackBarBehavior.floating,
    //       margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
    //     ),
    //   );
    //
    //   Navigator.of(context).pop(true);
    // }catch(err){
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: const Text('Có lỗi khi thực hiện thanh toán',style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center, ),
    //       backgroundColor: Colors.grey,
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(15.0),
    //         side: const BorderSide(
    //             color: Colors.grey, width: 2.0), // bo viền 15px
    //       ),
    //       behavior: SnackBarBehavior.floating,
    //       margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
    //     ),
    //   );
    // }
  }
}

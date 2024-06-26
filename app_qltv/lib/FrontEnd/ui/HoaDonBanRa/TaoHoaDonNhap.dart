import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_qltv/FrontEnd/model/HoaDonBanRa/ImportDraftInvoice_model.dart';
import 'package:app_qltv/FrontEnd/controller/HoaDonBanRa/ImportDraftInvoice_manage.dart';
import '../../constants/config.dart';
import './BangSanPham/BangSanPhamTaoHoaDon.dart';

class ThemHoaDon_nhap extends StatefulWidget {
  static const routerName = "/themhoadonnhap";
  const ThemHoaDon_nhap({super.key});

  @override
  State<ThemHoaDon_nhap> createState() => _ThemHoaDon_nhapState();
}

class _ThemHoaDon_nhapState extends State<ThemHoaDon_nhap> {
  //------------ Thuộc tinh -----------
  String paymentMethob = "Chọn hình thức thanh tóan";
  int DaChonHinhThucThanhToan = 0;        //Dung de kiem tra xem hinh thuc thanh toán da chon hay chua
  String DonViTienTe = "VND - Việt Nam Đồng";
  final _formkey = GlobalKey<FormState>();    //Bieu mau tao hoa don nhap
  late ImportDraftInvoice_Model _newHoaDon ;
  List<DataRow> TheNumberOfProducts = [];
  int SoThuTuHangSP = 0;
    //San pham dau vao
  List<Products_model> DanhSachSanPham = [];

  //Ham khoi tao
  @override
  void initState() {
    super.initState();
    _newHoaDon = ImportDraftInvoice_Model(
        ApiUserName: ApiUserName,
        ApiPassword: ApiPassword,
        ApiInvPattern: '', ApiInvSerial: '',
        Fkey: '', ArisingDate: '',
        SO: '', MaKH: '', CusName: '',
        Buyer: '', CusAddress: '',
        CusPhone: '', CusTaxCode: '',
        CusEmail: '', CusEmailCC: '',
        CusBankName: '', CusBankNo: '',
        PaymentMethod: '', Extra: '',
        AmountInWords: '',
        DonViTienTe: 704, Product: DanhSachSanPham,
        TyGia: 0.0, Total: 0.0,
        DiscountAmount: 0.0, VATAmount: 0.0, Amount: 0.0
    );
  }

  //Ham huy
  @override
  void dispose() {
    super.dispose();
  }

  //Ham luu


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 28,
        ),
        title: const FittedBox(
          fit: BoxFit.fitWidth,
          child: Text("Nhập thông tin chi tiết về Hóa đơn giá trị gia tăng", style: TextStyle(fontSize: 17,
              color: Colors.white,
              fontFamily: 'Align',
              fontWeight: FontWeight.bold),),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.orange, Colors.amber])),
        ),
      ),
      body: Scrollbar(
        child: ListView(children: [
           Container(
            padding:const EdgeInsets.fromLTRB(15, 10, 15, 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffd6d1d2), Color(0xffb7bac8)],
                stops: [0.25, 0.75],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            ),

            //--------------------------------
            //------------Biểu mẫu nhập---------------
            //--------------------------------
            child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[

                  // -- Mã KH
                  TextFormField(
                    expands: false,
                    obscureText: false,                     //Khong an ky tu
                    initialValue: _newHoaDon.MaKH.toString(),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Mã khách hàng',
                      prefixIcon: Icon(Icons.perm_identity_outlined),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2)
                      ),
                      filled: true,
                      fillColor: Colors.white
                    ),
                    validator: (value) {                    //Dieu kien dau vao
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập mã KH';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _newHoaDon = _newHoaDon.copyWith(MaKH: value); // Update the MaKH value
                    },
                  ),
                  
                  const SizedBox(height: 20,),

                  // -- Họ tên khách hàng
                  TextFormField(
                    expands: false,
                    obscureText: false,                     //Khong an ky tu
                    initialValue: _newHoaDon.CusName.toString(),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Họ tên người mua hàng',
                      prefixIcon: Icon(Icons.account_circle),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2)
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {                    //Dieu kien dau vao
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập họ tên người mua hàng';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _newHoaDon = _newHoaDon.copyWith(CusName: value); // Update the MaKH value
                    },
                  ),

                  const SizedBox(height: 20,),

                  // -- Đơn vị mua hàng
                  TextFormField(
                    expands: false,
                    obscureText: false,                     //Khong an ky tu
                    initialValue: _newHoaDon.Buyer.toString(),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Đơn vị mua hàng',
                      prefixIcon: Icon(Icons.info_outline),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2)
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {                    //Dieu kien dau vao
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập đơn vị mua hàng';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _newHoaDon = _newHoaDon.copyWith(Buyer: value); // Update the MaKH value
                    },
                  ),

                  const SizedBox(height: 20,),

                  // -- Mã số thuế --- ???
                  Row( children: [
                    Expanded(
                      flex:2,
                      child: TextFormField(
                        expands: false,
                        obscureText: false,                     //Khong an ky tu
                        initialValue: _newHoaDon.CusName.toString(),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Mã số thuế',
                          prefixIcon: Icon(Icons.info_outline),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 2)
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {                    //Dieu kien dau vao
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập mã số thuế';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _newHoaDon = _newHoaDon.copyWith(CusName: value); // Update the MaKH value
                        },
                      ),
                    ),

                    //Nut tim kiem
                    const SizedBox(width: 5,),
                    Expanded(
                      flex:1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        child: TextButton(
                          onPressed: (){
                            print('TIm kiem');
                          },
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text('Tìm kiếm', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
                        ),
                      )
                    ),
                  ],),


                  const SizedBox(height: 20,),

                  // -- Địa chỉ
                  TextFormField(
                    expands: false,
                    obscureText: false,                     //Khong an ky tu
                    initialValue: _newHoaDon.CusAddress.toString(),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Địa chỉ',
                      prefixIcon: Icon(Icons.home_work_rounded),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2)
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {                    //Dieu kien dau vao
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập Địa chỉ';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _newHoaDon = _newHoaDon.copyWith(CusAddress: value); // Update the MaKH value
                    },
                  ),

                  const SizedBox(height: 20,),

                  // -- Email khách
                  TextFormField(
                    expands: false,
                    obscureText: false,                     //Khong an ky tu
                    initialValue: _newHoaDon.CusEmail.toString(),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Email khách hàng',
                      prefixIcon: Icon(Icons.alternate_email),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2)
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {                    //Dieu kien dau vao
                      if (value!.length > 150) {
                        return 'Giới hạn dưới hoặc bằng 150 ký tự';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _newHoaDon = _newHoaDon.copyWith(CusEmail: value); // Update the MaKH value
                    },
                  ),

                  const SizedBox(height: 20,),

                  // -- Email CC
                  TextFormField(
                    expands: false,
                    obscureText: false,                     //Khong an ky tu
                    initialValue: _newHoaDon.CusEmailCC.toString(),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Email CC',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2)
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {                    //Dieu kien dau vao
                      if (value!.length > 150) {
                        return 'Giới hạn dưới hoặc bằng 150 ký tự';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _newHoaDon = _newHoaDon.copyWith(CusEmailCC: value); // Update the MaKH value
                    },
                  ),

                  // Bang san pham
                  const SizedBox(height: 20,),
                  BangSanPhamTaoHoaDon(DanhSachSanPham: DanhSachSanPham,),

                  //HInnh thưc thanh toan
                  const SizedBox(height: 20,),
                  Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                        color: Colors.black,
                        width: 1
                      ),
                    ),
                    child: PopupMenuButton(
                      itemBuilder: (BuildContext context){
                        return<PopupMenuEntry>[
                          PopupMenuItem(
                              child: TextButton(
                                onPressed: (){
                                  setState(() {
                                    paymentMethob = "Thanh toán bằng tiền mặt";
                                    _newHoaDon = _newHoaDon.copyWith(PaymentMethod: paymentMethob);
                                  });
                                  print(_newHoaDon.PaymentMethod);
                                },
                                child: Text('Thanh toán bằng tiền mặt'),
                              )
                          ),
                          PopupMenuItem(
                              child: TextButton(
                                onPressed: (){
                                  setState(() {
                                    DaChonHinhThucThanhToan = 1;
                                    paymentMethob = "Thanh toán chuyển khoản";
                                    _newHoaDon = _newHoaDon.copyWith(PaymentMethod: paymentMethob);
                                  });
                                  print(_newHoaDon.PaymentMethod);
                                },
                                child: Text('Thanh toán chuyển khoản'),
                              )
                          ),
                          PopupMenuItem(
                              child: TextButton(
                                onPressed: (){
                                  setState(() {
                                    DaChonHinhThucThanhToan = 1;
                                    paymentMethob = "Thanh toán bằng tiền mặt hoặc chuyển khoản";
                                    _newHoaDon = _newHoaDon.copyWith(PaymentMethod: paymentMethob);
                                  });
                                  print(_newHoaDon.PaymentMethod);
                                },
                                child: Text('Thanh toán bằng tiền mặt hoặc chuyển khoản'),
                              )
                          ),
                          PopupMenuItem(
                              child: TextButton(
                                onPressed: (){
                                  setState(() {
                                    DaChonHinhThucThanhToan = 1;
                                    paymentMethob = "Thanh toán thẻ tín dụng";
                                    _newHoaDon = _newHoaDon.copyWith(PaymentMethod: paymentMethob);
                                  });
                                  print(_newHoaDon.PaymentMethod);
                                },
                                child: Text('Thanh toán thẻ tín dụng'),
                              )
                          ),
                          PopupMenuItem(
                              child: TextButton(
                                onPressed: (){
                                  setState(() {
                                    DaChonHinhThucThanhToan = 1;
                                    paymentMethob = "Thanh toán bù trừ";
                                    _newHoaDon = _newHoaDon.copyWith(PaymentMethod: paymentMethob);
                                  });
                                  print(_newHoaDon.PaymentMethod);
                                },
                                child: Text('Thanh toán bù trừ'),
                              )
                          ),
                          PopupMenuItem(
                              child: TextButton(
                                onPressed: (){
                                  setState(() {
                                    DaChonHinhThucThanhToan = 1;
                                    paymentMethob = "Không thanh toán ";
                                    _newHoaDon = _newHoaDon.copyWith(PaymentMethod: paymentMethob);
                                  });
                                  print(_newHoaDon.PaymentMethod);
                                },
                                child: Text('Không thanh toán '),
                              )
                          ),
                          PopupMenuItem(
                              child: TextButton(
                                onPressed: (){
                                  setState(() {
                                    DaChonHinhThucThanhToan = 1;
                                    paymentMethob = "Thanh toán chuyển khoản hoặc bù trừ ";
                                    _newHoaDon = _newHoaDon.copyWith(PaymentMethod: paymentMethob);
                                  });
                                  print(_newHoaDon.PaymentMethod);
                                },
                                child: Text('Thanh toán chuyển khoản hoặc bù trừ '),
                              )
                          ),
                        ];
                      },
                      child:  Align(
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Expanded(
                              flex:3,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(' \t ${paymentMethob}'),
                              )
                            ),
                            const Expanded(
                                flex:1,
                                child: Icon(Icons.keyboard_arrow_down_sharp)
                            ),

                          ],
                        ),
                      ),
                      onSelected: ( DaChonHinhThucThanhToan){
                        if(DaChonHinhThucThanhToan == 0){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Vui lòng chọn hình thức thanh toán'),
                            )
                          );
                        }
                      },
                    ),
                  ),

                  const SizedBox(height: 20,),

                  // -- Số hợp đồng/ Báo giá/ Vận đơn
                  TextFormField(
                    expands: false,
                    obscureText: false,                     //Khong an ky tu
                    initialValue: _newHoaDon.CusName.toString(),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Số hợp đồng/ Báo giá/ Vận đơn',
                      prefixIcon: Icon(Icons.note_alt),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2)
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {                    //Dieu kien dau vao
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập họ tên người mua hàng';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _newHoaDon = _newHoaDon.copyWith(CusName: value); // Update the MaKH value
                    },
                  ),

                  const SizedBox(height: 20,),

                  // -- Ghi chu
                  TextFormField(
                    expands: false,
                    obscureText: false,                     //Khong an ky tu
                    initialValue: _newHoaDon.Extra.toString(),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Ghi chú',
                      prefixIcon: Icon(Icons.edit_note),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2)
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onSaved: (value) {
                      _newHoaDon = _newHoaDon.copyWith(Extra: value); // Update the MaKH value
                    },
                  ),

                  //Đơn vị tiền tệ
                  const SizedBox(height: 20,),
                  Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                          color: Colors.black,
                          width: 1
                      ),
                    ),
                    child: PopupMenuButton(
                      itemBuilder: (BuildContext context){
                        return<PopupMenuEntry>[
                          PopupMenuItem(
                              child: TextButton(
                                onPressed: (){
                                  setState(() {
                                    DonViTienTe = "AUD Australian dollar";
                                    _newHoaDon = _newHoaDon.copyWith(DonViTienTe: 	036);
                                  });
                                  print(_newHoaDon.DonViTienTe);
                                },
                                child: Text('AUD Australian dollar'),
                              )
                          ),
                          PopupMenuItem(
                              child: TextButton(
                                onPressed: (){
                                  setState(() {
                                    DonViTienTe = "CDA Dollar Canada";
                                    _newHoaDon = _newHoaDon.copyWith(DonViTienTe: 124);
                                  });
                                  print(_newHoaDon.DonViTienTe);
                                },
                                child: Text('CDA Dollar Canada'),
                              )
                          ),
                          PopupMenuItem(
                              child: TextButton(
                                onPressed: (){
                                  setState(() {
                                    DonViTienTe = "USD Dollar Mỹ";
                                    _newHoaDon = _newHoaDon.copyWith(DonViTienTe: 840);
                                  });
                                  print(_newHoaDon.DonViTienTe);
                                },
                                child: Text('USD Dollar Mỹ'),
                              )
                          ),
                          PopupMenuItem(
                              child: TextButton(
                                onPressed: (){
                                  setState(() {
                                    DonViTienTe = "EUR Euro";
                                    _newHoaDon = _newHoaDon.copyWith(DonViTienTe: 978);
                                  });
                                  print(_newHoaDon.DonViTienTe);
                                },
                                child: Text('EUR Euro'),
                              )
                          ),
                        ];
                      },
                      child:  Align(
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Expanded(
                                flex:3,
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(' \t ${DonViTienTe}'),
                                )
                            ),
                            const Expanded(
                                flex:1,
                                child: Icon(Icons.keyboard_arrow_down_sharp)
                            ),

                          ],
                        ),
                      ),
                      onSelected: ( DaChonHinhThucThanhToan){
                        if(DaChonHinhThucThanhToan == 0){
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Vui lòng chọn hình thức thanh toán'),
                              )
                          );
                        }
                      },
                    ),
                  ),

                  const SizedBox(height: 20,),

                  // -- Ty gia
                  TextFormField(
                    expands: false,
                    obscureText: false,                     //Khong an ky tu
                    initialValue: _newHoaDon.TyGia.toString(),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Tỷ giá:',
                      prefixIcon: Icon(Icons.account_circle),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2)
                      ),
                      filled: true,
                      fillColor: Colors.white,

                    ),
                    onSaved: (value) {
                      _newHoaDon = _newHoaDon.copyWith(TyGia: value as double); // Update the MaKH value
                    },
                  ),

                  // ----------- Phan nay chi doc khong cho phép sưa

                    //1. Tổng tiền quy đổi
                  const SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Tổng tiền quy đổi:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  ),
                  TextFormField(
                    expands: false,
                    obscureText: false,                     //Khong an ky tu
                    initialValue: 0.5.toString(),
                    readOnly: true,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.attach_money),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2)
                      ),
                      filled: true,
                      fillColor: Colors.white54,
                    ),
                  ),

                  //Giảm giá
                  const SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Giảm giá:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  ),
                  TextFormField(
                    expands: false,
                    obscureText: false,                     //Khong an ky tu
                    initialValue: 0.5.toString(),
                    readOnly: true,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.attach_money),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2)
                      ),
                      filled: true,
                      fillColor: Colors.white54,
                    ),
                  ),

                  //Tiền hàng truowcsc thuế
                  const SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Tiền hàng trước thế:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  ),
                  TextFormField(
                    expands: false,
                    obscureText: false,                     //Khong an ky tu
                    initialValue: 0.5.toString(),
                    readOnly: true,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.attach_money),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2)
                      ),
                      filled: true,
                      fillColor: Colors.white54,
                    ),
                  ),

                  //Tiền thuế GTGT 5%
                  const SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Tiền thuế GTGT (5%):', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  ),
                  TextFormField(
                    expands: false,
                    obscureText: false,                     //Khong an ky tu
                    initialValue: 0.5.toString(),
                    readOnly: true,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.attach_money),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2)
                      ),
                      filled: true,
                      fillColor: Colors.white54,
                    ),
                  ),

                  //Tiền thuế GTGT 10%
                  const SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Tiền thuế GTGT (10%):', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  ),
                  TextFormField(
                    expands: false,
                    obscureText: false,                     //Khong an ky tu
                    initialValue: 0.5.toString(),
                    readOnly: true,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.attach_money),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2)
                      ),
                      filled: true,
                      fillColor: Colors.white54,
                    ),
                  ),

                  //Tiền thuế GTGT (Khác):
                  const SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Tiền thuế GTGT (khác):', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  ),
                  TextFormField(
                    expands: false,
                    obscureText: false,                     //Khong an ky tu
                    initialValue: 0.5.toString(),
                    readOnly: true,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.attach_money),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2)
                      ),
                      filled: true,
                      fillColor: Colors.white54,
                    ),
                  ),

                  //Tổng tiền thuế GTGT:
                  const SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Tổng tiền thuế GTGT:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  ),
                  TextFormField(
                    expands: false,
                    obscureText: false,                     //Khong an ky tu
                    initialValue: 0.5.toString(),
                    readOnly: true,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.attach_money),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2)
                      ),
                      filled: true,
                      fillColor: Colors.white54,
                    ),
                  ),

                  //Tổng tiền sau thuế:
                  const SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Tổng tiền sau thuế:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  ),
                  TextFormField(
                    expands: false,
                    obscureText: false,                     //Khong an ky tu
                    initialValue: 0.5.toString(),
                    readOnly: true,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.attach_money),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2)
                      ),
                      filled: true,
                      fillColor: Colors.white54,
                    ),
                  ),

                  //Số tiền viết bằng chữ:
                  const SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Số tiền viết bằng chữ:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  ),
                  TextFormField(
                    expands: false,
                    obscureText: false,                     //Khong an ky tu
                    initialValue: 0.5.toString(),
                    readOnly: true,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.attach_money),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2)
                      ),
                      filled: true,
                      fillColor: Colors.white54,
                    ),
                  ),

                  //Nut luu
                  const SizedBox(height: 25,),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: TextButton(
                      onPressed: (){},
                      child: Text('Lưu dữ liệu', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),)
                    ),
                  ),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
          )
        ],),
      ),
    );
  }
}
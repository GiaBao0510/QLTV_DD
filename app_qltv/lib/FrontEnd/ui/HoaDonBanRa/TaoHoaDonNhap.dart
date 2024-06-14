import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_qltv/FrontEnd/model/HoaDonBanRa/ImportDraftInvoice_model.dart';
import 'package:app_qltv/FrontEnd/controller/HoaDonBanRa/ImportDraftInvoice_manage.dart';
import '../../constants/config.dart';

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
  Products_model SanPham = Products_model(
    code: '', ProdName: '',
    ProdUnit: '', ProdQuantity: 0.0,
    ProdPrice: 0.0, VATRate: 0.0,
    VATAmount: 0.0, Total: 0.0, Amount: 0.0,
    DiscountAmount: 0.0, Discount: 0.0,
    ProdAttr: 1, Remark: '',
  );

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

  //PP Thêm dòng
  void addRow(){
    SoThuTuHangSP++;
    setState(() {
      TheNumberOfProducts.add(DataRow(cells: [
        //STT
        DataCell(Text('${SoThuTuHangSP}')),

        //Mã sản phẩm
        DataCell(
          TextFormField(
            expands: false,
            obscureText: false,                     //Khong an ky tu
            initialValue: SanPham.code,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
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
                return 'Vui lòng nhập mã sản phẩm';
              }
              return null;
            },
            onSaved: (value) {
              SanPham = SanPham.copyWith(code: value); // Update the MaKH value
            },
          ),
        ),

        //Tên sản phẩm
        DataCell(
          TextFormField(
            expands: false,
            obscureText: false,                     //Khong an ky tu
            initialValue: SanPham.ProdName,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
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
                return 'Vui lòng nhập tên sản phẩm';
              }
              return null;
            },
            onSaved: (value) {
              SanPham = SanPham.copyWith(ProdName: value); // Update the MaKH value
            },
          ),
        ),

        //ĐVT
        DataCell(
          TextFormField(
            expands: false,
            obscureText: false,                     //Khong an ky tu
            initialValue: SanPham.ProdUnit,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
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
                return 'Vui lòng nhập đơn vị tính';
              }
              return null;
            },
            onSaved: (value) {
              SanPham = SanPham.copyWith(ProdUnit: value); // Update the MaKH value
            },
          ),
        ),

        //Số lượng
        DataCell(
          TextFormField(
            expands: false,
            obscureText: false,                     //Khong an ky tu
            initialValue: SanPham.ProdQuantity.toString(),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
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
                return 'Vui lòng nhập số lượng';
              }
              return null;
            },
            onSaved: (value) {
              SanPham = SanPham.copyWith(ProdQuantity: value as double); // Update the MaKH value
            },
          ),
        ),

        //Đơn giá sản phẩm
        DataCell(
          TextFormField(
            expands: false,
            obscureText: false,                     //Khong an ky tu
            initialValue: SanPham.ProdPrice.toString(),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
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
                return 'Vui lòng nhập đơn giá sản phẩm';
              }
              return null;
            },
            onSaved: (value) {
              SanPham = SanPham.copyWith(ProdPrice: value as double); // Update the MaKH value
            },
          ),
        ),

        //Thành tiền chưa trừ CK
        DataCell(
          TextFormField(
            expands: false,
            obscureText: false,                     //Khong an ky tu
            initialValue: SanPham.ProdPrice.toString(),
            readOnly: true,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.perm_identity_outlined),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2)
                ),
                filled: true,
                fillColor: Colors.white
            ),
          ),
        ),

        //Chiết khấu %
        DataCell(
          TextFormField(
            expands: false,
            obscureText: false,                     //Khong an ky tu
            initialValue: SanPham.Discount.toString(),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.perm_identity_outlined),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2)
                ),
                filled: true,
                fillColor: Colors.white
            ),
            onSaved: (value) {
              SanPham = SanPham.copyWith(Discount: value as double); // Update the MaKH value
            },
          ),
        ),

        //Tiền chiết khấu
        DataCell(
          TextFormField(
            expands: false,
            obscureText: false,                     //Khong an ky tu
            //Error
            //initialValue: (SanPham.ProdUnit * SanPham.Discount / 100.0).toString(),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.perm_identity_outlined),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2)
                ),
                filled: true,
                fillColor: Colors.white
            ),
            onSaved: (value) {
              SanPham = SanPham.copyWith(DiscountAmount: value as double); // Update the MaKH value
            },
          ),
        ),
      ]));
    });
  }

  //PP xóa dòng

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
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.orange, Colors.amber])),
        ),
      ),
      body: Scrollbar(
        child: ListView(children: [
          Container(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 20),
            decoration: BoxDecoration(
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
                  ProductTableInTheInvoice(context),
                  const SizedBox(height: 5,),
                  AddOrDeleteRows(context),

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

  //Bảng thêm sản phẩm trong hóa đơn
  Widget ProductTableInTheInvoice(BuildContext context){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: MaterialStateColor.resolveWith(
                (states) => Colors.black87),
        columns: const <DataColumn>[
          DataColumn(
              label: Text(
                'STT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
          ),
          DataColumn(
              label: Text(
                'Mã sản phẩm', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
          ),
          DataColumn(
              label: Text(
                'Tên hàng hóa, dịch vụ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
          ),
          DataColumn(
              label: Text(
                'ĐVT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
          ),
          DataColumn(
              label: Text(
                'Số lượng', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
          ),
          DataColumn(
              label: Text(
                'Đơn giá', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
          ),
          DataColumn(
              label: Text(
                'Thành tiền chưa trừ CK', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
          ),
          DataColumn(
              label: Text(
                'Chiết khấu (%)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
          ),
          DataColumn(
              label: Text(
                'Tiền chiết khấu', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
          ),
          DataColumn(
              label: Text(
                'Thành tiền trước thuế', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
          ),
          DataColumn(
              label: Text(
                'Thuế suất GTGT(%)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
          ),
          DataColumn(
              label: Text(
                'Thuế GTGT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
          ),
          DataColumn(
              label: Text(
                'Thành tiền sau thuế', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
          ),
          DataColumn(
              label: Text(
                'Tính chất', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
          ),
        ],
        rows: TheNumberOfProducts
      ),
    );
  }

  //Them hang hoac xoa hàng
  Widget AddOrDeleteRows(BuildContext context){
    return Row(children: [
      Expanded(
        flex: 1,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffffa8a8), Color(0xfffd8686)],
                stops: [0, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: TextButton(
              onPressed: (){},
              child: const ListTile(
                leading: Icon(Icons.delete, color: Colors.red,),
                title: Text('Xóa dòng chọn', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
              ),
            ),
          )
      ),
      const SizedBox(width: 5,),
      Expanded(
          flex: 1,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffa8aeff), Color(0xffa3a9ff)],
                stops: [0, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: TextButton(
              onPressed: (){},
              child: const ListTile(
                leading: Icon(Icons.add, color: Colors.blue,),
                title: Text('Thêm dòng mới', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),),
              ),
            ),
          )
      ),
    ],);
  }
}
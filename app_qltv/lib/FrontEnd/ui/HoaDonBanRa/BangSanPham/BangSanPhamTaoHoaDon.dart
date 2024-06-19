import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_qltv/FrontEnd/model/HoaDonBanRa/ImportDraftInvoice_model.dart';

class BangSanPhamTaoHoaDon extends StatefulWidget {
  final List<Products_model> DanhSachSanPham;

  const BangSanPhamTaoHoaDon({
    super.key,
    required this.DanhSachSanPham
  });
  @override
  State<BangSanPhamTaoHoaDon> createState() => _BangSanPhamTaoHoaDonState(DanhSachSanPham: DanhSachSanPham);
}

class _BangSanPhamTaoHoaDonState extends State<BangSanPhamTaoHoaDon> {
  // ---- Thuộc tính ----
  List<DataRow> DanhSachSanPham_Row = [];
  final List<Products_model> DanhSachSanPham;
  String tinhChat = "Hàng hóa/dịch vụ -product/service";
  String ThueSuatGTGT_Text = "0%";
  int SoThuTu = 0;
  int SoThuTuHang = 0;

  bool selectRow = false;

  _BangSanPhamTaoHoaDonState({required this.DanhSachSanPham});

  //Danh sach luu trữ các thông tin sản phẩm tạm thời
  List<EditControllerProduct> ctrlProduct = [];
  //Luu tru thong tin san pham tam
  EditControllerProduct TempInfotmation = EditControllerProduct();

  // -------- Hàm -------
//1. Danh sách cột
  List<DataColumn> productTableHeader(){
    return const <DataColumn>[
      DataColumn(
        label: Text(
          'STT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'Mã sản phẩm', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )
      ),
      DataColumn(
        label: Text(
          'Tên hàng hóa,\n dịch vụ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
          'Thành tiền \nchưa trừ CK', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
          'Thành tiền \ntrước thuế', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )
      ),
      DataColumn(
        label: Text(
          'Thuế suất \n\tGTGT(%)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )
      ),
      DataColumn(
        label: Text(
          'Thuế GTGT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )
      ),
      DataColumn(
        label: Text(
          'Thành tiền \n\tsau thuế', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )
      ),
      DataColumn(
        label: Text(
          'Tính chất', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )
      ),
    ];
  }

//2. Trả về danh sách hàng
  List<DataRow> ProductLines(){
    return DanhSachSanPham_Row;
  }

//3.Hàm khởi tạo
  @override
  void initState() {
    super.initState();
    DanhSachSanPham.add(addRow());
  }

//4.Hàm hủy
  @override
  void dispose() {
    ctrlProduct.map((e) => e.DiscardTheTemporarySave());
    super.dispose();
  }

//5.Giao diện
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ProductTableInTheInvoice(context),
      const SizedBox(height: 10,),
      AddOrDeleteRows( context),
    ],);
  }

//6.Đánh dấu hàng được chọn
  void _HighlightTheSelectedRow(bool? value){
    setState(() {
      selectRow = value ?? false;
    });
  }

//7.1 Tính thành tiền chưa trừ CK
  TextEditingController _TinhThanhTienChuTruCK(double DonGia, double SoLuongSP ){
    TextEditingController kq = TextEditingController();
    kq.text = (DonGia * SoLuongSP).toString();
    return kq;
  }

//7.2 Tính Tiền chiết khấu
  double _TinhTienChietKhau(double ThanhTienChuaTruCK, double ChietKhau ){
    return ThanhTienChuaTruCK * ChietKhau/100.0;
  }

//7.3 Tính Thành tiền trước thuế
  double _TinhThanhTienTruocThue(double ThanhTienChuaTruCK, double TienChietKhau ){
    return ThanhTienChuaTruCK - TienChietKhau;
  }

//7.4 Tính Thuế GTGT
  double _TinhThueGTGT(double ThanhTienTruocThue, double ThueSuatGTGT ){
    return ThanhTienTruocThue * ThueSuatGTGT;
  }

//7.5 Thành tiền sau thuế
  double _TinhThanhTienSauThue(double ThanhTienTruocThue, double ThueGTGT ){
    return ThanhTienTruocThue + ThueGTGT;
  }

//8. Phương thức tạo hàng
  Products_model addRow(){

    //Tao san pham
    Products_model SanPham = Products_model(
      code: '', ProdName: '', ProdUnit: '',
      ProdQuantity: 0.0, ProdPrice: 0.0,
      VATRate: 0.0, VATAmount: 0.0,
      Total: 0.0, Amount: 0.0,
      DiscountAmount: 0.0, Discount: 0.0,
      ProdAttr: 1, Remark: '',
    );
    SoThuTu++;      //So thu tu hang

    //Phan nay luu gia tri tinh toan
    double _donGia = 0.0, _thanhTienChuaTruCK = 0.0,
        _chietKhau =0.0, _tienChietKhau =0.0, _soLuongSP = 0.0,
        _ThanhTienTruocThue =0.0, _ThueSuatGTGT = 0.0,
        _ThueGTGT =0.0, _thanhTienSauThue = 0.0;

    setState(() {
      DanhSachSanPham_Row.add(DataRow(
        color:  MaterialStateColor.resolveWith((states) => Colors.white),
        selected: selectRow,
        onSelectChanged: _HighlightTheSelectedRow,
        cells: [
          //STT
          DataCell(Text('${SoThuTu}')),
          //Mã sản phẩm
          DataCell(
            TextField(
              keyboardType: TextInputType.text,
              obscureText: false,
              expands: false,
              controller: TempInfotmation.MaSP,
              onChanged: (value){
                setState(() {
                  SanPham = SanPham.copyWith(code: value);
                });
              },
            )
          ),

          //Tên sản phẩm
          DataCell(
            TextField(
              expands: false,
              obscureText: false,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              controller: TempInfotmation.TenSP,
              onChanged: (String value){
                setState(() {
                  SanPham = SanPham.copyWith(ProdName: value);
                });
              },
            ),
          ),

          //ĐVT
          DataCell(
            TextField(
              expands: false,
              obscureText: false,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              controller: TempInfotmation.DonViTinh,
              onChanged: (String value){
                SanPham = SanPham.copyWith(ProdUnit: value);
              },
            ),
          ),

          //Số lượng
          DataCell(
            TextField(
              expands: false,
              obscureText: false,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              controller: TempInfotmation.SoLuong,
              onChanged: (value){
                //Chuyển đổi về kiểu double
                final gtri = double.tryParse(value);
                if(gtri != null){
                  setState(() {
                    SanPham = SanPham.copyWith(ProdQuantity: gtri);
                    _soLuongSP = gtri;
                  });
                }
              },
            ),
          ),

          //Đơn giá sản phẩm
          DataCell(
            TextField(
              expands: false,
              obscureText: false,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              controller: TempInfotmation.DonGia,
              onChanged: (value){
                //Chuyển đổi về kiểu double
                final gtri = double.tryParse(value);
                if(gtri != null){
                  setState(() {
                    SanPham = SanPham.copyWith(ProdPrice: gtri);
                    _donGia = gtri;
                  });
                }
              },
            ),
          ),

          //Thành tiền chưa trừ CK
          DataCell(
            TextField(
              expands: false,
              obscureText: false,                     //Khong an ky tu
              // controller: TempInfotmation.ThanhTienChuaTruCK
              //     = _TinhThanhTienChuTruCK( TempInfotmation.DonGia.text as double, TempInfotmation.SoLuong.text as double),
              // onChanged: (value){
              //   setState(() {
              //     _thanhTienChuaTruCK = value as double;
              //   });
              // },
              readOnly: true,
              textInputAction: TextInputAction.next,
            ),
          ),

          //Chiết khấu %
          DataCell(
            TextField(
              expands: false,
              obscureText: false,                     //Khong an ky tu
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              controller: TextEditingController(text: "${SanPham.Discount}"),
              onChanged: (value){
                setState(() {
                  SanPham = SanPham.copyWith(Discount: value as double);
                  _chietKhau = value as double;
                });
              },
              onSubmitted: (value){
                setState(() {
                  SanPham = SanPham.copyWith(Discount: value as double);
                  _chietKhau = value as double;
                });
              },
            ),
          ),

          //Tiền chiết khấu
          DataCell(
            TextField(
              expands: false,
              obscureText: false,
              controller: TextEditingController(text: "${_TinhTienChietKhau(_thanhTienChuaTruCK, _chietKhau)}"),
              onChanged: (value){
                setState(() {
                  _tienChietKhau = _TinhTienChietKhau(_thanhTienChuaTruCK, _chietKhau);
                  SanPham = SanPham.copyWith(DiscountAmount: _tienChietKhau);
                });
              },
              onSubmitted: (value){
                setState(() {
                  _tienChietKhau = _TinhTienChietKhau(_thanhTienChuaTruCK, _chietKhau);
                  SanPham = SanPham.copyWith(DiscountAmount: _tienChietKhau);
                });
              },
              readOnly: true,
              textInputAction: TextInputAction.next,
            ),
          ),

          //Thành tiền trước thuế  -- chưa tìm thấy thuộc tính để lưu
          DataCell(
            TextField(
              expands: false,
              obscureText: false,
              controller: TextEditingController(text: "${_TinhThanhTienTruocThue(_thanhTienChuaTruCK, _tienChietKhau)}"),
              onChanged: (value){
                _ThanhTienTruocThue = _TinhThanhTienTruocThue(_thanhTienChuaTruCK, _tienChietKhau);
                SanPham = SanPham.copyWith(Total: _ThanhTienTruocThue);
              },
              onSubmitted: (value){
                _ThanhTienTruocThue = _TinhThanhTienTruocThue(_thanhTienChuaTruCK, _tienChietKhau);
                SanPham = SanPham.copyWith(Total: _ThanhTienTruocThue);
              },
              readOnly: true,
              textInputAction: TextInputAction.next,
            ),
          ),

          //Thuế suất GTGT(%)
          DataCell(
              Container(
                child: PopupMenuButton(
                  itemBuilder: (BuildContext context){
                    return<PopupMenuEntry>[
                      PopupMenuItem(
                          child: TextButton(
                            onPressed: (){
                              setState(() {
                                ThueSuatGTGT_Text = "0%";
                                _ThueSuatGTGT = 0.00;
                                SanPham = SanPham.copyWith(VATRate: 0.00);
                              });
                            },
                            child: const Text('0%'),
                          )
                      ),
                      PopupMenuItem(
                          child: TextButton(
                            onPressed: (){
                              setState(() {
                                ThueSuatGTGT_Text = "5%";
                                _ThueSuatGTGT = 0.05;
                                SanPham = SanPham.copyWith(VATRate: 0.05);
                              });
                            },
                            child: const Text('5%'),
                          )
                      ),
                      PopupMenuItem(
                          child: TextButton(
                            onPressed: (){
                              setState(() {
                                ThueSuatGTGT_Text = "8%";
                                _ThueSuatGTGT = 0.08;
                                SanPham = SanPham.copyWith(VATRate: 0.08);
                              });
                            },
                            child: const Text('8%'),
                          )
                      ),
                      PopupMenuItem(
                          child: TextButton(
                            onPressed: (){
                              setState(() {
                                ThueSuatGTGT_Text = "10%";
                                _ThueSuatGTGT = 0.10;
                                SanPham = SanPham.copyWith(VATRate: 0.1);
                              });
                            },
                            child: const Text('10%'),
                          )
                      ),
                      PopupMenuItem(
                          child: TextButton(
                            onPressed: (){
                              setState(() {
                                ThueSuatGTGT_Text = "Không chịu thuế GTGT";
                                _ThueSuatGTGT = 0.00;
                                SanPham = SanPham.copyWith(VATRate: 0.00);
                              });
                            },
                            child: const Text('Không chịu thuế GTGT'),
                          )
                      ),
                      PopupMenuItem(
                          child: TextButton(
                            onPressed: (){
                              setState(() {
                                ThueSuatGTGT_Text = "Không kê khai nộp thuế GTGT";
                                _ThueSuatGTGT = 0.00;
                                SanPham = SanPham.copyWith(VATRate: 0.00);
                              });
                            },
                            child: const Text('Không kê khai nộp thuế GTGT'),
                          )
                      ),
                      PopupMenuItem(
                          child: TextButton(
                            onPressed: (){
                              setState(() {
                                ThueSuatGTGT_Text = "5% x 70%";
                                _ThueSuatGTGT = 0.05 * 0.7;
                                SanPham = SanPham.copyWith(VATRate: 0.05*0.7);
                              });
                            },
                            child: const Text('5% x 70%'),
                          )
                      ),
                      PopupMenuItem(
                          child: TextButton(
                            onPressed: (){
                              setState(() {
                                ThueSuatGTGT_Text = "10% x 70%";
                                _ThueSuatGTGT = 0.1 * 0.7;
                                SanPham = SanPham.copyWith(VATRate: 0.1*0.7);
                              });
                            },
                            child: const Text('10% x 70%'),
                          )
                      ),
                      PopupMenuItem(
                          child: TextButton(
                            onPressed: (){
                              setState(() {
                                ThueSuatGTGT_Text = "Khác";
                                _ThueSuatGTGT = 0.00;
                                SanPham = SanPham.copyWith(VATRate: 0.0);
                              });
                            },
                            child: const Text('khác'),
                          )
                      ),
                    ];
                  },
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                          child: Text('${ThueSuatGTGT_Text}'),
                      ),
                      Expanded(
                          flex: 1,
                          child: Icon(Icons.arrow_drop_down)
                      ),
                    ],
                  ),
                ),
              )
          ),

          //Thuế GTGT
          DataCell(
            TextField(
              expands: false,
              obscureText: false,
              controller: TextEditingController(text: "${_TinhThueGTGT(_ThanhTienTruocThue, _ThueSuatGTGT)}"),
              onChanged: (value){
                _ThueGTGT = _TinhThueGTGT(_ThanhTienTruocThue, _ThueSuatGTGT);
                SanPham = SanPham.copyWith(DiscountAmount: _ThueGTGT);
              },
              onSubmitted: (value){
                _ThueGTGT = _TinhThueGTGT(_ThanhTienTruocThue, _ThueSuatGTGT);
                SanPham = SanPham.copyWith(DiscountAmount: _ThueGTGT);
              },
              readOnly: true,
              textInputAction: TextInputAction.next,
            ),
          ),

          //Thành tiền sau thuế
          DataCell(
            TextField(
              expands: false,
              obscureText: false,
              controller: TextEditingController(text: "${_TinhThanhTienSauThue(_ThanhTienTruocThue, _ThueGTGT)}"),
              onChanged: (value){
                _thanhTienSauThue = _TinhThanhTienSauThue(_ThanhTienTruocThue, _ThueGTGT);
                SanPham = SanPham.copyWith(Amount: _thanhTienSauThue);
              },
              readOnly: true,
              textInputAction: TextInputAction.next,
            ),
          ),

          //Tính chất
          DataCell(
              Container(
                child: PopupMenuButton(
                  itemBuilder: (BuildContext context){
                    return<PopupMenuEntry>[
                      PopupMenuItem(
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              tinhChat = "Hàng hóa/dịch vụ -product/service";
                              SanPham = SanPham.copyWith(ProdAttr: 1);
                            });
                            print("Da chọn tinh chat so: ${SanPham.ProdAttr}");
                          },
                          child: const Text('Hàng hóa/dịch vụ -\nproduct/service'),
                        )
                      ),
                      PopupMenuItem(
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              tinhChat = "Khuyến mãi -Promotions";
                              SanPham = SanPham.copyWith(ProdAttr: 2);
                            });
                            print("Da chọn tinh chat so: ${SanPham.ProdAttr}");
                          },
                          child: const Text('Khuyến mãi -\nPromotions '),
                        )
                      ),
                      PopupMenuItem(
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              tinhChat = "Chiết khấu -Discount";
                              SanPham = SanPham.copyWith(ProdAttr: 3);
                            });
                            print("Da chọn tinh chat so: ${SanPham.ProdAttr}");
                          },
                          child: const Text('Chiết khấu -\nDiscount'),
                        )
                      ),
                      PopupMenuItem(
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              tinhChat = "Ghi chú - Notes";
                              SanPham = SanPham.copyWith(ProdAttr: 4);
                            });
                            print("Da chọn tinh chat so: ${SanPham.ProdAttr}");
                          },
                          child: const Text('Ghi chú -\n Notes'),
                        )
                      ),
                    ];
                  },
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text('${tinhChat}'),
                      ),
                      Expanded(
                          flex: 1,
                          child: Icon(Icons.arrow_drop_down)
                      ),
                    ],
                  ),
                ),
              )
          ),
      ]
      ));
    });
    //Tra ve SP sau khi dien thong tin
    return SanPham;
  }

  // --- Tiện ích ----
//1.Bảng thêm sản phẩm trong hóa đơn
  Widget ProductTableInTheInvoice(BuildContext context){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        showCheckboxColumn: true,
        border: TableBorder.all(
          width: 1,
          color: Colors.black26
        ),
        headingRowColor: MaterialStateColor.resolveWith(
                (states) => Colors.black87),
        columns: productTableHeader(),
        rows: ProductLines().toList(),
      ),
    );
  }

//2.Them hang hoac xoa hàng
  Widget AddOrDeleteRows(BuildContext context){
    return Row(children: [
      Expanded(
        flex: 1,
        child:Container(
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
            onPressed: (){
              setState(() {
                DanhSachSanPham_Row.removeWhere((e) => e.selected);
              });
            },
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
            onPressed: (){
              Products_model row = DanhSachSanPham[SoThuTuHang];
              print('\t--- So luong: ${DanhSachSanPham.length} ---\t');
              print("Ma sản phẩm: ${TempInfotmation.MaSP.text}");
              print("ten sản phẩm: ${row.ProdName}");
              print("DVT: ${row.ProdUnit}");
              print("Đơn giá: ${row.ProdPrice}");
              print("Số lượng: ${row.ProdQuantity}");
              print("Chiết khấu (%): ${row.Discount}");
              print("Tiền chiết khấu: ${row.DiscountAmount}");
              print("Thành tiền trước thuế: ${row.Total}");
              print("Thuế suất GTGT(%): ${row.VATRate}");
              print("Thuế GTGT: ${row.DiscountAmount}");
              print("Thành tiền sau thuế: ${row.Amount}");
              print("Tính chất: ${row.ProdAttr}");


              //Them sau khi kiem tra hang trước có điền thông tin
              DanhSachSanPham.add(addRow());
              TempInfotmation.CleanTemporaryInformation();
              SoThuTuHang++;
            },
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
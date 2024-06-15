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
  String ThueSuatGTGT = "0%";
  int SoThuTu = 0;
  bool selectRow = false;

  _BangSanPhamTaoHoaDonState({required this.DanhSachSanPham});

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
    addRow();
  }

//4.Hàm hủy
  @override
  void dispose() {
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

//7. Phương thức tạo hàng
  //PP Thêm dòng
  void addRow(){
    //Tao san pham
    Products_model SanPham = Products_model(
      code: '', ProdName: '',
      ProdUnit: '', ProdQuantity: 0.0,
      ProdPrice: 0.0, VATRate: 0.0,
      VATAmount: 0.0, Total: 0.0, Amount: 0.0,
      DiscountAmount: 0.0, Discount: 0.0,
      ProdAttr: 1, Remark: '',
    );
    SoThuTu++;

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
            TextFormField(
              expands: false,
              obscureText: false,                     //Khong an ky tu
              initialValue: SanPham.code,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
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
              onSaved: (value) {
                SanPham = SanPham.copyWith(Discount: value as double); // Update the MaKH value
              },
            ),
          ),

          //Tiền chiết khấu
          DataCell(
            TextFormField(
              expands: false,
              obscureText: false,
              initialValue: (
                  (double.tryParse(SanPham.ProdUnit.toString()) ?? 0.0) *
                      (double.tryParse(SanPham.Discount.toString()) ?? 0.0 ) / 100.0
              ).toString(),
              readOnly: true,
              textInputAction: TextInputAction.next,
              onSaved: (value) {
                SanPham = SanPham.copyWith(DiscountAmount: value as double); // Update the MaKH value
              },
            ),
          ),

          //Thành tiền trước thuế  -- chưa tìm thấy thuộc tính để lưu
          DataCell(
            TextFormField(
              expands: false,
              obscureText: false,
              initialValue: (
                  (double.tryParse(SanPham.ProdPrice.toString()) ?? 0.0) -
                      (double.tryParse(SanPham.DiscountAmount.toString()) ?? 0.0)
              ).toString(),
              readOnly: true,
              textInputAction: TextInputAction.next,
              onSaved: (value) {
                SanPham = SanPham.copyWith(Total: value as double); // Update the MaKH value
              },
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
                                ThueSuatGTGT = "0%";
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
                                ThueSuatGTGT = "5%";
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
                                ThueSuatGTGT = "8%";
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
                                ThueSuatGTGT = "10%";
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
                                ThueSuatGTGT = "Không chịu thuế GTGT";
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
                                ThueSuatGTGT = "Không kê khai nộp thuế GTGT";
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
                                ThueSuatGTGT = "5% x 70%";
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
                                ThueSuatGTGT = "10% x 70%";
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
                                ThueSuatGTGT = "Khác";
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
                          child: Text('${ThueSuatGTGT}'),
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
            TextFormField(
              expands: false,
              obscureText: false,
              initialValue: (
                  (
                      (double.tryParse(SanPham.ProdUnit.toString()) ?? 0.0) -
                          ((double.tryParse(SanPham.ProdUnit.toString()) ?? 0.0) *
                              (double.tryParse(SanPham.Discount.toString()) ?? 0.0 ) / 100.0 )
                  ) * (double.tryParse(SanPham.Discount.toString()) ?? 0.0 ) / 100.0
              ).toString(),
              readOnly: true,
              textInputAction: TextInputAction.next,
              onSaved: (value) {
                SanPham = SanPham.copyWith(DiscountAmount: value as double); // Update the MaKH value
              },
            ),
          ),

          //Thành tiền sau thuế
          DataCell(
            TextFormField(
              expands: false,
              obscureText: false,
              initialValue: (
                  (
                      (double.tryParse(SanPham.ProdUnit.toString()) ?? 0.0) -
                          (
                              (double.tryParse(SanPham.ProdUnit.toString()) ?? 0.0) -
                                  (
                                      (double.tryParse(SanPham.ProdUnit.toString()) ?? 0.0) *
                                          (double.tryParse(SanPham.Discount.toString()) ?? 0.0 ) / 100.0
                                  )
                          ) * (double.tryParse(SanPham.Discount.toString()) ?? 0.0 ) / 100.0
                  )
              ).toString(),
              readOnly: true,
              textInputAction: TextInputAction.next,
              onSaved: (value) {
                SanPham = SanPham.copyWith(Amount: value as double); // Update the MaKH value
              },
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
                addRow();
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
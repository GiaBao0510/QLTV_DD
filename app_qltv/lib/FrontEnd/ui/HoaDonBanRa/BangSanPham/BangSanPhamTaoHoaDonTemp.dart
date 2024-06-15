import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_qltv/FrontEnd/model/HoaDonBanRa/ImportDraftInvoice_model.dart';

    // --- Thuộc tính ---
List<DataRow> TheNumberOfProducts = [];

int SoThuTuHangSP = 0;
//San pham dau vao
Products_model SanPham = Products_model(
  code: '', ProdName: '',
  ProdUnit: '', ProdQuantity: 0.0,
  ProdPrice: 0.0, VATRate: 0.0,
  VATAmount: 0.0, Total: 0.0, Amount: 0.0,
  DiscountAmount: 0.0, Discount: 0.0,
  ProdAttr: 1, Remark: '',
);
final GlobalKey<_ProductTableCreatesInvoiceState> _ProductTableCreatesInvoice_Key = GlobalKey<_ProductTableCreatesInvoiceState>();

  // --- Hàm ---

//1. Danh sách cột
List<DataColumn> productTableHeader(){
  return const <DataColumn>[
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

//2. Danh sách hàng
List<DataRow> ProductLines(){
  print('Số hang:${TheNumberOfProducts.first.cells.length}');
  return TheNumberOfProducts;
}

  // --- Tiện ích ---
//Bảng thêm sản phẩm trong hóa đơn
Widget ProductTableInTheInvoice(BuildContext context){
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: DataTable(
        headingRowColor: MaterialStateColor.resolveWith(
                (states) => Colors.black87),
        columns: productTableHeader(),
        rows: ProductLines(),
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
            onPressed: (){
              print('Thêm dòng mới - ${SoThuTuHangSP}');
              _ProductTableCreatesInvoice_Key.currentState?.addRow();
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


  //Lớp tạo bảng
class ProductTableCreatesInvoice extends StatefulWidget {

  const ProductTableCreatesInvoice({super.key});

  @override
  State<ProductTableCreatesInvoice> createState() => _ProductTableCreatesInvoiceState();
}

class _ProductTableCreatesInvoiceState extends State<ProductTableCreatesInvoice> {

  @override
  void initState() {
    super.initState();
  }

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
            obscureText: false,
            initialValue: (
                (double.tryParse(SanPham.ProdUnit.toString()) ?? 0.0) *
                    (double.tryParse(SanPham.Discount.toString()) ?? 0.0 ) / 100.0
            ).toString(),
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
                              SanPham = SanPham.copyWith(VATRate: 0.0);
                            });
                          },
                          child: const Text('khác'),
                        )
                    ),
                  ];
                },
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
                              SanPham = SanPham.copyWith(ProdAttr: 1);
                            });
                          },
                          child: const Text('Hàng hóa/dịch vụ \n-\nproduct/service'),
                        )
                    ),
                    PopupMenuItem(
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              SanPham = SanPham.copyWith(ProdAttr: 2);
                            });
                          },
                          child: const Text('Khuyến mãi \n-\nPromotions '),
                        )
                    ),
                    PopupMenuItem(
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              SanPham = SanPham.copyWith(ProdAttr: 3);
                            });
                          },
                          child: const Text('Chiết khấu \n-\nDiscount'),
                        )
                    ),
                    PopupMenuItem(
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              SanPham = SanPham.copyWith(ProdAttr: 4);
                            });
                          },
                          child: const Text('Ghi chú - Notes'),
                        )
                    ),
                  ];
                },
              ),
            )
        ),

      ]));
    });
  }
  @override
  Widget build(BuildContext context) {
    return ProductTableCreatesInvoice(key: _ProductTableCreatesInvoice_Key,);
  }
}
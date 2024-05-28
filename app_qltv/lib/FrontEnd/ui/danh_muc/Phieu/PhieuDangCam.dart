import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:app_qltv/FrontEnd/Service/ThuVien.dart';
import 'package:app_qltv/FrontEnd/Service/export/PDF/PhieuDangCam_PDF.dart';

class PhieuDangCam extends StatefulWidget{
  static const routeName ='phieudangcam';

  const PhieuDangCam({super.key});
  State<PhieuDangCam> createState() => _PhieuDangCam();
}

class _PhieuDangCam extends State<PhieuDangCam>{
  late List<dynamic> data;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // ------------ Phương thức ----------------
  Future<List<dynamic>> PhieuDangCam_list() async{
     String path = url+'/api/cam/dangcam';
     var res = await http.get(Uri.parse(path),headers: {"Content-Type": "application/json"} );
      List<dynamic> list = jsonDecode(res.body);
      return list;
  }

  //Giao diện
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar:AppBar(
            iconTheme: IconThemeData(
              color: Colors.white,
              size: 28,
            ),
            title: Row(
              children: [
                Expanded(
                  flex: 2,
                    child: Text('Phiếu đang cầm', style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Align', fontWeight: FontWeight.bold), ),
                ),
                Expanded(
                    flex: 1,
                    child: TextButton(
                        onPressed: (){
                          print('Chuyển sang phần chuyển đổi PDF');
                          printDoc(data);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(2, 5, 2, 5),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xffededed), Color(0xffdee8e8)],
                              stops: [0.25, 0.75],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                  offset: Offset(4,8)
                              )
                            ],
                          ),
                          child: Center(
                              child: Text('Export PDF', style: TextStyle(fontSize: 12), textAlign: TextAlign.center,)
                          ),
                        )
                    ),
                ),
              ],
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft, end: Alignment.bottomRight,
                      colors: [ Colors.orange, Colors.amber ]
                  )
              ),
            ),
          ),
          body: FutureBuilder<List<dynamic>>(
            future: PhieuDangCam_list(),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              else if(snapshot.hasError){
                return Center(child: Text('Error: ${snapshot.error}'),);
              }else{
                data = snapshot.data!;
                return Scrollbar(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xffededed), Color(0xffdee8e8)],
                          stops: [0.25, 0.75],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      ),
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index){
                          final item = data[index];

                          return Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
                            child:  Container(
                              margin: EdgeInsets.fromLTRB(0, 18, 0, 0),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black54,
                                    blurRadius: 8,
                                    offset: Offset(-2,5)
                                  )
                                ],
                                gradient: LinearGradient(
                                  colors: [Color(0xffebebeb), Color(0xffbec0cb)],
                                  stops: [0.25, 0.75],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                              ),
                              child: Column(
                                children: [
                                  Row(children: [
                                    Expanded(
                                      flex: 2,
                                        child: Row(children: [
                                          Text('Mã phiếu: ', style: TextStyle(fontWeight: FontWeight.bold),),
                                          Text('${item['PHIEU_MA']}'),
                                        ],)
                                    ),
                                    Expanded(
                                      flex: 1,
                                        child: IconButton(
                                          onPressed: (){
                                            ThongTinChiTiet(context,item);
                                          },
                                          icon: Icon(Icons.info_outline, size: 35,),
                                        ),
                                    )
                                  ],),
                                  SizedBox(height: 5,),
                                  Row(children: [
                                    Text('Tên khách hàng: ', style: TextStyle(fontWeight: FontWeight.bold),),
                                    Text('${item['KH_TEN']}'),
                                  ],),
                                  SizedBox(height: 5,),
                                  Row(children: [
                                    Expanded(
                                      child: Text('Ngày cầm: \n${item['NGAY_CAM']}'),
                                    ),
                                    Expanded(
                                      child: Text('Ngày quá hạn: \n${item['NGAY_QUA_HAN']}'),
                                    ),
                                  ],),
                                  SizedBox(height: 5,),
                                  Row(children: [
                                    Expanded(
                                      child: Text('Cân tổng: \n${DinhDangDonViTien_VND(item['CAN_TONG'])}'),
                                    ),
                                    Expanded(
                                      child: Text('TL hột: \n${DinhDangDonViTien_VND(item['TL_HOT'])}'),
                                    ),
                                  ],),
                                  SizedBox(height: 5,),
                                  Row(children: [
                                    Expanded(
                                      child: Text('TL thực: \n${DinhDangDonViTien_VND(item['TL_THUC'])}'),
                                    ),
                                    Expanded(
                                      child: Text('Định giá: \n${DinhDangDonViTien_VND(item['DINHGIA'])}'),
                                    ),
                                  ],),
                                  SizedBox(height: 5,),
                                  Row(children: [
                                    Expanded(
                                      child: Text('Tiền khách nhận: \n${DinhDangDonViTien_VND(item['TIEN_KHACH_NHAN'])}'),
                                    ),
                                    Expanded(
                                      child: Text('Tiền khách nhận thêm: \n${DinhDangDonViTien_VND(item['TIEN_THEM'])}'),
                                    ),
                                  ],),
                                  SizedBox(height: 5,),
                                  Row(children: [
                                    Expanded(
                                      child: Text('Tiền cầm mới: \n${DinhDangDonViTien_VND(item['TIEN_CAM_MOI'])}'),
                                    ),
                                    Expanded(
                                      child: Text('Lãi: \n${item['LAI_XUAT']}%')
                                    ),
                                  ],),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                  )
                );
              }
            },
          ),
        ),
    );
  }

  //Thông tin chi tết
  Future<void> ThongTinChiTiet(BuildContext context, Map<String,dynamic> item){
    return showDialog<void>(
        context: context,
        builder: (BuildContext context){
          return  AlertDialog(
            title: Container(
                child: Text('Thông tin chi tiết',style: TextStyle(decoration: TextDecoration.underline),),
            ),
            content:  FractionallySizedBox(
              child: Scrollbar(
                child:  ListView(
                  children: [
                    Column(
                      children: [

                        //Text('${item['LAI_XUAT']}'),
                        Text('Thông tin khách hàng', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,fontStyle: FontStyle.italic ),),
                        SizedBox(height: 15,),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(children: [
                            Text.rich(
                                TextSpan(
                                    children: [
                                      TextSpan(text: 'Khách hàng: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                      TextSpan(text: ' ${item['KH_TEN']}')
                                    ]
                                )
                            ),
                            Text.rich(
                                TextSpan(
                                    children: [
                                      TextSpan(text: 'Số điện thoại: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                      TextSpan(text: ' ${item['DIEN_THOAI'] ?? 'null'}')
                                    ]
                                )
                            ),
                            Text.rich(
                                TextSpan(
                                    children: [
                                      TextSpan(text: 'Địa chỉ: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                      TextSpan(text: ' ${item['DIA_CHI']?? 'null'}')
                                    ]
                                )
                            ),
                          ],),
                        ),

                        SizedBox(height: 20,),
                        Text('Thông tin phiếu cầm', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,fontStyle: FontStyle.italic ),),
                        SizedBox(height: 15,),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(children: [
                            Text.rich(
                                TextSpan(
                                    children: [
                                      TextSpan(text: 'Số phiếu: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                      TextSpan(text: ' ${item['PHIEU_MA']?? 'null'}')
                                    ]
                                )
                            ),
                            Text.rich(
                              TextSpan(
                                  children: [
                                    TextSpan(text: 'Lãi suất/Tháng: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: ' ${item['LAI_XUAT']?? 'null'}%')
                                  ]
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                  children: [
                                    TextSpan(text: 'Định giá: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: ' ${DinhDangDonViTien_VND(item['DINHGIA'])}')
                                  ]
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                  children: [
                                    TextSpan(text: 'Ngày cầm: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: ' ${item['NGAY_CAM']?? 'null'}')
                                  ]
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                  children: [
                                    TextSpan(text: 'Ngày hết hạn: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: ' ${item['NGAY_QUA_HAN']?? 'null'}')
                                  ]
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                  children: [
                                    TextSpan(text: 'Số ngày tính được: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: ' ${item['SO_NGAY_TINH_DUOC']?? 'null'}')
                                  ]
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                  children: [
                                    TextSpan(text: 'Số ngày hết hạn: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: ' ${item['SO_NGAY_HET_HAN']?? 'null'}')
                                  ]
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                  children: [
                                    TextSpan(text: 'Tiền cầm: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: ' ${DinhDangDonViTien_VND(item['TIEN_KHACH_NHAN'])}')
                                  ]
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                  children: [
                                    TextSpan(text: 'Tiền thêm: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: ' ${DinhDangDonViTien_VND(item['TIEN_THEM'])}')
                                  ]
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                  children: [
                                    TextSpan(text: 'Tiền cầm mới: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: ' ${DinhDangDonViTien_VND(item['TIEN_CAM_MOI'])}')
                                  ]
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                  children: [
                                    TextSpan(text: 'Mất phiếu: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: ' ${item['MAT_PHIEU']?? 'null'}')
                                  ]
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                  children: [
                                    TextSpan(text: ' Lý do mất phiếu: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: ' ${item['LY_DO_MAT_PHIEU']?? 'null'}')
                                  ]
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                  children: [
                                    TextSpan(text: 'Ghi chú: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: ' ${item['GHI_CHU']?? 'null'}')
                                  ]
                              ),
                            ),

                          ],),
                        ),


                      ],
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed:() => Navigator.of(context).pop(),
                  child: Text('Đóng', style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
              )
            ],
          );
        }
    );
  }

  //Nút in tài liệu
  Future<void> printDoc( List<dynamic> data ) async{
    final doc = pw.Document();
    doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context){
        return buildPrintableData(data);
      }
    ));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save()
    );
  }
}
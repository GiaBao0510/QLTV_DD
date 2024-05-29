import 'package:flutter/material.dart';
import '../../../Service/ThuVien.dart';

ThongTinChiTiet(BuildContext context, Map<String,dynamic> item){
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
                      Text('Thông tin khách hàng', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,fontStyle: FontStyle.italic , color: Colors.amber[700]),),
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
                      Text('Thông tin phiếu cầm', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,fontStyle: FontStyle.italic , color: Colors.amber[700]),),
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

                      SizedBox(height: 20,),
                      Text('Thông tin hàng', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,fontStyle: FontStyle.italic, color: Colors.amber[700] ),),
                      SizedBox(height: 15,),

                      Align(
                          alignment: Alignment.centerLeft,
                          child: Column(children: [
                            Text.rich(
                              TextSpan(
                                  children: [
                                    TextSpan(text: 'Tên hàng: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: ' ${item['TEN_HANG_HOA']?? 'null'}')
                                  ]
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                  children: [
                                    TextSpan(text: 'Loại vàng: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: ' ${item['LOAI_VANG']?? 'null'}')
                                  ]
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                  children: [
                                    TextSpan(text: 'Cân tổng: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: ' ${DinhDangDonViTien_VND(item['CAN_TONG'])}')
                                  ]
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                  children: [
                                    TextSpan(text: 'TL hột: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: ' ${DinhDangDonViTien_VND(item['TL_HOT'])}')
                                  ]
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                  children: [
                                    TextSpan(text: 'TL thực: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: ' ${DinhDangDonViTien_VND(item['TL_THUC'])}')
                                  ]
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                  children: [
                                    TextSpan(text: 'Đơn giá: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: ' ${DinhDangDonViTien_VND(item['DON_GIA'])}')
                                  ]
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                  children: [
                                    TextSpan(text: 'Thành tiền: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: ' ${DinhDangDonViTien_VND(item['THANH_TIEN'])}')
                                  ]
                              ),
                            ),
                          ])

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
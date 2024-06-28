import 'package:app_qltv/FrontEnd/controller/HoaDonBanRa/HoaDonMBManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/loaivang.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/nhomvang.dart';
import 'package:app_qltv/FrontEnd/controller/danhmuc/nhomvang_manager.dart';
import 'package:app_qltv/FrontEnd/controller/danhmuc/loaivang_manager.dart';

class ChiTietHoaDonMatBaoScreen extends StatelessWidget {
  static const routeName = "/chitiethanghoa";

  final HoaDonMatBao hoaDonMatBao;

  const ChiTietHoaDonMatBaoScreen({
    Key? key,
    required this.hoaDonMatBao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: Text(
              hoaDonMatBao.no.toString(),
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w900),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 20),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDetailRow('Trạng thái','${hoaDonMatBao.trangThaiHD}'),
                  buildDetailRow('Mẫu số - ký hiệu', '${hoaDonMatBao.pattern+hoaDonMatBao.serial}'),
                  buildDetailRow('Số hóa đơn', '${hoaDonMatBao.no}'),
                  buildDetailRow('Ngày lập', '${hoaDonMatBao.arisingDate}'),
                  buildDetailRow('Mã tham chiếu', '${hoaDonMatBao.so}'),
                  buildDetailRow('Mã khách hàng', '${hoaDonMatBao.cusCode}'),
                  buildDetailRow('Tên khách hàng', '${hoaDonMatBao.cusName}'),
                  buildDetailRow('Mã số thuế', '${hoaDonMatBao.cusTaxCode}'),
                  buildDetailRow('Giá trị', '${hoaDonMatBao.amount}'),
                  buildDetailRow('Loại hóa đơn', '${hoaDonMatBao.loaiHoaDon}'),
                  buildDetailRow('Mã thông điệp', '${hoaDonMatBao.maThongDiep}'),
                  buildDetailRow('Mã cơ quan thuế', '${hoaDonMatBao.mccqt}'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '$label ',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 20,),
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const Divider(
            color: Color.fromARGB(255, 200, 200, 200),
            height: 8,
            thickness: 2,
          ),
        ],
      ),
    );
  }


}

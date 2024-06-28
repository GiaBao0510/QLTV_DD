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
      // body: SafeArea(
      //   child: SingleChildScrollView(
      //     padding: EdgeInsets.only(top: 20),
      //     child: Container(
      //       margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      //       decoration: BoxDecoration(
      //         color: Colors.white,
      //         borderRadius: BorderRadius.circular(15.0),
      //       ),
      //       child: Padding(
      //         padding: const EdgeInsets.all(16.0),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             buildDetailRow(
      //                 'Mã Hàng:', '${int.parse(hangHoa.hangHoaMa!)}'),
      //             //Divider(color: Colors.amber,),
      //             buildDetailRow('Tên Hàng Hóa:', '${hangHoa.hangHoaTen}'),
      //             FutureBuilder<LoaiVang>(
      //               future: _getLoaiVangById(hangHoa.nhomHangId),
      //               builder: (context, snapshot) {
      //                 if (snapshot.connectionState == ConnectionState.waiting) {
      //                   return buildDetailRow('Loại Vàng:',
      //                       'Loading...'); // Hiển thị tiến trình đang tải
      //                 } else if (snapshot.hasError) {
      //                   return buildDetailRow('Loại Vàng:',
      //                       'Unknown'); // Hiển thị thông báo lỗi nếu có lỗi xảy ra
      //                 } else {
      //                   LoaiVang? loaiVang = snapshot.data;
      //                   return buildDetailRow(
      //                       'Loại Vàng:', '${loaiVang?.nhomTen ?? "Unknown"}');
      //                 }
      //               },
      //             ),
      //             FutureBuilder<NhomVang>(
      //               future: _getNhomVangById(hangHoa.loaiId),
      //               builder: (context, snapshot) {
      //                 if (snapshot.connectionState == ConnectionState.waiting) {
      //                   return buildDetailRow('Nhóm:',
      //                       'Loading...'); // Hiển thị tiến trình đang tải
      //                 } else if (snapshot.hasError) {
      //                   return buildDetailRow('Nhóm:',
      //                       'Unknownnnnn'); // Hiển thị thông báo lỗi nếu có lỗi xảy ra
      //                 } else {
      //                   NhomVang? nhomVang = snapshot.data;
      //                   return buildDetailRow(
      //                       'Nhóm:', '${nhomVang?.loaiTen ?? "Unknown"}');
      //                 }
      //               },
      //             ),
      //             buildDetailRow('Cân Tổng:', '${hangHoa.canTong}'),
      //             buildDetailRow('TL Hột:', '${hangHoa.tlHot}'),
      //             buildDetailRow('Trừ Hột:', '$truHot'),
      //             buildDetailRow(
      //                 'Công Gốc:', formatCurrency(hangHoa.congGoc ?? 0.0)),
      //             buildDetailRow(
      //                 'Giá Công:', formatCurrency(hangHoa.giaCong ?? 0.0)),
      //             buildDetailRow(
      //                 'Đơn Giá Gốc:', formatCurrency(hangHoa.donGiaGoc ?? 0.0)),
      //             buildDetailRow('Ghi Chú:', '${hangHoa.ghiChu}'),
      //             buildDetailRow('Xuất Xứ:', '${hangHoa.xuatXu}'),
      //             buildDetailRow('Ký Hiệu:', '${hangHoa.kyHieu}'),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
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

  Future<LoaiVang> _getLoaiVangById(String? loaiId) async {
    try {
      final loaiVangManager = LoaiVangManager();
      return await loaiVangManager.getLoaiVangById(int.parse(loaiId!)) ??
          LoaiVang(nhomTen: "Unknown");
    } catch (error) {
      print('Error fetching LoaiVang by id: $error');
      throw Exception('Failed to fetch LoaiVang by id');
    }
  }

  Future<NhomVang> _getNhomVangById(String? nhomHangId) async {
    try {
      final nhomVangManager = NhomVangManager();
      return await nhomVangManager.getNhomVangById(int.parse(nhomHangId!));
    } catch (error) {
      print('Error fetching NhomVang by id: $error');
      throw Exception('Failed to fetch NhomVang by id');
    }
  }

  // Hàm định dạng tiền tệ
  String formatCurrency(double amount) {
    final NumberFormat formatter = NumberFormat('#,##0', 'vi_VN');
    return formatter.format(amount);
  }
}

// import 'package:flutter/material.dart';
// import 'package:app_qltv/FrontEnd/model/danhmuc/hanghoa.dart';
// import 'package:app_qltv/FrontEnd/model/danhmuc/loaivang.dart';
// import 'package:app_qltv/FrontEnd/model/danhmuc/nhomvang.dart';

// class ChiTietHangHoaScreen extends StatelessWidget {
//   static const routeName = "/chitiethanghoa";

//   final HangHoa hangHoa;
//   final List<LoaiVang> loaiVangList;
//   final List<NhomVang> nhomVangList;

//   const ChiTietHangHoaScreen({
//     Key? key,
//     required this.hangHoa,
//     required this.loaiVangList,
//     required this.nhomVangList,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final double truHot = (hangHoa.canTong ?? 0) - (hangHoa.tlHot ?? 0);

//     // Tìm thông tin loại và nhóm vang từ danh sách
//     LoaiVang? loaiVang = loaiVangList.firstWhere(
//       (element) => element.nhomHangMa == hangHoa.loaiId,
//       orElse: () => LoaiVang(nhomTen: "Unknown"),
//     );
//     NhomVang? nhomVang = nhomVangList.firstWhere(
//       (element) => element.loaiId == hangHoa.nhomHangId,
//       orElse: () => NhomVang(loaiTen: "Unknown"),
//     );

//     return Scaffold(
//       appBar: AppBar(
//         leading: const BackButton(color: Colors.black),
//         title: Text(hangHoa.hangHoaTen ?? ''),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               buildDetailRow('Mã Hàng:', '${hangHoa.hangHoaMa}'),
//               buildDetailRow('Tên Hàng Hóa:', '${hangHoa.hangHoaTen}'),
//               buildDetailRow('Loại Vàng:', '${loaiVang?.nhomTen ?? "Unknown"}'),
//               buildDetailRow('Nhóm:', '${nhomVang?.loaiTen ?? "Unknown"}'),
//               buildDetailRow('Cân Tổng:', '${hangHoa.canTong}'),
//               buildDetailRow('TL Hột:', '${hangHoa.tlHot}'),
//               buildDetailRow('Trừ Hột:', '$truHot'),
//               buildDetailRow('Công Gốc:', '${hangHoa.congGoc}'),
//               buildDetailRow('Giá Công:', '${hangHoa.giaCong}'),
//               buildDetailRow('Đơn Giá Gốc:', '${hangHoa.donGiaGoc}'),
//               buildDetailRow('Ghi Chú:', '${hangHoa.ghiChu}'),
//               buildDetailRow('Xuất Xứ:', '${hangHoa.xuatXu}'),
//               buildDetailRow('Ký Hiệu:', '${hangHoa.kyHieu}'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             '$label ',
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: const TextStyle(fontSize: 16),
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/hanghoa.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/loaivang.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/nhomvang.dart';
import 'package:app_qltv/FrontEnd/controller/danhmuc/nhomvang_manager.dart';
import 'package:app_qltv/FrontEnd/controller/danhmuc/loaivang_manager.dart';

class ChiTietHangHoaScreen extends StatelessWidget {
  static const routeName = "/chitiethanghoa";

  final HangHoa hangHoa;
  final List<LoaiVang> loaiVangList;
  final List<NhomVang> nhomVangList;

  const ChiTietHangHoaScreen({
    Key? key,
    required this.hangHoa,
    required this.loaiVangList,
    required this.nhomVangList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double truHot = (hangHoa.canTong ?? 0) - (hangHoa.tlHot ?? 0);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(hangHoa.hangHoaTen ?? ''),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDetailRow('Mã Hàng:', '${hangHoa.hangHoaMa}'),
              buildDetailRow('Tên Hàng Hóa:', '${hangHoa.hangHoaTen}'),
              FutureBuilder<LoaiVang>(
                future: _getLoaiVangById(hangHoa.nhomHangId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return buildDetailRow('Loại Vàng:', 'Loading...'); // Hiển thị tiến trình đang tải
                  } else if (snapshot.hasError) {
                    return buildDetailRow('Loại Vàng:', 'Unknown'); // Hiển thị thông báo lỗi nếu có lỗi xảy ra
                  } else {
                    LoaiVang? loaiVang = snapshot.data;
                    return buildDetailRow('Loại Vàng:', '${loaiVang?.nhomTen ?? "Unknown"}');
                  }
                },
              ),
              FutureBuilder<NhomVang>(
                future: _getNhomVangById(hangHoa.loaiId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return buildDetailRow('Nhóm:', 'Loading...'); // Hiển thị tiến trình đang tải
                  } else if (snapshot.hasError) {
                    return buildDetailRow('Nhóm:', 'Unknownnnnn'); // Hiển thị thông báo lỗi nếu có lỗi xảy ra
                  } else {
                    NhomVang? nhomVang = snapshot.data;
                    return buildDetailRow('Nhóm:', '${nhomVang?.loaiTen ?? "Unknown"}');
                  }
                },
              ),
              buildDetailRow('Cân Tổng:', '${hangHoa.canTong}'),
              buildDetailRow('TL Hột:', '${hangHoa.tlHot}'),
              buildDetailRow('Trừ Hột:', '$truHot'),
              buildDetailRow('nhom:', '${int.parse(hangHoa.loaiId!)}'),
              buildDetailRow('Công Gốc:', '${hangHoa.congGoc}'),
              buildDetailRow('Giá Công:', '${hangHoa.giaCong}'),
              buildDetailRow('Đơn Giá Gốc:', '${hangHoa.donGiaGoc}'),
              buildDetailRow('Ghi Chú:', '${hangHoa.ghiChu}'),
              buildDetailRow('Xuất Xứ:', '${hangHoa.xuatXu}'),
              buildDetailRow('Ký Hiệu:', '${hangHoa.kyHieu}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label ',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Future<LoaiVang> _getLoaiVangById(String? loaiId) async {
    try {
      final loaiVangManager = LoaiVangManager();
      return await loaiVangManager.getLoaiVangById(int.parse(loaiId!)) ?? LoaiVang(nhomTen: "Unknown");
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

}

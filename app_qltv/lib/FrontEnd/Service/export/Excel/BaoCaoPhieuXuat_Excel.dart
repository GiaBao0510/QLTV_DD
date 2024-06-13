import 'package:app_qltv/FrontEnd/model/danhmuc/BaoCaoPhieuXuat.dart';
import 'package:app_qltv/FrontEnd/ui/components/FormatCurrency.dart';
import 'package:excel/excel.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

// Hàm xuất Excel
Future<void> exportExcelPhieuXuat(List<BangBaoCaoPhieuXuat_model> data,
    Map<String, dynamic> thongTinTinhTong) async {
  // Tạo một đối tượng Excel
  var excel = Excel.createExcel();
  var sheet = excel['Sheet1'];

  // Tiêu đề cột
  sheet.appendRow([
    'Mã',
    'Mã hàng hóa',
    'Tên hàng hóa',
    'Loại vàng',
    'Cân tổng',
    'TL hột',
    'TL vàng',
    'Ngày xuất',
    'Đơn giá',
    'Thành tiền',
    'Giá gốc',
    'Lãi lỗ'
  ]);

  // Thêm dữ liệu hàng hóa
  for (var item in data) {
    for (var hanghoas in item.PhieuXuat) {
      sheet.appendRow([
        hanghoas.PHIEU_XUAT_MA,
        hanghoas.HANGHOAMA,
        hanghoas.HANG_HOA_TEN,
        hanghoas.LOAIVANG,
        formatCurrencyDouble(hanghoas.CAN_TONG),
        formatCurrencyDouble(hanghoas.TL_HOT),
        formatCurrencyDouble(hanghoas.TL_Vang),
        hanghoas.NGAY_XUAT,
        formatCurrencyDouble(hanghoas.DON_GIA),
        formatCurrencyDouble(hanghoas.THANH_TIEN),
        formatCurrencyDouble(hanghoas.GiaGoc),
        formatCurrencyDouble(hanghoas.LaiLo),
      ]);
    }
  }

  sheet.appendRow([
    '',
    '',
    '',
    '',
    '',
    '',
    formatCurrencyDouble(thongTinTinhTong['_tongCanTong']),
    formatCurrencyDouble(thongTinTinhTong['_tongTLhot']),
    formatCurrencyDouble(thongTinTinhTong['_tongTLVang']),
    formatCurrencyDouble(thongTinTinhTong['_tongThanhTien']),
    formatCurrencyDouble(thongTinTinhTong['_tongGiaGoc']),
    formatCurrencyDouble(thongTinTinhTong['_tongLaiLo']),
  ]);
  // Lưu tệp Excel vào thư mục phù hợp cho cả Android và iOS
  Directory? directory;
  if (Platform.isAndroid) {
    directory = await getExternalStorageDirectory();
    String newPath = "";
    List<String> paths = directory!.path.split("/");
    for (int x = 1; x < paths.length; x++) {
      String folder = paths[x];
      if (folder != "Android") {
        newPath += "/" + folder;
      } else {
        break;
      }
    }
    newPath = newPath + "/Download";
    directory = Directory(newPath);
  } else if (Platform.isIOS) {
    directory = await getApplicationDocumentsDirectory();
  }

  String outputPath = '${directory!.path}/phieu_xuat.xlsx';
  File(outputPath)
    ..createSync(recursive: true)
    ..writeAsBytesSync(excel.encode()!);

  // Mở tệp Excel để xem trước
  // await OpenFile.open(outputPath);

  // In đường dẫn tệp ra console
  print('Excel file saved to: $outputPath');
}

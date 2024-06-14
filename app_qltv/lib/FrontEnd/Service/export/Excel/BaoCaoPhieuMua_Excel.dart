import 'dart:io';

import 'package:app_qltv/FrontEnd/model/danhmuc/BaoCaoPhieuMua.dart';
import 'package:app_qltv/FrontEnd/ui/components/FormatCurrency.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';

Future<void> exportExcelPhieuMua(List<BaoCaoPhieuMua> data,
    Map<String, dynamic> thongTinTinhTong) async {
  var excel = Excel.createExcel();
  var sheet = excel['Sheet1'];

  sheet.appendRow([
    'Mã',
    'Tên',
    'Cân tổng',
    'TL thực',
    'TL hột',
    'Cân tổng',
    'Thành tiền',
  ]);

  // Add data rows
  for (int i = 0; i < data.length; i++) {
    BaoCaoPhieuMua item = data[i];
    sheet.appendRow([
      item.phieuMa,
      item.nhomTen,
      formatCurrencyDouble(item.canTong ?? 0.0),
      formatCurrencyDouble(item.tlThuc ?? 0.0),
      formatCurrencyDouble(item.tlHot?? 0.0),

      formatCurrencyDouble(item.thanhTien?? 0.0)
    ]);
  }

  sheet.appendRow([
    '',
    '',
    formatCurrencyDouble(thongTinTinhTong['tong_Cantong']),
    formatCurrencyDouble(thongTinTinhTong['tong_TLthuc']),
    formatCurrencyDouble(thongTinTinhTong['tong_TLhot']),

    formatCurrencyDouble(thongTinTinhTong['tong_ThanhTien']),
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

  String outputPath = '${directory!.path}/phieumua.xlsx';
  File(outputPath)
    ..createSync(recursive: true)
    ..writeAsBytesSync(excel.encode()!);

  // Mở tệp Excel để xem trước
  // await OpenFile.open(outputPath);

  // In đường dẫn tệp ra console
  print('Excel file saved to: $outputPath');
}

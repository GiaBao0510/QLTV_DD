import 'dart:io';

import 'package:app_qltv/FrontEnd/model/danhmuc/BaoCaoTonKhoVang.dart';
import 'package:app_qltv/FrontEnd/ui/components/FormatCurrency.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';

Future<void> exportExcelTonKhoVang(List<BaoCaoTonKhoVang_Model> data,
    Map<String, dynamic> thongTinTinhTong) async {
  var excel = Excel.createExcel();
  var sheet = excel['Sheet1'];

  sheet.appendRow([
    'Loại',
    'Tên',
    'Số lượng',
    'TL thực',
    'TL hột',
    'TL vàng',
    'Công gốc',
    'Giá công',
    'Thành tiền',
  ]);

  // Add data rows
  for (int i = 0; i < data.length; i++) {
    BaoCaoTonKhoVang_Model item = data[i];
    sheet.appendRow([
      item.NHOM_TEN,
      '',
      item.SoLuong,
      formatCurrencyDouble(item.TL_Thuc),
      formatCurrencyDouble(item.TL_hot),
      formatCurrencyDouble(item.TL_vang),
      formatCurrencyDouble(item.CONG_GOC),
      formatCurrencyDouble(item.GIA_CONG),
      formatCurrencyDouble(item.ThanhTien)
    ]);
  }

  sheet.appendRow([
    '',
    '',
    '',
    formatCurrencyDouble(thongTinTinhTong['tong_TLthuc']),
    formatCurrencyDouble(thongTinTinhTong['tong_TLhot']),
    formatCurrencyDouble(thongTinTinhTong['tong_TLvang']),
    formatCurrencyDouble(thongTinTinhTong['tong_CongGoc']),
    formatCurrencyDouble(thongTinTinhTong['tong_GiaCong']),
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

  String outputPath = '${directory!.path}/ton_kho_vang.xlsx';
  File(outputPath)
    ..createSync(recursive: true)
    ..writeAsBytesSync(excel.encode()!);

  // Mở tệp Excel để xem trước
  // await OpenFile.open(outputPath);

  // In đường dẫn tệp ra console
  print('Excel file saved to: $outputPath');
}

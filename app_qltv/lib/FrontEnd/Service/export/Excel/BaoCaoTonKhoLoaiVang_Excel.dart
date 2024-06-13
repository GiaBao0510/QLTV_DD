import 'package:app_qltv/FrontEnd/model/danhmuc/BaoCaoTonKhoLoaiVang.dart';
import 'package:app_qltv/FrontEnd/ui/components/FormatCurrency.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<void> exportExcelLoaiVang(List<BaoCaoTonKhoLoaiVang> data,
    Map<String, dynamic> thongTinTinhTong) async {
  var excel = Excel.createExcel();

  // Create a sheet
  var sheet = excel['Sheet1'];

  // Build table header
  sheet.appendRow([
    'Loại',
    'Mã',
    'Tên',
    'Nhóm Vàng',
    'TL Thực',
    'TL Hột',
    'TL Vàng',
    'Công Gốc',
    'Giá Công',
    'Thành Tiền'
  ]);

  // Add data rows
  for (var p_item in data) {
    // Add group header
    sheet.appendRow([p_item.nhomTen]);

    // Add item rows
    for (var c_item in p_item.data) {
      sheet.appendRow([
        c_item.nhomTen,
        c_item.hangHoaMa,
        c_item.hangHoaTen,
        c_item.nhomTen,
        formatCurrencyDouble(c_item.canTong ?? 0),
        formatCurrencyDouble(c_item.tlHot ?? 0),
        formatCurrencyDouble(c_item.tlVang ?? 0),
        formatCurrencyDouble(c_item.congGoc ?? 0),
        formatCurrencyDouble(c_item.giaCong ?? 0),
        formatCurrencyDouble(c_item.thanhTien ?? 0),
      ]);
    }

    // Add group summary row
    sheet.appendRow([
      '',
      p_item.data.length.toString(),
      '',
      '',
      formatCurrencyDouble(p_item.tongTlThuc ?? 0),
      formatCurrencyDouble(p_item.tongTlHot ?? 0),
      formatCurrencyDouble(p_item.tongTlVang ?? 0),
      formatCurrencyDouble(p_item.tongCongGoc ?? 0),
      formatCurrencyDouble(p_item.tongGiaCong ?? 0),
      formatCurrencyDouble(p_item.tongThanhTien ?? 0),
    ]);
  }

  // Add total summary row
  sheet.appendRow([
    '',
    '',
    '',
    '',
    formatCurrencyDouble(thongTinTinhTong['tongTLThuc']),
    formatCurrencyDouble(thongTinTinhTong['tongTLHot']),
    formatCurrencyDouble(thongTinTinhTong['tongTLVang']),
    formatCurrencyDouble(thongTinTinhTong['tongCongGoc']),
    formatCurrencyDouble(thongTinTinhTong['tongGiaCong']),
    formatCurrencyDouble(thongTinTinhTong['tongThanhTien']),
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

  String outputPath = '${directory!.path}/loai_vang.xlsx';
  File(outputPath)
    ..createSync(recursive: true)
    ..writeAsBytesSync(excel.encode()!);

  // Mở tệp Excel để xem trước
  // await OpenFile.open(outputPath);

  // In đường dẫn tệp ra console
  print('Excel file saved to: $outputPath');
}

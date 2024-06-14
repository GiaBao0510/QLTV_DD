import 'package:app_qltv/FrontEnd/controller/danhmuc/hanghoa_manager.dart';
import 'package:app_qltv/FrontEnd/controller/danhmuc/loaivang_manager.dart';
import 'package:app_qltv/FrontEnd/controller/danhmuc/nhacungcap_manager.dart';
import 'package:app_qltv/FrontEnd/controller/danhmuc/nhomvang_manager.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/hanghoa.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/loaivang.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/nhacungcap.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/nhomvang.dart';
import 'package:app_qltv/FrontEnd/ui/components/transitions.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/loai_vang/components/them_loai_vang.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/nha_cung_cap/components/them_nha_cung_cap.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/nhom_vang/components/them_nhom_vang.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChinhSuaHangHoaScreen extends StatefulWidget {
  static const routeName = "/chinhSuaHangHoa";
  final HangHoa hangHoa;

  const ChinhSuaHangHoaScreen({Key? key, required this.hangHoa})
      : super(key: key);

  @override
  State<ChinhSuaHangHoaScreen> createState() => _ChinhSuaHangHoaScreenState();
}

class _ChinhSuaHangHoaScreenState extends State<ChinhSuaHangHoaScreen> {
  final _editForm = GlobalKey<FormState>();
  late HangHoa _editedHangHoa;
  late Future<List<NhomVang>> _nhomVangFuture;
  List<NhomVang> _nhomVangList = [];
  late Future<List<LoaiVang>> _loaiVangFuture;
  List<LoaiVang> _loaiVangList = [];
  late Future<List<NhaCungCap>> _nhaCungCapFuture;
  List<NhaCungCap> _nhaCungCapList = [];

  @override
  void initState() {
    super.initState();
    _editedHangHoa = widget.hangHoa;
    _loadNhomVangs();
    _loadLoaiVangs();
    _loadNhaCungCaps();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadNhomVangs() async {
    _nhomVangFuture =
        Provider.of<NhomVangManager>(context, listen: false).fetchLoaiHang();
    _nhomVangFuture.then((nhomVangs) {
      setState(() {
        _nhomVangList = nhomVangs
            .where(
                (nhomVang) => (nhomVang.loaiId != 0 && nhomVang.loaiId != null))
            .toList();
      });
    });
  }

  Future<void> _loadLoaiVangs() async {
    _loaiVangFuture =
        Provider.of<LoaiVangManager>(context, listen: false).fetchLoaiHang();
    _loaiVangFuture.then((loaiVangs) {
      setState(() {
        _loaiVangList = loaiVangs
            .where((loaiVang) =>
                (loaiVang.nhomHangMa != '' && loaiVang.nhomHangMa != null))
            .toList();
      });
    });
  }

  Future<void> _loadNhaCungCaps() async {
    _nhaCungCapFuture = Provider.of<NhaCungCapManager>(context, listen: false)
        .fetchNhaCungCap();
    _nhaCungCapFuture.then((nhaCungCaps) {
      setState(() {
        _nhaCungCapList = nhaCungCaps
            .where((nhaCungCap) =>
                (nhaCungCap.ncc_id != 0 && nhaCungCap.ncc_id != null))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 50.0),
            child: Text(
              "Chỉnh Sửa Hàng Hóa",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _editForm,
          child: ListView(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(50, 169, 169, 169),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 8, // Tỉ lệ 7/10 cho DropdownButton
                            child: buildNhomVangDropdown(),
                          ),
                          const SizedBox(
                              width: 12.0), // khoảng cách giữa hai widget
                          Expanded(
                            flex:
                                2, // Tỉ lệ 3/10 cho Container bao bọc IconButton
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(
                                  color: Colors.grey, // Màu viền
                                  width: 1.0, // Độ dày viền
                                ),
                              ),
                              child: IconButton(
                                onPressed: () async {
                                  final result =
                                      await Navigator.of(context).push(
                                    createRoute((context) =>
                                        const ThemNhomVangScreen()),
                                  );
                                  if (result == true) {
                                    _loadNhomVangs(); // Refresh the list when receiving the result
                                  }
                                },
                                icon: const Icon(CupertinoIcons.add_circled),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 8, // Tỉ lệ 7/10 cho DropdownButton
                            child: buildLoaiVangDropdown(),
                          ),
                          const SizedBox(
                              width: 12.0), // khoảng cách giữa hai widget
                          Expanded(
                            flex:
                                2, // Tỉ lệ 3/10 cho Container bao bọc IconButton
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(
                                  color: Colors.grey, // Màu viền
                                  width: 1.0, // Độ dày viền
                                ),
                              ),
                              child: IconButton(
                                onPressed: () async {
                                  final result =
                                      await Navigator.of(context).push(
                                    createRoute((context) =>
                                        const ThemLoaiVangScreen()),
                                  );
                                  if (result == true) {
                                    _loadLoaiVangs(); // Refresh the list when receiving the result
                                  }
                                },
                                icon: const Icon(CupertinoIcons.add_circled),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0),
                      child: buildTenHangField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: buildCanTongField(),
                          ),
                          const SizedBox(
                              width: 12.0), // khoảng cách giữa hai widget
                          Expanded(
                            child: buildTLHotField(),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0),
                      child: buildCongGocField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0),
                      child: buildCongBanField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0),
                      child: buildDonGiaGocField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 8, // Tỉ lệ 7/10 cho DropdownButton
                            child: buildNNCDropdown(),
                          ),
                          const SizedBox(
                              width: 12.0), // khoảng cách giữa hai widget
                          Expanded(
                            flex:
                                2, // Tỉ lệ 3/10 cho Container bao bọc IconButton
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(
                                  color: Colors.grey, // Màu viền
                                  width: 1.0, // Độ dày viền
                                ),
                              ),
                              child: IconButton(
                                onPressed: () async {
                                  final result =
                                      await Navigator.of(context).push(
                                    createRoute((context) =>
                                        const ThemNhaCungCapScreen()),
                                  );
                                  if (result == true) {
                                    _loadNhaCungCaps(); // Refresh the list when receiving the result
                                  }
                                },
                                icon: const Icon(CupertinoIcons.add_circled),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0),
                      child: buildGhiChuField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0),
                      child: buildXuatXuField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0),
                      child: buildSoLuongField(),
                    ),

                    // Add other fields as needed
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 228, 200, 126)),
                onPressed: () => _saveForm(context),
                child: const Text(
                  'Lưu',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.green,
                      fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropdownButtonFormField<int> buildNhomVangDropdown() {
    int? dropdownValue;
    if (_editedHangHoa.loaiId != '') {
      int? parsedValue = int.tryParse(_editedHangHoa.loaiId!);
      if (parsedValue != null &&
          _nhomVangList.any((nhomHang) => nhomHang.loaiId == parsedValue)) {
        dropdownValue = parsedValue;
      } else {
        dropdownValue = null;
      }
    }
    return DropdownButtonFormField<int>(
      dropdownColor: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      decoration: const InputDecoration(
        labelText: 'Nhóm Vàng',
        labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 15.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 228, 200, 126), width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
      value: dropdownValue ?? 0,
      items: _nhomVangList.map((NhomVang nhomHang) {
        return DropdownMenuItem<int>(
          value: (nhomHang.loaiId ?? 0),
          child: Text(nhomHang.loaiTen!),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _editedHangHoa = _editedHangHoa.copyWith(loaiId: newValue.toString());
        });
      },
      // validator: (value) {
      //   if (value == null || value == 0) {
      //     return 'Please select a value';
      //   }
      //   return null;
      // },
    );
  }

  DropdownButtonFormField<String> buildLoaiVangDropdown() {
    String? dropdownValue;
    if (_editedHangHoa.nhomHangId != '') {
      int? parsedValue = int.tryParse(_editedHangHoa.nhomHangId!);
      if (parsedValue != null &&
          _loaiVangList.any(
              (loaiHang) => int.parse(loaiHang.nhomHangMa!) == parsedValue)) {
        dropdownValue = parsedValue.toString();
      } else {
        dropdownValue = '';
      }
    }
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      decoration: const InputDecoration(
        labelText: 'Loại Vàng',
        labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 15.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 228, 200, 126), width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
      value: dropdownValue == '' ? null : dropdownValue,
      items: _loaiVangList.map((LoaiVang loaiHang) {
        return DropdownMenuItem<String>(
          value: loaiHang.nhomHangMa,
          child: Text(loaiHang.nhomTen!),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _editedHangHoa = _editedHangHoa.copyWith(nhomHangId: newValue ?? '');
        });
      },
      // validator: (value) {
      //   if (value == null || value == 0) {
      //     return 'Please select a value';
      //   }
      //   return null;
      // },
    );
  }

  TextFormField buildTenHangField() {
    return TextFormField(
      initialValue: _editedHangHoa.hangHoaTen.toString(),
      decoration: const InputDecoration(
        labelText: 'Tên Hàng',
        labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 15.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 228, 200, 126), width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value';
        }
        return null;
      },
      onSaved: (value) {
        _editedHangHoa = _editedHangHoa.copyWith(hangHoaTen: value);
      },
    );
  }

  TextFormField buildCanTongField() {
    return TextFormField(
      initialValue: _editedHangHoa.canTong.toString(),
      decoration: const InputDecoration(
        labelText: 'Cân Tổng',
        labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 15.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 228, 200, 126), width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value';
        }
        return null;
      },
      onSaved: (value) {
        _editedHangHoa = _editedHangHoa.copyWith(canTong: double.parse(value!));
      },
    );
  }

  TextFormField buildTLHotField() {
    return TextFormField(
      initialValue: _editedHangHoa.canTong.toString(),
      decoration: const InputDecoration(
        labelText: 'TL Hột',
        labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 15.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 228, 200, 126), width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value';
        }
        return null;
      },
      onSaved: (value) {
        _editedHangHoa = _editedHangHoa.copyWith(tlHot: double.parse(value!));
      },
    );
  }

  TextFormField buildCongGocField() {
    return TextFormField(
      initialValue: _editedHangHoa.canTong.toString(),
      decoration: const InputDecoration(
        labelText: 'Công Gốc',
        labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 15.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 228, 200, 126), width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value';
        }
        return null;
      },
      onSaved: (value) {
        _editedHangHoa = _editedHangHoa.copyWith(congGoc: double.parse(value!));
      },
    );
  }

  TextFormField buildCongBanField() {
    return TextFormField(
      initialValue: _editedHangHoa.canTong.toString(),
      decoration: const InputDecoration(
        labelText: 'Công Bán',
        labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 15.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 228, 200, 126), width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value';
        }
        return null;
      },
      onSaved: (value) {
        _editedHangHoa =
            _editedHangHoa.copyWith(giaBanSi: double.parse(value!));
      },
    );
  }

  TextFormField buildDonGiaGocField() {
    return TextFormField(
      initialValue: _editedHangHoa.canTong.toString(),
      decoration: const InputDecoration(
        labelText: 'Đơn Giá Gốc',
        labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 15.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 228, 200, 126), width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value';
        }
        return null;
      },
      onSaved: (value) {
        _editedHangHoa =
            _editedHangHoa.copyWith(donGiaGoc: double.parse(value!));
      },
    );
  }

  DropdownButtonFormField<int> buildNNCDropdown() {
    int? dropdownValue;
    if (_editedHangHoa.nccId != '') {
      int? parsedValue = int.tryParse(_editedHangHoa.nccId!);
      if (parsedValue != null &&
          _nhaCungCapList.any((ncc) => ncc.ncc_id == parsedValue)) {
        dropdownValue = parsedValue;
      } else {
        dropdownValue = null;
      }
    }
    return DropdownButtonFormField<int>(
      dropdownColor: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      decoration: const InputDecoration(
        labelText: 'Nhà Cung Cấp',
        labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 15.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 228, 200, 126), width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
      value: dropdownValue ?? 0,
      items: _nhaCungCapList.map((NhaCungCap ncc) {
        return DropdownMenuItem<int>(
          value: (ncc.ncc_id ?? 0),
          child: Text(ncc.ncc_ten!),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _editedHangHoa = _editedHangHoa.copyWith(nccId: newValue.toString());
        });
      },
      // validator: (value) {
      //   if (value == null || value == 0) {
      //     return 'Please select a value';
      //   }
      //   return null;
      // },
    );
  }

  TextFormField buildGhiChuField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Ghi Chú',
        labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 15.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 228, 200, 126), width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      autofocus: true,
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     return 'Please provide a value';
      //   }
      //   return null;
      // },
      onSaved: (value) {
        _editedHangHoa = _editedHangHoa.copyWith(ghiChu: value);
      },
    );
  }

  TextFormField buildXuatXuField() {
    return TextFormField(
      initialValue: _editedHangHoa.xuatXu.toString(),
      decoration: const InputDecoration(
        labelText: 'Xuất Xứ',
        labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 15.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 228, 200, 126), width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value';
        }
        return null;
      },
      onSaved: (value) {
        _editedHangHoa = _editedHangHoa.copyWith(xuatXu: value);
      },
    );
  }

  TextFormField buildSoLuongField() {
    return TextFormField(
      initialValue: _editedHangHoa.soLuong.toString(),
      decoration: const InputDecoration(
        labelText: 'Số Lượng',
        labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 15.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 228, 200, 126), width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value';
        }
        return null;
      },
      onSaved: (value) {
        _editedHangHoa = _editedHangHoa.copyWith(soLuong: int.parse(value!));
      },
    );
  }

  Future<void> _saveForm(BuildContext context) async {
    final isValid = _editForm.currentState!.validate();
    if (!isValid) {
      return;
    }
    _editForm.currentState!.save();
    // You can add further validation or processing logic here
    try {
      final hangHoaManager =
          Provider.of<HangHoaManager>(context, listen: false);
      await hangHoaManager.updateHangHoa(
          widget.hangHoa.hangHoaMa as String, _editedHangHoa);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Cập nhật thành công!',
            style: TextStyle(fontWeight: FontWeight.w900),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: const BorderSide(
                color: Colors.grey, width: 2.0), // bo viền 15px
          ),
          behavior: SnackBarBehavior.floating, // hiển thị ở cách đáy màn hình
          margin: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              bottom: 15.0), // cách 2 cạnh và đáy màn hình 15px
        ),
      );
      Navigator.of(context).pop(true); // Go back to the previous screen
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to edit data: $error',
            style:
                const TextStyle(fontWeight: FontWeight.w900, color: Colors.red),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: const BorderSide(
                color: Colors.grey, width: 2.0), // bo viền 15px
          ),
          behavior: SnackBarBehavior.floating, // hiển thị ở cách đáy màn hình
          margin: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              bottom: 15.0), // cách 2 cạnh và đáy màn hình 15px
        ),
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider package

import 'package:app_qltv/FrontEnd/model/danhmuc/nhom_vang/nhomvang.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/nhom_vang/nhomvang_manager.dart';

class ThemNhomVangScreen extends StatefulWidget {
  static const routeName = "/themnvhomvang";

  const ThemNhomVangScreen({Key? key}) : super(key: key);

  @override
  State<ThemNhomVangScreen> createState() => _ThemNhomVangScreenState();
}

class _ThemNhomVangScreenState extends State<ThemNhomVangScreen> {
  final _addForm = GlobalKey<FormState>();
  var _newNhomVang = NhomVang(
    loaiId: null,
    loaiMa: '',
    loaiTen: '',
    ghiChu: '',
    suDung: null,
  );

  @override
  void initState() {
    super.initState();
    Provider.of<NhomVangManager>(context, listen: false).fetchLoaiHang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text('Thêm Nhóm Vàng'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _addForm,
          child: ListView(
            children: <Widget>[
              buildLoaiTenField(),
              buildKyHieuField(),
              const SizedBox(height: 20),
              Consumer<NhomVangManager>(
                builder: (ctx, nhomVangManager, _) {
                  final nhomVangsLength = nhomVangManager.nhomVangsLength;
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => _saveForm(context, nhomVangsLength),
                        child: const Text('Thêm Data'),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildLoaiTenField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Tên Nhóm'),
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
        _newNhomVang = _newNhomVang.copyWith(loaiTen: value);
      },
    );
  }

  TextFormField buildKyHieuField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Ký Hiệu'),
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
        _newNhomVang = _newNhomVang.copyWith(ghiChu: value);
      },
    );
  }

  Future<void> _saveForm(BuildContext context, int nhomVangsLengthBefore) async {
    final isValid = _addForm.currentState!.validate();
    if (!isValid) {
      return;
    }
    _addForm.currentState!.save();

    try {
      final nhomVangManager = Provider.of<NhomVangManager>(context, listen: false);
      await nhomVangManager.addNhomVang(_newNhomVang);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data added successfully')),
      );
      Navigator.of(context).pop(true); // Go back to the previous screen
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add data: $error')),
      );
    }
  }
}

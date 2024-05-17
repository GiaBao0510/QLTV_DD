import 'package:flutter/cupertino.dart';
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
              child: Text("Thêm Nhóm Vàng", style: TextStyle(color: Colors.black ,fontWeight: FontWeight.w900), textAlign: TextAlign.center,),
            ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _addForm,
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
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: buildLoaiTenField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child: buildKyHieuField(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[50]
                ),
                onPressed: () => _saveForm(context),
                child: const Text('Thêm', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.green),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildLoaiTenField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Tên Nhóm',
        labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 15.0),
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
        _newNhomVang = _newNhomVang.copyWith(loaiTen: value);
      },
    );
  }

  TextFormField buildKyHieuField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Ký Hiệu',
        labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 15.0),
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
        _newNhomVang = _newNhomVang.copyWith(ghiChu: value);
      },
    );
  }

  Future<void> _saveForm(BuildContext context) async {
    final isValid = _addForm.currentState!.validate();
    if (!isValid) {
      return;
    }
    _addForm.currentState!.save();

    try {
      final nhomVangManager = Provider.of<NhomVangManager>(context, listen: false);
      await nhomVangManager.addNhomVang(_newNhomVang);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Thêm thành công!', style: TextStyle(fontWeight: FontWeight.w900), textAlign: TextAlign.center,),
          backgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: const BorderSide(color: Colors.grey, width: 2.0), // bo viền 15px
          ),
          behavior: SnackBarBehavior.floating, // hiển thị ở cách đáy màn hình
          margin: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0), // cách 2 cạnh và đáy màn hình 15px
        ),
      );
      Navigator.of(context).pop(true); // Go back to the previous screen
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Failed to update data', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.red), textAlign: TextAlign.center,),
          backgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: const BorderSide(color: Colors.grey, width: 2.0), // bo viền 15px
          ),
          behavior: SnackBarBehavior.floating, // hiển thị ở cách đáy màn hình
          margin: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0), // cách 2 cạnh và đáy màn hình 15px
        ),
      );
    }
  }
}

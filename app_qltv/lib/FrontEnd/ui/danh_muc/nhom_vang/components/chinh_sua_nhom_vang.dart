import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider package

import 'package:app_qltv/FrontEnd/model/danhmuc/nhom_vang/nhomvang.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/nhom_vang/nhomvang_manager.dart';

class ChinhSuaNhomVangScreen extends StatefulWidget {
  static const routeName = "/chinhsuanhomvang";

  final NhomVang nhomVang;

  const ChinhSuaNhomVangScreen({Key? key, required this.nhomVang}) : super(key: key);

  @override
  State<ChinhSuaNhomVangScreen> createState() => _ChinhSuaNhomVangScreenState();
}

class _ChinhSuaNhomVangScreenState extends State<ChinhSuaNhomVangScreen> {
  // final TextEditingController _controller = TextEditingController();
  final _editForm = GlobalKey<FormState>();
  late NhomVang _editedNhomVang;

  @override
  void initState() {
    super.initState();
    _editedNhomVang = widget.nhomVang; // Initialize _editedNhomVang with widget's nhomVang
    // _controller.text = _editedNhomVang.loaiTen ?? ''; // Set initial value for TextField
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
        title: Row(
          children: [
            const Text("Chỉnh Sửa Nhóm Vàng", style: TextStyle(color: Colors.black ,fontWeight: FontWeight.w900 )),
            Expanded(child: Container()), // Spacer
          ],
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
                onPressed: () => _saveForm(context),
                child: const Text('Update Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildLoaiTenField() {
    return TextFormField(
      initialValue: _editedNhomVang.loaiTen.toString(),
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
        _editedNhomVang = _editedNhomVang.copyWith(loaiTen: value);
      },
    );
  }
  TextFormField buildKyHieuField() {
    return TextFormField(
      initialValue: _editedNhomVang.ghiChu.toString(),
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
        _editedNhomVang = _editedNhomVang.copyWith(ghiChu: value);
      },
    );
  }

  Future<void> _saveForm(BuildContext context) async {
    final isValid = _editForm.currentState!.validate();
    if (!isValid) {
      return;
    }
    _editForm.currentState!.save();

    try {
      final nhomVangManager = Provider.of<NhomVangManager>(context, listen: false); 
      await nhomVangManager.updateLoaiHang(_editedNhomVang.loaiId as int, _editedNhomVang.loaiMa as String, _editedNhomVang.loaiTen as String, _editedNhomVang.ghiChu as String, _editedNhomVang.suDung as int); // Call updateLoaiHang method
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Data updated successfully', style: TextStyle(fontWeight: FontWeight.w900), textAlign: TextAlign.center,),
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
          content: const Text('DFailed to update data', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.red), textAlign: TextAlign.center,),
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

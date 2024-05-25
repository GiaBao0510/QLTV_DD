import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider package

import 'package:app_qltv/FrontEnd/model/hethong/nhom.dart';
import 'package:app_qltv/FrontEnd/controller/hethong/nhom_manager.dart';

class ChinhSuaNhomScreen extends StatefulWidget {
  static const routeName = "/chinhsuanhom";

  final Nhom nhom;

  const ChinhSuaNhomScreen(this.nhom,{super.key});

  @override
  State<ChinhSuaNhomScreen> createState() => _ChinhSuaNhomScreenState();
  }

class _ChinhSuaNhomScreenState extends State<ChinhSuaNhomScreen> {
  final _editForm = GlobalKey<FormState>();
  late Nhom _editedNhom;

  @override
  void initState() {
    super.initState();
    _editedNhom = widget.nhom; // Initialize _editedNhomVang with widget's nhomVang
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
              child: Text("Chỉnh Sửa Nhóm", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900), textAlign: TextAlign.center,),
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
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: buildGroupTenField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: buildLyDoKhoaField(),
                    ),
                    buildBiKhoaCheckbox(),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[50]
                ),
                onPressed: () => _saveForm(context),
                child: const Text('Cập nhật', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.green),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  
  TextFormField buildGroupTenField() {
    return TextFormField(
      initialValue: _editedNhom.groupTen.toString(),
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
          return 'Vui lòng cung cấp tên nhóm';
        }
        return null;
      },
      onSaved: (value) {
        _editedNhom = _editedNhom.copyWith(groupTen: value);
      },
    );
  }

  TextFormField buildLyDoKhoaField() {
    return TextFormField(
      initialValue: _editedNhom.lyDoKhoa.toString(),
      decoration: const InputDecoration(
        labelText: 'Lý Do Khóa',
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
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     return 'Vui lòng cung cấp lý do khóa';
      //   }
      //   return null;
      // },
      onSaved: (value) {
        _editedNhom = _editedNhom.copyWith(lyDoKhoa: value);
      },
    );
  }

  Row buildBiKhoaCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _editedNhom.biKhoa,
          onChanged: (value) {
            setState(() {
              _editedNhom = _editedNhom.copyWith(biKhoa: value);
            });
          },
        ),
        const Text(
          'Bị Khóa',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Future<void> _saveForm(BuildContext context) async {
    final isValid = _editForm.currentState!.validate();
    if (!isValid) {
      return;
    }
    _editForm.currentState!.save();

    try {
      final nhomManager = Provider.of<NhomManager>(context, listen: false);
      await nhomManager.updateNhom(_editedNhom.groupId as String, _editedNhom.groupMa as String, _editedNhom.groupTen as String, _editedNhom.biKhoa as bool, _editedNhom.lyDoKhoa as String, _editedNhom.suDung as bool);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Cập nhật thành công!', style: TextStyle(fontWeight: FontWeight.w900), textAlign: TextAlign.center,),
          backgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: const BorderSide(color: Colors.grey, width: 2.0), // bo viền 15px
          ),
          behavior: SnackBarBehavior.floating, // hiển thị ở cách đáy màn hình
          margin: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0), // cách 2 cạnh và đáy màn hình 15px
        ),
      );
      Navigator.of(context).pop(true); // Quay lại màn hình trước
    } 
    catch (error, stackTrace) {
      print('Failed to add group: $error');
      print('Stack trace: $stackTrace');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:  Text('Không thể cập nhóm: $error', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.red), textAlign: TextAlign.center,),
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
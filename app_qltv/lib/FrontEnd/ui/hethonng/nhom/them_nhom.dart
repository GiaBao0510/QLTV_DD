import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider package

import 'package:app_qltv/FrontEnd/model/hethong/nhom.dart';
import 'package:app_qltv/FrontEnd/controller/hethong/nhom_manager.dart';

class ThemNhomScreen extends StatefulWidget {
  static const routeName = "/themnnhom";

  const ThemNhomScreen({Key? key}) : super(key: key);

  @override
  State<ThemNhomScreen> createState() => _ThemNhomScreenState();
}

class _ThemNhomScreenState extends State<ThemNhomScreen> {
  final _addForm = GlobalKey<FormState>();
  var _newNhom = Nhom(
    groupId: null,
    groupMa: '',
    groupTen: '',
    biKhoa: false,
    lyDoKhoa: '',
    suDung: true,
    ngayTao: DateTime.now(),
  );

  @override
  void initState() {
    super.initState();
    Provider.of<NhomManager>(context, listen: false).fetchNhoms();
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
              child: Text("Thêm Nhóm", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900), textAlign: TextAlign.center,),
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
                child: const Text('Thêm', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.green),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildGroupTenField() {
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
          return 'Vui lòng cung cấp tên nhóm';
        }
        return null;
      },
      onSaved: (value) {
        _newNhom = _newNhom.copyWith(groupTen: value);
      },
    );
  }

  TextFormField buildLyDoKhoaField() {
    return TextFormField(
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
        _newNhom = _newNhom.copyWith(lyDoKhoa: value);
      },
    );
  }

  Row buildBiKhoaCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _newNhom.biKhoa,
          onChanged: (value) {
            setState(() {
              _newNhom = _newNhom.copyWith(biKhoa: value);
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
    final isValid = _addForm.currentState!.validate();
    if (!isValid) {
      return;
    }
    _addForm.currentState!.save();

    try {
      final nhomManager = Provider.of<NhomManager>(context, listen: false);
      await nhomManager.addNhom(_newNhom);
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
      Navigator.of(context).pop(true); // Quay lại màn hình trước
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Không thể thêm nhóm', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.red), textAlign: TextAlign.center,),
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

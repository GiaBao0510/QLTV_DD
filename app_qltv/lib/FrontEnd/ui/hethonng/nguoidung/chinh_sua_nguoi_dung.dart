import 'package:app_qltv/FrontEnd/controller/hethong/nhom_manager.dart';
import 'package:app_qltv/FrontEnd/model/hethong/nhom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider package

import 'package:app_qltv/FrontEnd/model/hethong/nguoidung.dart';
import 'package:app_qltv/FrontEnd/controller/hethong/nguoidung_manager.dart';

class ChinhSuaNguoiDungScreen extends StatefulWidget {
  static const routeName = "/chinhsuanguoidung";

  final NguoiDung nguoiDung;

  const ChinhSuaNguoiDungScreen(this.nguoiDung, {super.key});

  @override
  State<ChinhSuaNguoiDungScreen> createState() =>
      _ChinhSuaNguoiDungScreenState();
}

class _ChinhSuaNguoiDungScreenState extends State<ChinhSuaNguoiDungScreen> {
  final _editForm = GlobalKey<FormState>();
  late NguoiDung _editedNguoiDung;

  late Future<List<Nhom>> _nhomFuture;
  List<Nhom> _nhomList = [];

  @override
  void initState() {
    super.initState();
    _editedNguoiDung =
        widget.nguoiDung; // Initialize _editedNguoiDung with widget's nguoiDung
    _loadNhom();
  }

  Future<void> _loadNhom() async {
    _nhomFuture = Provider.of<NhomManager>(context, listen: false).fetchNhoms();
    _nhomFuture.then((nhom) {
      setState(() {
        _nhomList = nhom;
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
              "Chỉnh Sửa Người Dùng",
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
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: buildUserTenField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: buildMatKhauField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: buildNhomDropdown(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: buildLyDoKhoaField(),
                    ),
                    buildBiKhoaCheckbox(),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 228, 200, 126),
                ),
                onPressed: () => _saveForm(context),
                child: const Text(
                  'Cập nhật',
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

  TextFormField buildUserTenField() {
    return TextFormField(
      initialValue: _editedNguoiDung.userTen,
      decoration: const InputDecoration(
        labelText: 'Tên Người Dùng',
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
          return 'Vui lòng cung cấp tên người dùng';
        }
        return null;
      },
      onSaved: (value) {
        _editedNguoiDung = _editedNguoiDung.copyWith(userTen: value);
      },
    );
  }

  TextFormField buildMatKhauField() {
    return TextFormField(
      initialValue: _editedNguoiDung.matKhau,
      //initialValue: "***",
      decoration: const InputDecoration(
        labelText: 'Mật Khẩu',
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
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Vui lòng cung cấp mật khẩu';
        }
        return null;
      },
      onSaved: (value) {
        _editedNguoiDung = _editedNguoiDung.copyWith(matKhau: value);
      },
    );
  }

  DropdownButtonFormField<int> buildNhomDropdown() {
    return DropdownButtonFormField<int>(
      dropdownColor: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      decoration: const InputDecoration(
        labelText: 'Nhóm Nguời Dùng',
        labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 15.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
      value: _editedNguoiDung.groupId,
      items: _nhomList
          .where(
              (nhom) => nhom.groupId != null) // Loại bỏ các mục có giá trị null
          .map((Nhom nhom) {
        return DropdownMenuItem<int>(
          value: int.tryParse(nhom.groupId!),
          child: Text(nhom.groupTen ?? nhom.groupId!),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _editedNguoiDung = _editedNguoiDung.copyWith(groupId: newValue);
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

  TextFormField buildLyDoKhoaField() {
    return TextFormField(
      initialValue: _editedNguoiDung.lyDoKhoa,
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
      onSaved: (value) {
        _editedNguoiDung = _editedNguoiDung.copyWith(lyDoKhoa: value);
      },
    );
  }

  Row buildBiKhoaCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _editedNguoiDung.biKhoa,
          onChanged: (value) {
            setState(() {
              _editedNguoiDung = _editedNguoiDung.copyWith(biKhoa: value);
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
      final nguoiDungManager =
          Provider.of<NguoiDungManager>(context, listen: false);
      await nguoiDungManager.updateNguoiDung(
        _editedNguoiDung.userId!,
        _editedNguoiDung.groupId!,
        _editedNguoiDung.userMa!,
        _editedNguoiDung.userTen!,
        _editedNguoiDung.matKhau!,
        _editedNguoiDung.biKhoa!,
        _editedNguoiDung.lyDoKhoa!,
        _editedNguoiDung.ngayTao!,
        _editedNguoiDung.suDung!,
      );

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
      Navigator.of(context).pop(true); // Quay lại màn hình trước
    } catch (error, stackTrace) {
      print('Failed to add group: $error');
      print('Stack trace: $stackTrace');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Không thể cập nhóm: $error',
            style: TextStyle(fontWeight: FontWeight.w900, color: Colors.red),
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

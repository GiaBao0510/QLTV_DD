import 'package:app_qltv/FrontEnd/controller/hethong/nhom_manager.dart';
import 'package:app_qltv/FrontEnd/model/hethong/nhom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_qltv/FrontEnd/model/hethong/nguoidung.dart';
import 'package:app_qltv/FrontEnd/controller/hethong/nguoidung_manager.dart';

class ThemNguoiDungScreen extends StatefulWidget {
  static const routeName = "/themnguoidung";

  const ThemNguoiDungScreen({super.key});

  @override
  State<ThemNguoiDungScreen> createState() => _ThemNguoiDungScreenState();
}

class _ThemNguoiDungScreenState extends State<ThemNguoiDungScreen> {
  final _addForm = GlobalKey<FormState>();
  var _newNguoiDung = NguoiDung(
    userId: null,
    groupId: null,
    userMa: '1',
    userTen: '',
    matKhau: '',
    biKhoa: false,
    lyDoKhoa: '',
    ngayTao: DateTime.now(),
    suDung: true,
    realm: null,
    email: null,
    emailVerified: null,
    verificationToken: null,
    mac: null,
  );

  late Future<List<Nhom>> _nhomFuture;
  List<Nhom> _nhomList = [];

  @override
  void initState() {
    super.initState();
    Provider.of<NguoiDungManager>(context, listen: false).fetchNguoiDungs();
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

  // Future<void> _loadNhom() async {
  //   try {
  //     await Provider.of<NhomManager>(context, listen: false).fetchNhoms();
  //   } catch (error) {
  //     print('Failed to load data: $error');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Không thể tải dữ liệu nhóm: $error'),
  //       ),
  //     );
  //   }
  // }

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
              "Thêm Người Dùng",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
              textAlign: TextAlign.center,
            ),
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
                    backgroundColor: const Color.fromARGB(255, 228, 200, 126)),
                onPressed: () => _saveForm(context),
                child: const Text(
                  'Thêm',
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
      validator: (value) {
        if (value!.isEmpty) {
          return 'Vui lòng cung cấp tên người dùng';
        }
        return null;
      },
      onSaved: (value) {
        _newNguoiDung = _newNguoiDung.copyWith(userTen: value);
      },
    );
  }

  TextFormField buildMatKhauField() {
    return TextFormField(
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
      keyboardType: TextInputType.visiblePassword,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Vui lòng cung cấp mật khẩu';
        }
        return null;
      },
      onSaved: (value) {
        _newNguoiDung = _newNguoiDung.copyWith(matKhau: value);
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
      value: _newNguoiDung.groupId,
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
          _newNguoiDung = _newNguoiDung.copyWith(groupId: newValue);
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
        _newNguoiDung = _newNguoiDung.copyWith(lyDoKhoa: value);
      },
    );
  }

  Row buildBiKhoaCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _newNguoiDung.biKhoa,
          onChanged: (value) {
            setState(() {
              _newNguoiDung = _newNguoiDung.copyWith(biKhoa: value);
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
      final nguoiDungManager =
          Provider.of<NguoiDungManager>(context, listen: false);
      await nguoiDungManager.addNguoiDung(_newNguoiDung);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Thêm thành công!',
            style: TextStyle(fontWeight: FontWeight.w900),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: const BorderSide(color: Colors.grey, width: 2.0),
          ),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
        ),
      );
      Navigator.of(context).pop(true);
    } catch (error, stackTrace) {
      print('Failed to add user: $error');
      print('Stack trace: $stackTrace');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Không thể thêm người dùng: $error',
            style: TextStyle(fontWeight: FontWeight.w900, color: Colors.red),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: const BorderSide(color: Colors.grey, width: 2.0),
          ),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
        ),
      );
    }
  }
}

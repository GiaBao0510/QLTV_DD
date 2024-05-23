import 'package:app_qltv/FrontEnd/controller/danhmuc/nhacungcap_manager.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/nhacungcap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class ChinhSuaNhaCungCapScreen extends StatefulWidget {
  static const routeName = "/chinhsuaNhaCungCap";

  final NhaCungCap nhacungcap;

  const ChinhSuaNhaCungCapScreen({Key? key, required this.nhacungcap}) : super(key: key);

  @override
  State<ChinhSuaNhaCungCapScreen> createState() => _ChinhSuaNhaCungCapScreenState();
}

class _ChinhSuaNhaCungCapScreenState extends State<ChinhSuaNhaCungCapScreen> {
  final _editForm = GlobalKey<FormState>();
  late NhaCungCap _editedNhaCungCap;
  final TextEditingController _dateController = TextEditingController();
  late DateTime _selectedDate;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    _editedNhaCungCap = widget.nhacungcap;
    _selectedDate = _editedNhaCungCap.ngay_bd != null
        ? _dateFormat.parse(_editedNhaCungCap.ngay_bd!)
        : DateTime.now();
    _dateController.text = _dateFormat.format(_selectedDate);
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = _dateFormat.format(_selectedDate);
        _editedNhaCungCap = _editedNhaCungCap.copyWith(ngay_bd: _selectedDate.toIso8601String());
      });
    }
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
            child: Text(
              "Chỉnh Sửa Nhà Cung Cấp",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
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
                      child: buildLoaiTenField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: buildKyHieuField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child: buildNgayBdField(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[50]),
                onPressed: () => _saveForm(context),
                child: const Text(
                  'Cập Nhật',
                  style: TextStyle(fontWeight: FontWeight.w900, color: Colors.green),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildLoaiTenField() {
    return TextFormField(
      initialValue: _editedNhaCungCap.ncc_ten,
      decoration: const InputDecoration(
        labelText: 'Tên Nhà Cung Cấp',
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
        _editedNhaCungCap = _editedNhaCungCap.copyWith(ncc_ten: value);
      },
    );
  }

  TextFormField buildKyHieuField() {
    return TextFormField(
      initialValue: _editedNhaCungCap.ghi_chu,
      decoration: const InputDecoration(
        labelText: 'Địa Chỉ',
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
        _editedNhaCungCap = _editedNhaCungCap.copyWith(ghi_chu: value);
      },
    );
  }

  TextFormField buildNgayBdField(BuildContext context) {
    return TextFormField(
      controller: _dateController,
      decoration: const InputDecoration(
        labelText: 'Ngày Bắt Đầu',
        labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 15.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
      readOnly: true,
      onTap: () => _selectDate(context),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value';
        }
        return null;
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
      final nhaCungCapManager = Provider.of<NhaCungCapManager>(context, listen: false);

      await nhaCungCapManager.updateNhaCungCap(
        _editedNhaCungCap.ncc_ma!,
        _editedNhaCungCap.ncc_ten!,
        _editedNhaCungCap.ghi_chu!,
        _selectedDate.toIso8601String(),
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
            side: const BorderSide(color: Colors.grey, width: 2.0),
          ),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
        ),
      );
      Navigator.of(context).pop(true);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Failed to update data $error",
            style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.red),
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

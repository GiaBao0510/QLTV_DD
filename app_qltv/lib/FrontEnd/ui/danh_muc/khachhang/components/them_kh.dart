import 'package:app_qltv/FrontEnd/controller/danhmuc/khachhang_manager.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/khachhang.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider package

class ThemKhachhangScreen extends StatefulWidget {
  static const routeName = "/themkhachhang";

  const ThemKhachhangScreen({Key? key}) : super(key: key);

  @override
  State<ThemKhachhangScreen> createState() => _ThemKhachhangScreenState();
}

class _ThemKhachhangScreenState extends State<ThemKhachhangScreen> {
  final _formKey = GlobalKey<FormState>();
  late Khachhang _newKhachhang;
  late Future<List<Khachhang>> _khachhangFuture;
  List<Khachhang> _khachhangList = [];

  @override
  void initState() {
    super.initState();
    _newKhachhang = Khachhang(
      kh_ten: '',
      kh_cmnd: '',
      kh_sdt: '',
      kh_dia_chi : '',
      kh_ghi_chu: '',
    );
    _loadKhachhangs();
  }

  Future<void> _loadKhachhangs() async {
    _khachhangFuture = Provider.of<KhachhangManage>(context, listen: false).fetchKhachhang();
    _khachhangFuture.then((Khachhangs) {
      setState(() {
        _khachhangList = Khachhangs;
      });
    });
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
              "Thêm Khách hàng",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
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
                      child: buildTenKhachhhangField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: buildCMNDField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: buildSDTField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: buildDiachiField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: buildGhichuField(),
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
                child: const Text('Thêm Mới', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.green),),
              ),
            ],
          ),
        ),
      ),
    );
  }


  TextFormField buildTenKhachhhangField() {
    return TextFormField(
      initialValue: _newKhachhang.kh_ten.toString(),
      decoration: const InputDecoration(
        labelText: 'Tên khách hàng',
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
        _newKhachhang = _newKhachhang.copyWith(kh_ten: value);
      },
    );
  }

TextFormField buildCMNDField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'CMND',
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
      onSaved: (value) {
        _newKhachhang = _newKhachhang.copyWith(kh_cmnd: value);
      },
    );
  }
  TextFormField buildDiachiField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Địa chỉ',
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
      onSaved: (value) {
        _newKhachhang = _newKhachhang.copyWith(kh_dia_chi: value);
      },
    );
  }
  TextFormField buildGhichuField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Ghi chú',
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
      onSaved: (value) {
        _newKhachhang = _newKhachhang.copyWith(kh_ghi_chu: value);
      },
    );
  }

  TextFormField buildSDTField() {
    return TextFormField(
      initialValue: _newKhachhang.kh_sdt.toString(),
      decoration: const InputDecoration(
        labelText: 'SĐT',
        labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 15.0),
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
        _newKhachhang = _newKhachhang.copyWith(kh_sdt: value);
      },
    );
  }


  Future<void> _saveForm(BuildContext context) async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    try {
      final khachhangManage = Provider.of<KhachhangManage>(context, listen: false);
      await khachhangManage.addKhachhang(_newKhachhang);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Thêm mới thành công!', style: TextStyle(fontWeight: FontWeight.w900), textAlign: TextAlign.center,),
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
          content: const Text('Failed to add data', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.red), textAlign: TextAlign.center,),
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
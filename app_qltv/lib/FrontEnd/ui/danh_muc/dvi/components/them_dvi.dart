import 'package:app_qltv/FrontEnd/controller/danhmuc/don_vi_manage.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/donvi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider package

class ThemDonviScreen extends StatefulWidget {
  static const routeName = "/themdonnvi";

  const ThemDonviScreen({Key? key}) : super(key: key);

  @override
  State<ThemDonviScreen> createState() => _ThemDonviScreenState();
}

class _ThemDonviScreenState extends State<ThemDonviScreen> {
  final _formKey = GlobalKey<FormState>();
  late Donvi _newDonvi;
  late Future<List<Donvi>> _donviFuture;
  List<Donvi> _donviList = [];

  @override
  void initState() {
    super.initState();
    _newDonvi = Donvi(
      // dvi_id: '',
      dvi_ten: '',
      dvi_ghichu: '',
      dvi_ten_hd: '',
      dvi_dia_chi_hd: '',
      dvi_sdt: '',
      dvi_ten_gd: '',
      dvi_luu_y: '',
    );
    _loadDonvis();
  }

  Future<void> _loadDonvis() async {
    _donviFuture =
        Provider.of<DonviManage>(context, listen: false).fetchDonvi();
    _donviFuture.then((Donvis) {
      setState(() {
        _donviList = Donvis;
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
              "Thêm Đơn vị",
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
                      child: buildTenDonviField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: buildDiachiField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: buildTenDviHDField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: buildDiachiHDField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: buildSDTField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: buildTenGdField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: buildLuuYField(),
                    ),
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
                  'Thêm Mới',
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

  TextFormField buildTenDonviField() {
    return TextFormField(
      initialValue: _newDonvi.dvi_ten.toString(),
      decoration: const InputDecoration(
        labelText: 'Đơn vị',
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
        _newDonvi = _newDonvi.copyWith(dvi_ten: value);
      },
    );
  }

  TextFormField buildTenGdField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Tên giao dịch',
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
      onSaved: (value) {
        _newDonvi = _newDonvi.copyWith(dvi_ten_gd: value);
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
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 228, 200, 126), width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      autofocus: true,
      onSaved: (value) {
        _newDonvi = _newDonvi.copyWith(dvi_ghichu: value);
      },
    );
  }

  TextFormField buildTenDviHDField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Tên đơn vị hóa đơn',
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
      onSaved: (value) {
        _newDonvi = _newDonvi.copyWith(dvi_ten_hd: value);
      },
    );
  }

  TextFormField buildSDTField() {
    return TextFormField(
      initialValue: _newDonvi.dvi_sdt.toString(),
      decoration: const InputDecoration(
        labelText: 'SĐT',
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
        _newDonvi = _newDonvi.copyWith(dvi_sdt: value);
      },
    );
  }

  TextFormField buildDiachiHDField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Địa chỉ hóa đơn',
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
      onSaved: (value) {
        _newDonvi = _newDonvi.copyWith(dvi_dia_chi_hd: value);
      },
    );
  }

  TextFormField buildLuuYField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Lưu ý',
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
      onSaved: (value) {
        _newDonvi = _newDonvi.copyWith(dvi_luu_y: value);
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
      final donviManager = Provider.of<DonviManage>(context, listen: false);
      await donviManager.addDonvi(_newDonvi);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Thêm mới thành công!',
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
          content: const Text(
            'Failed to add data',
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

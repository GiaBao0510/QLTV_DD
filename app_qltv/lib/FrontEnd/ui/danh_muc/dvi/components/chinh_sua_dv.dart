import 'package:app_qltv/FrontEnd/controller/danhmuc/don_vi_manage.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/donvi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider package

class ChinhSuaDonViScreen extends StatefulWidget {
  static const routeName = "/chinhsuadonvi";

  final Donvi donvi;

  const ChinhSuaDonViScreen({Key? key, required this.donvi}) : super(key: key);

  @override
  State<ChinhSuaDonViScreen> createState() => _ChinhSuaDonViScreenState();
}

class _ChinhSuaDonViScreenState extends State<ChinhSuaDonViScreen> {
  final _editForm = GlobalKey<FormState>();
  late Donvi _editedDonvi;
  late Future<List<Donvi>> _DonviFuture;
  List<Donvi> _DonviList = [];

  @override
  void initState() {
    super.initState();
    _loadDonvi();
    _editedDonvi = widget.donvi;
  }

  Future<void> _loadDonvi() async {
    _DonviFuture =
        Provider.of<DonviManage>(context, listen: false).fetchDonvi();
    _DonviFuture.then((donvi) {
      setState(() {
        _DonviList = donvi;
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
              "Chỉnh Sửa Đơn vị",
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
                      child: buildTieuDeFBField(),
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
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.grey[50]),
                onPressed: () => _saveForm(context),
                child: const Text(
                  'Cập Nhật',
                  style: TextStyle(
                      fontWeight: FontWeight.w900, color: Colors.green),
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
      initialValue: _editedDonvi.dvi_ten.toString(),
      decoration: const InputDecoration(
        labelText: 'Đơn vị',
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
        _editedDonvi = _editedDonvi.copyWith(dvi_ten: value);
      },
    );
  }

  TextFormField buildDiachiField() {
    return TextFormField(
      initialValue: _editedDonvi.dvi_ghichu.toString(),
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
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value';
        }
        return null;
      },
      onSaved: (value) {
        _editedDonvi = _editedDonvi.copyWith(dvi_ghichu: value);
      },
    );
  }

  TextFormField buildTenDviHDField() {
    return TextFormField(
      initialValue: _editedDonvi.dvi_ten_hd.toString(),
      decoration: const InputDecoration(
        labelText: 'Tên đơn vị hóa đơn',
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
        _editedDonvi = _editedDonvi.copyWith(dvi_ten_hd: value);
      },
    );
  }

  TextFormField buildDiachiHDField() {
    return TextFormField(
      initialValue: _editedDonvi.dvi_dia_chi_hd.toString(),
      decoration: const InputDecoration(
        labelText: 'Địa chỉ hóa đơn',
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
        _editedDonvi = _editedDonvi.copyWith(dvi_dia_chi_hd: value);
      },
    );
  }

  TextFormField buildSDTField() {
    return TextFormField(
      initialValue: _editedDonvi.dvi_dia_chi_hd.toString(),
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
      keyboardType: TextInputType.text,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value';
        }
        return null;
      },
      onSaved: (value) {
        _editedDonvi = _editedDonvi.copyWith(dvi_sdt: value);
      },
    );
  }

  TextFormField buildTenGdField() {
    return TextFormField(
      initialValue: _editedDonvi.dvi_ten_gd.toString(),
      decoration: const InputDecoration(
        labelText: 'Tên giao dịch',
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
        _editedDonvi = _editedDonvi.copyWith(dvi_ten_gd: value);
      },
    );
  }

  TextFormField buildTieuDeFBField() {
    return TextFormField(
      initialValue: _editedDonvi.dvi_tde_pban.toString(),
      decoration: const InputDecoration(
        labelText: 'Tiêu đề phiếu bán',
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
        _editedDonvi = _editedDonvi.copyWith(dvi_tde_pban: value);
      },
    );
  }

  TextFormField buildLuuYField() {
    return TextFormField(
      initialValue: _editedDonvi.dvi_luu_y.toString(),
      decoration: const InputDecoration(
        labelText: 'Lưu ý',
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
        _editedDonvi = _editedDonvi.copyWith(dvi_luu_y: value);
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
      final donviManage = Provider.of<DonviManage>(context, listen: false);
      await donviManage.updateDonvi(
          int.parse(_editedDonvi.dvi_id!), _editedDonvi);
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
      Navigator.of(context).pop(true); // Go back to the previous screen
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Failed to update data',
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

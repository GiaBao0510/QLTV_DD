import 'package:app_qltv/FrontEnd/controller/danhmuc/loaivang_manager.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/loaivang.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider package

class ChinhSuaLoaiVangScreen extends StatefulWidget {
  static const routeName = "/chinhsualoaivang";

  final LoaiVang loaiVang;

  const ChinhSuaLoaiVangScreen({Key? key, required this.loaiVang}) : super(key: key);

  @override
  State<ChinhSuaLoaiVangScreen> createState() => _ChinhSuaLoaiVangScreenState();
}

class _ChinhSuaLoaiVangScreenState extends State<ChinhSuaLoaiVangScreen> {
  final _editForm = GlobalKey<FormState>();
  late LoaiVang _editedLoaiVang;
  late Future<List<LoaiVang>> _loaiVangFuture;
  List<LoaiVang> _loaiVangList = [];

  @override
  void initState() {
    super.initState();
    _loadLoaiVanngs();
    _editedLoaiVang = widget.loaiVang; // Initialize _editedLoaiVang with widget's nhomVang
    _editedLoaiVang.copyWith(nhomChaId: widget.loaiVang.nhomChaId);
  }

  Future<void> _loadLoaiVanngs() async {
    _loaiVangFuture = Provider.of<LoaiVangManager>(context, listen: false).fetchLoaiHang();
    _loaiVangFuture.then((loaiVangs) {
      setState(() {
        _loaiVangList = loaiVangs;
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
              child: Text("Chỉnh Sửa Loại Vàng", style: TextStyle(color: Colors.black ,fontWeight: FontWeight.w900), textAlign: TextAlign.center,),
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
                      child: buildLoaiVangField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: buildDonGiaVonField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: buildDonGiaMuaField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: buildDonGiaBanField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: buildDonGiaCamField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: buildGhiChuField(),
                    ),
                    buildLoaiChaDropdown(),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[50]
                ),
                onPressed: () => _saveForm(context),
                child: const Text('Cập Nhật', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.green),),
              ),
            ],
          ),
        ),
      ),
    );
  }


 TextFormField buildLoaiVangField() {
    return TextFormField(
      initialValue: _editedLoaiVang.nhomTen.toString(),
      decoration: const InputDecoration(
        labelText: 'Loại Vàng',
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
        _editedLoaiVang = _editedLoaiVang.copyWith(nhomTen: value);
      },
    );
  }

  TextFormField buildDonGiaVonField() {
    return TextFormField(
      initialValue: _editedLoaiVang.donGiaVon.toString(),
      decoration: const InputDecoration(
        labelText: 'Đơn Giá Vốn',
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
        _editedLoaiVang = _editedLoaiVang.copyWith(donGiaVon: double.parse(value!));
      },
    );
  }


    TextFormField buildDonGiaMuaField() {
    return TextFormField(
      initialValue: _editedLoaiVang.donGiaMua.toString(),
      decoration: const InputDecoration(
        labelText: 'Đơn Giá Vốn',
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
        _editedLoaiVang = _editedLoaiVang.copyWith(donGiaMua: double.parse(value!));
      },
    );
  }

  TextFormField buildDonGiaBanField() {
    return TextFormField(
      initialValue: _editedLoaiVang.donGiaBan.toString(),
      decoration: const InputDecoration(
        labelText: 'Đơn Giá Bán',
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
        _editedLoaiVang = _editedLoaiVang.copyWith(donGiaBan: double.parse(value!));
      },
    );
  }

  TextFormField buildDonGiaCamField() {
    return TextFormField(
      initialValue: _editedLoaiVang.donGiaCam.toString(),
      decoration: const InputDecoration(
        labelText: 'Đơn Giá Cầm',
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
       _editedLoaiVang = _editedLoaiVang.copyWith(donGiaCam: double.parse(value!));
      },
    );
  }

  TextFormField buildGhiChuField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Ghi Chú',
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
        _editedLoaiVang = _editedLoaiVang.copyWith(ghiChu: value);
      },
    );
  }

  DropdownButtonFormField<int> buildLoaiChaDropdown() {
    return DropdownButtonFormField<int>(
      decoration: const InputDecoration(
        labelText: 'Loại Cha',
        labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 15.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
      value: _editedLoaiVang.nhomChaId == 0 ? null : _editedLoaiVang.nhomChaId ,
      items: _loaiVangList.map((LoaiVang loaiHang) {
        return DropdownMenuItem<int>(
          value: int.parse(loaiHang.nhomHangMa!),
          child: Text(loaiHang.nhomTen!),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _editedLoaiVang = _editedLoaiVang.copyWith(nhomChaId: newValue);
        });
      },
      validator: (value) {
        if (value == null || value == 0) {
          return 'Please select a value';
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
      final nhomVangManager = Provider.of<LoaiVangManager>(context, listen: false); 
      await nhomVangManager.updateLoaiVang(int.parse(_editedLoaiVang.nhomHangId!), _editedLoaiVang); 
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
      Navigator.of(context).pop(true); // Go back to the previous screen
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update data: ${error.toString()}', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.red), textAlign: TextAlign.center,),
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

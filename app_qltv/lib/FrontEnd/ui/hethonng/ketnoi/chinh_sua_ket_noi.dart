import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_qltv/FrontEnd/model/hethong/ketnoi.dart';
import 'package:provider/provider.dart';
import 'package:app_qltv/FrontEnd/controller/hethong/ketnoi_manager.dart';

class ChinhSuaKetNoiPage extends StatefulWidget {
  @override
  _ChinhSuaKetNoiPageState createState() => _ChinhSuaKetNoiPageState();
}

class _ChinhSuaKetNoiPageState extends State<ChinhSuaKetNoiPage> {
  final _formKey = GlobalKey<FormState>();
  late KetNoi _currentConfig;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchKetNoi();
  }

  Future<void> _fetchKetNoi() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final ketNoi = await Provider.of<KetnoiManager>(context, listen: false)
          .fetchketnoi();
      setState(() {
        _currentConfig = ketNoi;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showSnackBar(e.toString());
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _updateKetNoi() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<KetnoiManager>(context, listen: false)
            .updateketnoi(context, _currentConfig);
        setState(() {
          _isLoading = false;
        });
        _showSnackBar('Kết nối cơ sở dữ liệu đã được cập nhật thành công');
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        _showSnackBar(e.toString());
      }
    }
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
              "Chỉnh Sửa Kết Nối",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      initialValue: _currentConfig.host,
                      decoration: InputDecoration(labelText: 'Host'),
                      onSaved: (value) =>
                          _currentConfig = _currentConfig.copyWith(host: value),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập host';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _currentConfig.database,
                      decoration: InputDecoration(labelText: 'Database'),
                      onSaved: (value) => _currentConfig =
                          _currentConfig.copyWith(database: value),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập database';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _currentConfig.port,
                      decoration: InputDecoration(labelText: 'Port'),
                      onSaved: (value) =>
                          _currentConfig = _currentConfig.copyWith(port: value),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập port';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _currentConfig.user,
                      decoration: InputDecoration(labelText: 'User'),
                      onSaved: (value) =>
                          _currentConfig = _currentConfig.copyWith(user: value),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập user';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _currentConfig.password,
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Password'),
                      onSaved: (value) => _currentConfig =
                          _currentConfig.copyWith(password: value),
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Vui lòng nhập password';
                      //   }
                      //   return null;
                      // },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 228, 200, 126),
                      ),
                      onPressed: _updateKetNoi,
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
}

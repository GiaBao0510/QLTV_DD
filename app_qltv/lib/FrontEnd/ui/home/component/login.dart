import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:session_manager/session_manager.dart';
import 'package:quickalert/quickalert.dart';

import 'package:app_qltv/FrontEnd/Objects/user-login.dart';
import 'package:app_qltv/main.dart';
import 'package:app_qltv/FrontEnd/constants/config.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      home: const Material(
        child: SafeArea(
          child: Scaffold(
            body: LoginPage(),
          ),
        ),
      ),

      theme: ThemeData(fontFamily: 'Arial'),
      debugShowCheckedModeBanner: false,
    )
  );
}

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage>{
  //Thuôộc tính
  userlogin user = userlogin('', '');
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //Phương thức kiem tra đăng nhập
  Future Login(BuildContext context) async{
    String path = login;
    var res = await http.post(
      Uri.parse(path),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "USER_TEN": user.username,
        "MAT_KHAU": user.password
      })
    );

    print(res.body);
    final thongtinphanhoi = jsonDecode(res.body);
    final value = thongtinphanhoi['value'] as int;  //Bien nay dùng để kiểm tra tài khoản hợp lệ không

    //Đăng nhập thành công
    if(value == 1){
      print('Đăng nhập thành công');
      SessionManager().setString('username', user.username);

      QuickAlert.show(
        context: context,
        type:  QuickAlertType.success,
        title: "Success",
        text: "Đăng nhập thành công!",
        onConfirmBtnTap: () => {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context)=> const MyApp())
          )
        }
      );
    }else if(value == 0){
      print('Mật khẩu sai');
      QuickAlert.show(
          context: context,
          type:  QuickAlertType.error,
          title: "Lỗi",
          text: "Sai mật khẩu",
      );
    }else if(value == -1){
      QuickAlert.show(
        context: context,
        type:  QuickAlertType.error,
        title: "Lỗi",
        text: "Không tìm thấy tài khoản",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [

              //Maàu nền
              Positioned(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff4451fd), Color(0xff3f5efb)],
                          stops: [0.25, 0.75],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        )
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    )
                  )
              ),

              //Khung đăng nhập
              Align(
                alignment: Alignment.center,
                child: Scrollbar(
                  child: ListView(
                    padding:const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    children: <Widget>[
                      const SizedBox(height: 150,),
                      Material(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                          child: Column(
                            children: [
                              //Ảnh
                              Image.asset('assets/images/user.png', width: 110, height: 110,),

                              //BIểu mẫu đăng nhập
                              const SizedBox(height: 30,),
                              Material(
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      //Trường nhập tên ngươi dùng
                                      TextFormField(
                                        controller: TextEditingController(text: user.username),
                                        onChanged: (value){
                                          user.username = value;
                                        },
                                        //Kieemr tra đàu vào
                                        validator: (value){
                                          if(value == null || value.isEmpty){
                                            return 'Vui lòng nhập user-name';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          labelText: 'User name',
                                          prefixIcon: Icon(Icons.account_circle),
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blue, width: 2)
                                          ),
                                          errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.red, width: 1)
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.red, width: 1)
                                          ),
                                        ),
                                      ),

                                      //Trường nhập mâật khẩu
                                      const SizedBox(height: 30,),
                                      TextFormField(
                                        obscureText: true,
                                        controller: TextEditingController(text: user.password),
                                        onChanged: (value){
                                          user.password = value;
                                        },
                                        //Kieemr tra đàu vào
                                        validator: (value){
                                          if(value == null || value.isEmpty){
                                            return 'Vui lòng nhập password';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          labelText: 'Mật khẩu',
                                          prefixIcon: Icon(Icons.lock),
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.blue, width: 2)
                                          ),
                                          errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.red, width: 1)
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.red, width: 1)
                                          ),
                                        ),
                                      ),

                                      //Nút gửi
                                      const SizedBox(height: 30,),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                        child: ElevatedButton(
                                          onPressed: (){
                                            if(_formKey.currentState !=null && _formKey.currentState!.validate()){
                                              print('Điền đầy đủ. > Kiểm tra');
                                              Login(context);

                                            }else{
                                              print('Chưa điền đủ');
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.lightBlue,
                                            foregroundColor: Colors.white,
                                              shadowColor: Colors.black,
                                              elevation: 8.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                              )
                                          ),
                                          child: const Text('Đăng nhập', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,),),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );

  }
}

import 'package:app_qltv/FrontEnd/ui/danh_muc/kho/kho.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/loai_vang/loai_vang.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/nha_cung_cap/nha_cung_cap_green.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/nhom_vang/nhom_vang.dart';
import 'package:app_qltv/FrontEnd/constants/config.dart';
import 'package:app_qltv/FrontEnd/ui/hethonng/nhom/nhom.dart';
import 'package:app_qltv/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:session_manager/session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:session_manager/session_manager.dart';
import 'package:quickalert/quickalert.dart';

// ignore: camel_case_types
class drawer extends StatelessWidget {

  const drawer({
    super.key,
  });

  //Lấy tên người dùng
  Future<String> _getTenAdmin() async{
    return await SessionManager().getString('username');
  }

  //Quyển của ứng dụng  trên thiết bị
  Future<void> _request_permission() async{
    await openAppSettings();
  }

  //Thực hiện đănng xuất
  Future<void> Logout(BuildContext context) async{
    try{
      String path = logout;
      var res = await http.post(Uri.parse(path), headers: {"Content-Type": "application/json"} );
      print(res.body);

      SessionManager().setString('username','');
      SessionManager().setString('password','');

      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: " Đăng xuất thành công",
        onConfirmBtnTap: () => {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyApp() ), // Sử dụng RegisterPage từ tệp tin register.dart
          )
        },
      );
    }catch(e){
      print('Lỗi khi thực hiện đăng xuất: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
           DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                ),
                Expanded(
                  flex: 1,
                    child: Row(
                      children: [
                        Flexible(
                            child: Icon(Icons.account_circle_outlined, size: 35, color: Colors.white,)
                        ),
                        Flexible(
                            child: FutureBuilder<String>(
                                future: _getTenAdmin(),
                                builder: (context, snapshot){
                                  if(snapshot.hasData){
                                    return Text( snapshot.data!, style: TextStyle(color: Colors.white),);
                                  }else if(snapshot.hasError){
                                    return Text('Error: ${snapshot.error}');
                                  }else{
                                    return CircularProgressIndicator();
                                  }
                                }
                            )
                        )
                      ],
                    )
                )
              ],
            ),
          ),
          ExpansionTile(
            leading: const Icon(CupertinoIcons.settings),
            title: const Text('Danh Mục'),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Khoảng cách thụt lề
                child: ListTile(
                  leading: const Icon(CupertinoIcons.settings),
                  title: const Text('Loại Vàng'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoaiVangScreen()),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Khoảng cách thụt lề
                child: ListTile(
                  leading: const Icon(CupertinoIcons.settings),
                  title: const Text('Nhóm Vàng'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NhomVangScreen()),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Khoảng cách thụt lề
                child: ListTile(
                  leading: const Icon(CupertinoIcons.settings),
                  title: const Text('Hàng Hóa'),
                  onTap: () {
                    // Handle Hàng Hóa tap
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Khoảng cách thụt lề
                child: ListTile(
                  leading: const Icon(CupertinoIcons.settings),
                  title: const Text('Kho'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const KhoScreen()),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Khoảng cách thụt lề
                child: ListTile(
                  leading: const Icon(CupertinoIcons.settings),
                  title: const Text('NCC'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NhaCungCapScreen()),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Khoảng cách thụt lề
                child: ListTile(
                  leading: const Icon(CupertinoIcons.settings),
                  title: const Text('Khách Hàng'),
                  onTap: () {
                    // Handle Khách Hàng tap
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Khoảng cách thụt lề
                child: ListTile(
                  leading: const Icon(CupertinoIcons.settings),
                  title: const Text('Đơn Vị'),
                  onTap: () {
                    // Handle Đơn Vị tap
                  },
                ),
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(CupertinoIcons.bell),
            title: const Text('Hệ Thống'),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Khoảng cách thụt lề
                child: ListTile(
                  leading: const Icon(CupertinoIcons.bell),
                  title: const Text('Nhóm Người Dùng'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NhomPage()),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Khoảng cách thụt lề
                child: ListTile(
                  leading: const Icon(CupertinoIcons.bell),
                  title: const Text('Người Dùng'),
                  onTap: () {
                    // Handle Người Dùng tap
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Khoảng cách thụt lề
                child: ListTile(
                  leading: const Icon(CupertinoIcons.bell),
                  title: const Text('Kết Nối'),
                  onTap: () {
                    // Handle Kết Nối tap
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Khoảng cách thụt lề
                child: ListTile(
                  leading: const Icon(CupertinoIcons.bell),
                  title: const Text('Quản lý quyền'),
                  onTap: () {
                    _request_permission();
                  },
                ),
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(CupertinoIcons.bell),
            title: const Text('Báo Cáo'),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Khoảng cách thụt lề
                child: ListTile(
                  leading: const Icon(CupertinoIcons.bell),
                  title: const Text('Báo Cáo Phiếu Xuất'),
                  onTap: () {
                    // Handle Báo Cáo Phiếu Xuất tap
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Khoảng cách thụt lề
                child: ListTile(
                  leading: const Icon(CupertinoIcons.bell),
                  title: const Text('Báo Cáo Tồn Kho Loại Vàng'),
                  onTap: () {
                    // Handle Báo Cáo Tồn Kho Loại Vàng tap
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Khoảng cách thụt lề
                child: ListTile(
                  leading: const Icon(CupertinoIcons.bell),
                  title: const Text('Báo Cáo Tồn Kho Vàng'),
                  onTap: () {
                    // Handle Báo Cáo Tồn Kho Loại Vàng tap
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Khoảng cách thụt lề
                child: ListTile(
                  leading: const Icon(CupertinoIcons.bell),
                  title: const Text('Báo Cáo Tồn Kho Vàng'),
                  onTap: () {
                    // Handle Báo Cáo Tồn Kho Loại Vàng tap
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Khoảng cách thụt lề
                child: ListTile(
                  leading: const Icon(CupertinoIcons.bell),
                  title: const Text('Báo Cáo Tồn Theo Nhóm Vàng'),
                  onTap: () {
                    // Handle Báo Cáo Tồn Kho Loại Vàng tap
                  },
                ),
              ),
            ],
          ),

          //Nút đăng xuất
          const SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              onPressed: (){
                print('Đã bấm đăng xuất');
                Logout(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  shadowColor: Colors.black,
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )
              ),
              child: const Row(
                children: const [
                  Expanded(
                    flex:2,
                      child: Text('Đăng xuất', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'Align' ),),
                  ),
                  Expanded(
                      flex:1,
                      child: Icon(Icons.logout)
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

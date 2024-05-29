import 'package:app_qltv/FrontEnd/controller/hethong/nguoidung_manager.dart';
import 'package:app_qltv/FrontEnd/model/hethong/nguoidung.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NguoiDungPage extends StatefulWidget{
  static const routeName = "/nguoidung";

  const NguoiDungPage({super.key});

  @override
  _NguoiDungPageState createState() => _NguoiDungPageState();
}

class _NguoiDungPageState extends State<NguoiDungPage>{

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
        title: Row(
          children: [
            Expanded(child: Container()), // Spacer
            const Text("Người Dùng", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900)),
            Expanded(child: Container()), // Spacer
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              onPressed: () async {
                // final result = await Navigator.of(context).push(
                //   createRoute((context) => const ThemNhomScreen()),
                // );
                // if (result == true) {
                //   _loadNhom(); // Refresh the list when receiving the result
                // }
              },
              icon: const Icon(CupertinoIcons.add),
            ),
          ),
        ],
      ),
      body: Consumer<NguoiDungManager>(
        builder: (context, nguoidungmanager, child) {
          if(nguoidungmanager.nguoiDungs.isEmpty){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return ListView.builder(
              itemCount: nguoidungmanager.nguoiDungsLength,
              itemBuilder: (context, index) {
                NguoiDung nguoidung = nguoidungmanager.nguoiDungs[index];
                return ListTile(

                )
              },
            );
          }
        }
      )
    );
  }
}
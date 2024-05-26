import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quickalert/quickalert.dart';
import 'package:app_qltv/main.dart';
import  'package:app_qltv/FrontEnd/Service/ThuVien.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: InterfaceConnectionError(),
        ),
      ),
      theme: ThemeData(
          fontFamily: 'Times New Roman'
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class InterfaceConnectionError extends StatefulWidget{
  static const routerName = '/notInternet';
  @override
  State<StatefulWidget> createState() {
   return _InterfaceConnectionError();
  }
}

class _InterfaceConnectionError extends State<InterfaceConnectionError>{
  //Hàm khơi tạo
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Stack(
           children: [
              //Bao quát taon trang
             Positioned(
                 child: Container(
                   decoration: BoxDecoration(
                       gradient: LinearGradient(
                         colors: [Color(0xff334d50), Color(0xff0f0f0f)],
                         stops: [0, 1],
                         begin: Alignment.topLeft,
                         end: Alignment.bottomRight,
                       )
                   ),
                   child: SizedBox(
                     width: MediaQuery.of(context).size.width,
                     height: MediaQuery.of(context).size.height,
                   ),
                 ),
             ),

             Align(
               alignment: Alignment.center,
               child: Column(
                 children: [
                   SizedBox(height: 180,),
                   Flexible(
                       child: Container(
                         child: FractionallySizedBox(
                           widthFactor: 1,
                           heightFactor: 1.5,
                           child: Lottie.asset(
                             'assets/animation/InternetLost.json',
                             repeat: true,
                             fit: BoxFit.contain
                           ),
                         ),
                       )
                   ),
                   SizedBox(height: 20,),
                   Flexible(
                     child: Text(
                       'Không có kết nối \nInternet.',
                       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                       textAlign: TextAlign.center,
                     )
                   ),

                   SizedBox(height: 10,),
                   Flexible(
                       child: TextButton(
                         onPressed: () async{
                           bool result =  await ActiveConnection();
                           if(result == false){
                             QuickAlert.show(
                               context: context,
                               type: QuickAlertType.warning,
                               title: "Error",
                               text: " Không kết nối được mạng",
                             );
                           }else{
                             Navigator.pushReplacement(
                               context,
                               MaterialPageRoute(builder: (context) => MyApp() ),
                             );
                           }
                         },
                         child: Container(
                           decoration: BoxDecoration(
                               color: Colors.blue,
                             borderRadius: BorderRadius.circular(10)
                           ),
                           padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                           child: Text(' Thử lại ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                         ),
                       )
                   ),
                 ],
               ),
             ),
           ],
          )
        )
    );
  }
}
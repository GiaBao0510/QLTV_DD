import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:app_qltv/main.dart';

class Interfaceerror500 extends StatefulWidget {
  static const routerName = 'errorserver';
  final String EroRecordedinText;

  const Interfaceerror500({
    super.key,
    required this.EroRecordedinText
  });

  @override
  State<Interfaceerror500> createState() => _Interfaceerror500State(EroRecordedinTextState: EroRecordedinText);
}

class _Interfaceerror500State extends State<Interfaceerror500> {
  final String EroRecordedinTextState;

  _Interfaceerror500State({required this.EroRecordedinTextState});

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
                        colors: [Color(0xfff5001d), Color(0xff6b0f05)],
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
                            heightFactor: 2,
                            child: Lottie.asset(
                                'assets/animation/Error500.json',
                                repeat: true,
                                fit: BoxFit.contain
                            ),
                          ),
                        )
                    ),
                    SizedBox(height: 30,),
                    Flexible(
                        child: Text(
                          'Lỗi máy chủ nội bộ.',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                          textAlign: TextAlign.center,
                        )
                    ),

                    SizedBox(height: 10,),
                    Flexible(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => MyApp() ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            child: Text(' Thử lại ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                          ),
                        )
                    ),

                    //Hiển thị nội dung lỗi
                    SizedBox(height: 40,),
                    Flexible(
                      child: FractionallySizedBox(
                        heightFactor: 1.1,
                        child: Container(
                          margin:const  EdgeInsets.fromLTRB(15, 0, 15, 0),
                          padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          child:  Text('$EroRecordedinTextState')
                        ),
                      )
                    )

                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:app_qltv/main.dart';

class Loadinginterface extends StatefulWidget {
  static const routeName = 'loadinginterface';
  const Loadinginterface({super.key});

  @override
  State<Loadinginterface> createState() => _LoadinginterfaceState();
}

class _LoadinginterfaceState extends State<Loadinginterface> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              //Bao quát taon trang
              Positioned(
                child: Container(
                  decoration: const BoxDecoration(
                      gradient:LinearGradient(
                        colors: [Color(0xff333333), Color(0xff000000)],
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

              //Loading
              Align(
                alignment: Alignment.center,
                child: FractionallySizedBox(
                  child: Lottie.asset(
                    'assets/animation/Loading.json',
                    repeat: true,
                    fit: BoxFit.contain
                  ),
                ),
              )

            ],
          ),
        )
    );
  }
}
//CircularProgressIndicator()
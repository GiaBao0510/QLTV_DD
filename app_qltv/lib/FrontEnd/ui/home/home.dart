
import 'package:app_qltv/FrontEnd/ui/home/component/drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bao Khoa Gold' , style: TextStyle(color: Colors.black ,fontWeight: FontWeight.w900 ),),
      ),
      drawer: const drawer(),
    );
  }
}
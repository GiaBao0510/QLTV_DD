import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search_Bar extends StatelessWidget {
  const Search_Bar({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.0,
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          labelText: 'Tìm kiếm',
          labelStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(CupertinoIcons.search, color: Colors.grey,),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(94, 158, 158, 158), width: 1.0), // Viền màu xám
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(94, 158, 158, 158), width: 1.0), // Viền màu xám khi enabled
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0), // Viền màu xám khi focused
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0), 
        ),
      ),
    );
  }
}

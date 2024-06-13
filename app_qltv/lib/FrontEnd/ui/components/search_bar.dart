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
          prefixIcon: Icon(
            CupertinoIcons.search,
            color: Color.fromARGB(255, 228, 200, 126),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(255, 228, 200, 126),
                width: 2.0), // Viền màu xám
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(255, 228, 200, 126),
                width: 2.0), // Viền màu xám khi enabled
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(255, 228, 200, 126),
                width: 3.0), // Viền màu xám khi focused
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        ),
      ),
    );
  }
}

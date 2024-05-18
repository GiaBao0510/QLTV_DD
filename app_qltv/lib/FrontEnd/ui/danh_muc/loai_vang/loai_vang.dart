
// import 'package:app_qltv/FrontEnd/model/danhmuc/loaivang.dart';
// import 'package:app_qltv/FrontEnd/controller/danhmuc/loaivang_manager.dart';
// import 'package:app_qltv/FrontEnd/ui/components/transitions.dart';
// import 'package:app_qltv/FrontEnd/ui/danh_muc/loai_vang/components/chi_tiet_loai_vang.dart';
// import 'package:app_qltv/FrontEnd/ui/danh_muc/loai_vang/components/them_loai_vang.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// // ignore: camel_case_types
// class LoaiVangScreen extends StatefulWidget {
//   static const routeName = "/loaivang";

//   const LoaiVangScreen({Key? key}) : super(key: key);
//   @override
//   State<LoaiVangScreen> createState() => _LoaiVangScreenState();
// }
// class _LoaiVangScreenState extends State<LoaiVangScreen> {
//   late Future<List<LoaiVang>> _loaiVangFuture;
//   final TextEditingController _searchController = TextEditingController();
//   List<LoaiVang> _filteredLoaiVangList = [];
//   List<LoaiVang> _LoaiVangList = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadLoaiVangs();
//     _searchController.addListener(_filterLoaiVangs);
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   Future<void> _loadLoaiVangs() async {
//     _loaiVangFuture = Provider.of<LoaiVangManager>(context, listen: false).fetchLoaiHang();
//     _loaiVangFuture.then((LoaiVangs) {
//       setState(() {
//         _LoaiVangList = LoaiVangs;
//         _filteredLoaiVangList = LoaiVangs;
//       });
//     });
//   }

//   void _filterLoaiVangs() {
//     final query = _searchController.text.toLowerCase();
//     setState(() {
//       _filteredLoaiVangList = _LoaiVangList.where((LoaiVang) {
//         return LoaiVang.loaiTen!.toLowerCase().contains(query);
//       }).toList();
//     });
//   }



//     @override
//   Widget build(BuildContext context) {
//     // Lấy danh sách các mục từ LoaiVangManager
//     final List<LoaiVang> items = LoaiVangManager().items;

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(
//             CupertinoIcons.left_chevron,
//             color: Colors.black,
//           ),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         title: Row(
//           children: [
//             Expanded(child: Container()), // Spacer
//             const Text("Loại Vàng", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900)),
//             Expanded(child: Container()), // Spacer
//           ],
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 12.0),
//             child: IconButton(
//               onPressed: () async {
//                 final result = await Navigator.of(context).push(
//                   createRoute((context) => const ThemLoaiVangScreen()),
//                 );
//                 if (result == true) {
//                   _loadLoaiVangs(); 
//                 }
//               },
//               icon: const Icon(CupertinoIcons.add),
//             ),
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: ListView.builder(
//           itemCount: items.length,
//           itemBuilder: (BuildContext context, int index) {
//             // Hiển thị thông tin của mỗi đối tượng LoaiVang trong danh sách
//             return ListTile(
//               title: Text(items[index].nhomTen ?? ''),
//               // subtitle: Text("Đơn giá mua: ${items[index].donGiaMua}"),
//               // Xử lý sự kiện khi nhấn vào một mục
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ChiTietLoaiVangScreen(loaiVang: items[index]),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
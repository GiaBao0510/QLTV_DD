import 'package:app_qltv/FrontEnd/controller/danhmuc/nhacungcap_manager.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/nhacungcap.dart';
import 'package:app_qltv/FrontEnd/ui/components/search_bar.dart';
import 'package:app_qltv/FrontEnd/ui/components/transitions.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/nha_cung_cap/components/chinh_sua_nha_cung_cap.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/nha_cung_cap/components/them_nha_cung_cap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NhaCungCapScreen extends StatefulWidget {
  static const routeName = "/nhacungcap";

  const NhaCungCapScreen({Key? key}) : super(key: key);

  @override
  _NhaCungCapScreenState createState() => _NhaCungCapScreenState();
}

class _NhaCungCapScreenState extends State<NhaCungCapScreen> {
  late Future<List<NhaCungCap>> _nhaCungCapFuture;
  final TextEditingController _searchController = TextEditingController();
  List<NhaCungCap> _filteredNhaCungCapList = [];
  List<NhaCungCap> _nhaCungCapList = [];

  @override
  void initState() {
    super.initState();
    _loadNhaCungCaps();
    _searchController.addListener(_filterNhaCungCaps);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadNhaCungCaps() async {
    _nhaCungCapFuture = Provider.of<NhaCungCapManager>(context, listen: false).fetchNhaCungCap();
    _nhaCungCapFuture.then((nhaCungCaps) {
      setState(() {
        _nhaCungCapList = nhaCungCaps;
        _filteredNhaCungCapList = nhaCungCaps;
      });
    });
  }

  void _filterNhaCungCaps() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredNhaCungCapList = _nhaCungCapList.where((nhaCungCap) {
        return nhaCungCap.ncc_ten!.toLowerCase().contains(query);
      }).toList();
    });
  }

  String formatDate(String? date) {
    if (date == null) return '';
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

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
            const Text("Nhà Cung Cấp", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900)),
            Expanded(child: Container()), // Spacer
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  createRoute((context) => ThemNhaCungCapScreen()),
                );
                if (result == true) {
                  _loadNhaCungCaps(); // Refresh the list when receiving the result
                }
              },
              icon: const Icon(CupertinoIcons.add),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView( // SingleChildScrollView for scrolling
            child: Column(
              children: [
                Search_Bar(searchController: _searchController),
                const SizedBox(height: 12.0),
                ShowList(),
              ],
            ),
          ),
        ),
      ),
    );
  }


  // ignore: non_constant_identifier_names
  FutureBuilder<List<NhaCungCap>> ShowList() {
    return FutureBuilder<List<NhaCungCap>>(
      future: _nhaCungCapFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return ListView.builder(
            shrinkWrap: true, // shrinkWrap to make ListView fit within Column
            physics: NeverScrollableScrollPhysics(), // Disable ListView's own scrolling
            itemCount: _filteredNhaCungCapList.length,
            reverse: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(50, 169, 169, 169),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  title: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  _filteredNhaCungCapList[index].ncc_ten ?? '',
                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              editMethod(context, index),
                              const SizedBox(width: 10),
                              deleteMethod(context, index),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Loại mã: ${_filteredNhaCungCapList[index].ncc_ma}",
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Ngày bắt đầu: ${formatDate(_filteredNhaCungCapList[index].ngay_bd)}",
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Tooltip(
                              message: _filteredNhaCungCapList[index].ghi_chu ?? '',
                              child: Text(
                                "Địa chỉ: ${_filteredNhaCungCapList[index].ghi_chu}",
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  GestureDetector editMethod(BuildContext context, int index) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.of(context).push(
          createRoute(
            (context) => ChinhSuaNhaCungCapScreen(nhacungcap: _filteredNhaCungCapList[index]),
          ),
        );
        if (result == true) {
          _loadNhaCungCaps(); // Refresh the list when receiving the result
        }
      },
      child: const Icon(
        CupertinoIcons.pencil_circle,
        color: Colors.black,
      ),
    );
  }

  GestureDetector deleteMethod(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Xác nhận"),
              content: Text("Bạn có chắc chắn muốn xóa nhà cung cấp ${_filteredNhaCungCapList[index].ncc_ten?.toUpperCase()}?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text("Hủy"),
                ),
                TextButton(
                  onPressed: () async {
                    final nhaCungCapManager = Provider.of<NhaCungCapManager>(context, listen: false);
                    await nhaCungCapManager.deleteNhaCungCap(_filteredNhaCungCapList[index].ncc_id!); // Use `ncc_id` directly
                    Navigator.of(context).pop(); // Close the dialog
                    _loadNhaCungCaps(); // Refresh the list
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Xóa thành công!', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.red), textAlign: TextAlign.center,),
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: const BorderSide(color: Colors.grey, width: 2.0), // bo viền 15px
                        ),
                        behavior: SnackBarBehavior.floating, // hiển thị ở cách đáy màn hình
                        margin: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0), // cách 2 cạnh và đáy màn hình 15px
                      ),
                    );
                  },
                  child: const Text("Xóa"),
                ),
              ],
            );
          },
        );
      },
      child: const Icon(
        CupertinoIcons.delete_solid,
        color: Colors.black,
      ),
    );
  }


}

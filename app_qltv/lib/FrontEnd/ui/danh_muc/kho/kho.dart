import 'package:app_qltv/FrontEnd/model/danhmuc/kho.dart';
import 'package:app_qltv/FrontEnd/controller/danhmuc/kho_manage.dart';
import 'package:app_qltv/FrontEnd/ui/components/search_bar.dart';
import 'package:app_qltv/FrontEnd/ui/components/transitions.dart';
// import 'package:app_qltv/FrontEnd/ui/danh_muc/kho/components/chi_tiet_kho.dart';
import 'package:app_qltv/FrontEnd/ui/danh_muc/kho/components/chinh_sua_kho.dart';
// import 'package:app_qltv/FrontEnd/ui/danh_muc/nhom_vang/components/chinh_sua_loai_vang.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class KhoScreen extends StatefulWidget {
  static const routeName = "/khohang";

  const KhoScreen({Key? key}) : super(key: key);

  @override
  _KhoScreenState createState() => _KhoScreenState();
}

class _KhoScreenState extends State<KhoScreen> {
  late Future<List<Kho>> _khoFuture;
  final TextEditingController _searchController = TextEditingController();
  List<Kho> _filteredKhoList = [];
  List<Kho> _khoList = [];

  @override
  void initState() {
    super.initState();
    _loadKho();
    _searchController.addListener(_filterKho);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadKho() async {
    _khoFuture = Provider.of<KhoManage>(context, listen: false).fetchKho();
    _khoFuture.then((khos) {
      setState(() {
        _khoList = khos;
        _filteredKhoList = khos;
      });
    });
  }

  void _filterKho() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredKhoList = _khoList.where((kho) {
        return kho.kho_ten!.toLowerCase().contains(query);
      }).toList();
    });
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
            const Text("Kho", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900)),
            Expanded(child: Container()), // Spacer
          ],
        ),
       
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
  FutureBuilder<List<Kho>> ShowList() {
    return FutureBuilder<List<Kho>>(
      future: _khoFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return ListView.builder(
            shrinkWrap: true, // shrinkWrap to make ListView fit within Column
            physics: NeverScrollableScrollPhysics(), // Disable ListView's own scrolling
            itemCount: _filteredKhoList.length,
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
                                  _filteredKhoList[index].kho_ten ?? '',
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
                            "Mã: ${_filteredKhoList[index].kho_ma}",
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14),
                          ),
                        ],
                      ),
                    ]
                  ),
                ),
              );
            },
          );
        }
      },
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
              content: Text("Bạn có chắc chắn muốn xóa kho ${_filteredKhoList[index].kho_ten?.toUpperCase()}?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text("Hủy"),
                ),
                TextButton(
                  onPressed: () async {
                    final khoManager = Provider.of<KhoManage>(context, listen: false);
                    await khoManager.deleteKho(int.parse(_filteredKhoList[index].kho_id!)); 
                    Navigator.of(context).pop(); // Close the dialog
                    _loadKho(); // Refresh the list
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

  GestureDetector editMethod(BuildContext context, int index) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.of(context).push(
          createRoute(
            (context) => ChinhSuakhoScreen(kho: _filteredKhoList[index]),
          ),
        );
        if (result == true) {
          _loadKho(); // Refresh the list when receiving the result
        }
      },
      child: const Icon(
        CupertinoIcons.pencil_circle,
        color: Colors.black,
      ),
    );
  }



}

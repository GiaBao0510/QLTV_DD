import 'package:app_qltv/FrontEnd/controller/hethong/nguoidung_manager.dart';
import 'package:app_qltv/FrontEnd/model/hethong/nguoidung.dart';
import 'package:app_qltv/FrontEnd/ui/components/search_bar.dart';
import 'package:app_qltv/FrontEnd/ui/components/transitions.dart';
import 'package:app_qltv/FrontEnd/ui/hethonng/nguoidung/chinh_sua_nguoi_dung.dart';
import 'package:app_qltv/FrontEnd/ui/hethonng/nguoidung/them_nguoi_dung.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_qltv/FrontEnd/ui/components/FormatCurrency.dart';
class NguoiDungPage extends StatefulWidget {
  static const routeName = "/nguoidung";

  const NguoiDungPage({Key? key}) : super(key: key);

  @override
  _NguoiDungPageState createState() => _NguoiDungPageState();
}
class _NguoiDungPageState extends State<NguoiDungPage> {
  late Future<List<NguoiDung>> _nguoidungFuture;
  final TextEditingController _searchController = TextEditingController();
  List<NguoiDung> _nhomList = [];
  List<NguoiDung> _filteredNhomList = [];

  int _currentPage = 1;
  int _pageSize = 10;
  int _totalRows = 0;
  int _totalNguoiDung = 0;
  int _totalNguoiDungBiKhoa = 0;
  int _totalNguoiDungSuDung = 0;

  @override
  void initState() {
    super.initState();
    _loadNguoiDung();
    _searchController.addListener(_filterNguoidung);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadNguoiDung({int page = 1}) async {
    final maneger = Provider.of<NguoiDungManager>(context, listen: false);
       _nguoidungFuture = maneger.fetchNguoiDungs(page: page, pageSize: _pageSize);
    _nguoidungFuture.then((nhoms) {
      setState(() {
        _nhomList = nhoms;
        _filteredNhomList = nhoms;
        _currentPage = page;

        _totalRows = maneger.totalRows;
        //_totalNguoiDung = _nhomList.length;
        _totalNguoiDungBiKhoa = _nhomList.where((nhom) => nhom.biKhoa!).length;
        _totalNguoiDungSuDung = _totalRows - _totalNguoiDungBiKhoa;
        
      });
    });
  }

  void _filterNguoidung() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredNhomList = _nhomList.where((nhom) {
        return nhom.userTen!.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 228, 200, 126),
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
            const Text("Người Dùng",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w900)),
            Expanded(child: Container()), // Spacer
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  createRoute((context) => const ThemNguoiDungScreen()),
                );
                if (result == true) {
                  _loadNguoiDung(page: _currentPage); // Refresh the list
                }
              },
              icon: const Icon(CupertinoIcons.add),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Search_Bar(searchController: _searchController),
                const SizedBox(height: 12.0),
                _buildList(),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: _currentPage > 1,
                      child: ElevatedButton(
                        onPressed: () {
                          _loadNguoiDung(page: _currentPage - 1);
                        },
                        child: const Text("Trang trước"),
                      ),
                    ),
                    Visibility(
                      visible: _currentPage <
                          Provider.of<NguoiDungManager>(context, listen: false)
                              .totalPages,
                      child: ElevatedButton(
                        onPressed: () {
                          _loadNguoiDung(page: _currentPage + 1);
                        },
                        child: const Text("Trang kế tiếp"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 200,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                  color: Color.fromARGB(255, 228, 200, 126),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Tổng Quan',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 20)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: tableTotal({
                          'total': _totalRows.toDouble(),
                          'locked': _totalNguoiDungBiKhoa.toDouble(),
                          'active': _totalNguoiDungSuDung.toDouble(),
                        }),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        backgroundColor: Colors.white,
        tooltip: 'Show Bottom Sheet',
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/list.png'),
        ),
      ),
    
    );
  }

  FutureBuilder<List<NguoiDung>> _buildList() {
    return FutureBuilder<List<NguoiDung>>(
      future: _nguoidungFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _filteredNhomList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 228, 200, 126),
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
                                  _filteredNhomList[index].userTen ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              editMethod(context, index),
                              const SizedBox(width: 10),
                              _deleteMethod(context, index),
                            ],
                          ),
                        ],
                      ),
                       Row(
                        children: [
                          Text(
                            "Mã: ${_filteredNhomList[index].userMa}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Sử dụng: ${_filteredNhomList[index].suDung}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Lý do khóa: ${_filteredNhomList[index].lyDoKhoa}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Nhóm người dùng: ${_filteredNhomList[index].groupId}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
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
            (context) =>
                ChinhSuaNguoiDungScreen(nguoiDung: _filteredNhomList[index]),
          ),
        );
        if (result == true) {
          _loadNguoiDung(); // Refresh the list when receiving the result
        }
      },
      child: const Icon(
        CupertinoIcons.pencil_circle,
        color: Colors.black,
      ),
    );
  }

  GestureDetector _deleteMethod(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Xác nhận"),
              content: Text(
                "Bạn có chắc chắn muốn xóa người dùng ${_filteredNhomList[index].userTen?.toUpperCase()}?",
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text("Hủy"),
                ),
                TextButton(
                  onPressed: () async {
                    final nguoidungManager = Provider.of<NguoiDungManager>(context, listen: false);
                    await nguoidungManager.deleteNguoiDung(_filteredNhomList[index].userId!);
                    Navigator.of(context).pop(); // Close the dialog
                    _loadNguoiDung(page: _currentPage); // Refresh the list
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          'Xóa thành công!',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.red,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: const BorderSide(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                          bottom: 15.0,
                        ),
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

  Table tableTotal(Map<String, double> total) {
    return Table(
      border: TableBorder.all(color: Colors.grey),
      children: [
        const TableRow(
          decoration: BoxDecoration(
            color: Color.fromARGB(150, 218, 218, 218),
          ),
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Tổng người dùng',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Tổng người dùng bị khóa',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Người dùng đang sử dụng',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${total['total']?.toInt() ?? 0}'),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${total['locked']?.toInt() ?? 0}'),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${total['active']?.toInt() ?? 0}'),
              ),
            ),
          ],
        ),
        
      ],
    );
  }
}

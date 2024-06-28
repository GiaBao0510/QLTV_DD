import 'package:app_qltv/FrontEnd/controller/HoaDonBanRa/HoaDonMBManager.dart';
import 'package:app_qltv/FrontEnd/ui/HoaDonBanRa/ChiTietHoaDonMatBaoScreen.dart';
import 'package:app_qltv/FrontEnd/ui/components/search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DanhSachHoaDonMBScreen extends StatefulWidget {
  static const routeName = "/danhSachHoaDonMBScreen";

  const DanhSachHoaDonMBScreen({Key? key}) : super(key: key);

  @override
  _DanhSachHoaDonMBScreen createState() => _DanhSachHoaDonMBScreen();
}

class _DanhSachHoaDonMBScreen extends State<DanhSachHoaDonMBScreen> {
  late Future<List<HoaDonMatBao>> _hoaDonFuture;
  final TextEditingController _searchController = TextEditingController();
  List<HoaDonMatBao> _hoaDonList = [];
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadDanhSachHoaDon();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadDanhSachHoaDon() async {
    String formattedStartDate = DateFormat('yyyy-MM-dd').format(_startDate);
    String formattedEndDate = DateFormat('yyyy-MM-dd').format(_endDate);
    _hoaDonFuture = Provider.of<HoaDonMatBaoManager>(context, listen: false)
        .fetchDanhSachHoaDonMB(
            dateStart: formattedStartDate, dateEnd: formattedEndDate);
    _hoaDonFuture.then((hoaDon) {
      setState(() {
        _hoaDonList = hoaDon;
      });
    });
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020, 1),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
    print('_startDate');
    print(_startDate.toString());
    _loadDanhSachHoaDon();
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
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Danh Sách Hóa Đơn",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w900)),
            SizedBox(
              width: 50,
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          //child: SingleChildScrollView(
          // SingleChildScrollView for scrolling
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _startDate == null
                          ? 'Chọn ngày bắt đầu'
                          : DateFormat('dd/MM/yyyy').format(_startDate!),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      _endDate == null
                          ? 'Chọn ngày kết thúc'
                          : DateFormat('dd/MM/yyyy').format(_endDate!),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.date_range),
                    onPressed: () {
                      _selectDateRange(context);
                    },
                  ),
                ],
              ),
              // Search_Bar(searchController: _searchController),
              const SizedBox(height: 12.0),
              Expanded(
                child: SingleChildScrollView(child: ShowList()),
              ),
              const SizedBox(height: 12.0),
            ],
          ),
        ),
      ),
      //   ),
    );
  }

  //ignore: non_constant_identifier_names
  FutureBuilder<List<HoaDonMatBao>> ShowList() {
    return FutureBuilder<List<HoaDonMatBao>>(
      future: _hoaDonFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return ListView.builder(
            shrinkWrap: true, // shrinkWrap to make ListView fit within Column
            physics:
                const NeverScrollableScrollPhysics(), // Disable ListView's own scrolling
            itemCount: _hoaDonList.length,
            reverse: false,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 228, 200, 126),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _hoaDonList[index].no.toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 20),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ChiTietHoaDonMatBaoScreen(
                                  hoaDonMatBao: _hoaDonList[index],
                                ),
                              ),
                            );
                          },
                          child: const Icon(
                            CupertinoIcons.right_chevron,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}

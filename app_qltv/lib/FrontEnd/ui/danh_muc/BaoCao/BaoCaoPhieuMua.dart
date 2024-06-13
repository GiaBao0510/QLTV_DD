import 'package:app_qltv/FrontEnd/controller/danhmuc/BaoCaoPhieuMua_maneger.dart';
import 'package:app_qltv/FrontEnd/model/danhmuc/BaoCaoPhieuMua.dart';
import 'package:app_qltv/FrontEnd/ui/components/FormatCurrency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_qltv/FrontEnd/ui/components/search_bar.dart';
import 'package:intl/intl.dart'; // Để định dạng ngày

class BaoCaoPhieuMuaScreen extends StatefulWidget {
  static const routeName = "/baocaophieumua";

  const BaoCaoPhieuMuaScreen({Key? key}) : super(key: key);

  @override
  _BaoCaoPhieuMuaScreenState createState() => _BaoCaoPhieuMuaScreenState();
}

class _BaoCaoPhieuMuaScreenState extends State<BaoCaoPhieuMuaScreen> {
  late Future<List<BaoCaoPhieuMua>> _BaoCaoPhieuMuaFuture;
  final TextEditingController _searchController = TextEditingController();
  List<BaoCaoPhieuMua> _filteredBaoCaoPhieuMuaList = [];
  List<BaoCaoPhieuMua> _BaoCaoPhieuMuaList = [];

  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _loadBaoCaoPhieuMua();
    _searchController.addListener(_filterBaoCaoPhieuMua);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadBaoCaoPhieuMua() async {
    _BaoCaoPhieuMuaFuture =
        Provider.of<BaocaophieumuaManeger>(context, listen: false)
            .fecthbaoCaoPhieuMua();
    _BaoCaoPhieuMuaFuture.then((baoCaoPhieuMua) {
      setState(() {
        _BaoCaoPhieuMuaList = baoCaoPhieuMua;
        _filteredBaoCaoPhieuMuaList = baoCaoPhieuMua;
      });
    });
  }

  void _filterBaoCaoPhieuMua() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredBaoCaoPhieuMuaList = _BaoCaoPhieuMuaList.where((phieumua) {
        final inDateRange = (_startDate == null || _endDate == null) ||
            (phieumua.ngayPhieu != null &&
                DateTime.parse(phieumua.ngayPhieu!).isAfter(_startDate!.subtract(Duration(days: 1))) &&
                DateTime.parse(phieumua.ngayPhieu!).isBefore(_endDate!.add(Duration(days: 1))));
        final matchesQuery = phieumua.hangHoaTen!.toLowerCase().contains(query);

        return inDateRange && matchesQuery;
      }).toList();
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
        _filterBaoCaoPhieuMua();
      });
    }
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
          title: const FittedBox(
            fit: BoxFit.fitWidth,
            child: Text("Báo Cáo Phiếu Mua",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w900)),
          )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
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
              Search_Bar(searchController: _searchController),
              const SizedBox(height: 12.0),
              Expanded(
                child: ShowList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<List<BaoCaoPhieuMua>> ShowList() {
    return FutureBuilder<List<BaoCaoPhieuMua>>(
      future: _BaoCaoPhieuMuaFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return ListView.builder(
            itemCount: _filteredBaoCaoPhieuMuaList.length,
            itemBuilder: (context, index) {
              final phieumua = _filteredBaoCaoPhieuMuaList[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 228, 200, 126),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    ExpansionTile(
                      title: Text(
                        phieumua.hangHoaTen!,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      tilePadding:
                          const EdgeInsets.only(left: 20, top: 5, bottom: 0),
                      backgroundColor: Colors.transparent,
                      childrenPadding: const EdgeInsets.only(
                          left: 20, top: 0, bottom: 10, right: 20),
                      children: [
                        const SizedBox(height: 10),
                        tableItem(phieumua),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

  Table tableItem(BaoCaoPhieuMua phieu) {
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
                child: Text('Số Phiếu',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Tên Hàng Hóa',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Nhóm Vàng',
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
                child: Text(phieu.phieuMa!),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(phieu.hangHoaTen!),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(phieu.nhomTen!),
              ),
            ),
          ],
        ),
        const TableRow(
          decoration: BoxDecoration(
            color: Color.fromARGB(150, 218, 218, 218),
          ),
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Cân Tổng',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('TL Hột',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('TL Thực',
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
                child: Text(formatCurrencyDouble(phieu.canTong ?? 0)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatCurrencyDouble(phieu.tlHot ?? 0)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatCurrencyDouble(phieu.tlThuc ?? 0)),
              ),
            ),
          ],
        ),
        const TableRow(
          decoration: BoxDecoration(
            color: Color.fromARGB(150, 218, 218, 218),
          ),
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Ngày',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Đơn Giá',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Thành tiền',
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
                child: Text(phieu.ngayPhieu!),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatCurrencyDouble(phieu.donGia ?? 0)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formatCurrencyDouble(phieu.thanhTien ?? 0)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

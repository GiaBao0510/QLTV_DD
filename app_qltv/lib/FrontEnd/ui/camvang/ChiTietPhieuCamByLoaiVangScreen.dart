import 'package:app_qltv/FrontEnd/controller/CamVang/ChiTietCamVang_manager.dart';
import 'package:app_qltv/FrontEnd/ui/components/FormatCurrency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChiTietPhieuCamByLoaiVangScreen extends StatefulWidget {
  static const routeName = "/chiTietPhieuCamByLoaiVang";

  final String loaiVang;

  // ignore: use_super_parameters
  const ChiTietPhieuCamByLoaiVangScreen({
    Key? key,
    required this.loaiVang,
  }) : super(key: key);

  @override
  State<ChiTietPhieuCamByLoaiVangScreen> createState() =>
      _ChiTietPhieuCamByLoaiVangScreenState();
}

class _ChiTietPhieuCamByLoaiVangScreenState
    extends State<ChiTietPhieuCamByLoaiVangScreen> {
  int _currentPage = 1;
  int _totalRow = 0;
  late Future<List<dynamic>> _phieuCamFuture;
  late List<dynamic> phieuCamList = [];

  @override
  void initState() {
    super.initState();
    _loadChiTietPhieuCam();
  }

  void updatePage(int page) {
    setState(() {
      _currentPage = page;
    });
    _loadChiTietPhieuCam();
  }

  Future<void> _loadChiTietPhieuCam() async {
    final chiTietPhieuCamManager =
        Provider.of<ChiTietPhieuCamManager>(context, listen: false);

    try {
      _phieuCamFuture = chiTietPhieuCamManager.fetchByLoaiVang(
        loaiVang: widget.loaiVang,
        page: _currentPage,
        pageSize: 10,
      );

      await _phieuCamFuture.then((phieuCam) {
        setState(() {
          phieuCamList = phieuCam;
          _totalRow = chiTietPhieuCamManager.totalRow;
        });
      });
    } catch (error) {
      // Handle error gracefully
      // ignore: avoid_print
      print('Error fetching data: $error');
      // Optionally, show a snackbar or error dialog to inform the user
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
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: Text(
              widget.loaiVang,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(child: ShowList()),
              ),
              const SizedBox(height: 16),
              chuyenTrang(),
            ],
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
                        child: Text(
                          'Tổng số lượng Phiếu Cầm ${widget.loaiVang}: $_totalRow',
                        ),
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

  // ignore: non_constant_identifier_names
  FutureBuilder<List<dynamic>> ShowList() {
    return FutureBuilder<List<dynamic>>(
      future: _phieuCamFuture,
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
            itemCount: phieuCamList.length,
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
                          phieuCamList[index].phieuMa.toString() ?? 'null',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 20),
                        ),
                        GestureDetector(
                          onTap: () async {
                            _showBottomSheet(context, phieuCamList[index]);
                          },
                          child: const Icon(
                            CupertinoIcons.info_circle,
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

  void _showBottomSheet(BuildContext context, dynamic phieuCamItem) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 600,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    phieuCamItem.phieuMa.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w900, fontSize: 20),
                  ),
                  PhieuDetails(phieuCamItem),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Row chuyenTrang() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _currentPage > 1
              ? () {
                  updatePage(_currentPage - 1);
                }
              : null,
          child: const Text("Trang trước"),
        ),
        const SizedBox(width: 5),
        Text('$_currentPage'),
        const SizedBox(width: 5),
        ElevatedButton(
          onPressed: _currentPage < (_totalRow / 10).ceil()
              ? () {
                  updatePage(_currentPage + 1);
                }
              : null,
          child: const Text("Trang kế tiếp"),
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  SizedBox PhieuDetails(dynamic phieuCamItem) {
    return SizedBox(
      height: 600,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            const Text(
              'Thông tin phiếu cầm',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromARGB(255, 228, 200, 126),
              ),
            ),
            const SizedBox(height: 10),
            Text('Mã: ${phieuCamItem.phieuCamVangId}'),

            // Thông tin phiếu cầm
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Khách Hàng: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' ${phieuCamItem.khTen ?? 'null'}')
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Lãi suất/Tháng: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: ' ${phieuCamItem.laiXuat.toStringAsFixed(2)}%',
                  )
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Định giá: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        ' ${formatCurrencyDouble(phieuCamItem.dinhGia.toDouble())}',
                  )
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Ngày cầm: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' ${phieuCamItem.ngayCam ?? 'null'}')
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Ngày hết hạn: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' ${phieuCamItem.ngayQuaHan ?? 'null'}')
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Số ngày tính được: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' ${phieuCamItem.soNgayTinhDuoc}')
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Số ngày hết hạn: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' ${phieuCamItem.soNgayHetHan}')
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Tiền cầm: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        ' ${formatCurrencyDouble(phieuCamItem.tienKhachNhan.toDouble())}',
                  )
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Tiền thêm: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        ' ${formatCurrencyDouble(phieuCamItem.tienThem.toDouble())}',
                  )
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Tiền cầm mới: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        ' ${formatCurrencyDouble(phieuCamItem.tienCamMoi.toDouble())}',
                  )
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Mất phiếu: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' ${phieuCamItem.matPhieu ?? 'false'}')
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: ' Lý do mất phiếu: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' ${phieuCamItem.lyDoMatPhieu ?? 'null'}')
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Ghi chú: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' ${phieuCamItem.ghiChu ?? 'null'}')
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Thông tin hàng hóa
            const Text(
              'Thông tin hàng hóa',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: Color.fromARGB(255, 228, 200, 126),
              ),
            ),
            const SizedBox(height: 15),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Tên hàng: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' ${phieuCamItem.tenHangHoa ?? 'null'}')
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Loại vàng: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' ${phieuCamItem.loaiVang ?? 'null'}')
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Cân tổng: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        ' ${formatCurrencyDouble(phieuCamItem.canTong.toDouble())}',
                  )
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'TL hột: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        ' ${formatCurrencyDouble(phieuCamItem.tlHot.toDouble())}',
                  )
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'TL thực: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        ' ${formatCurrencyDouble(phieuCamItem.tlThuc.toDouble())}',
                  )
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Đơn giá: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        ' ${formatCurrencyDouble(phieuCamItem.donGia.toDouble())}',
                  )
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Thành tiền: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        ' ${formatCurrencyDouble(phieuCamItem.thanhTien.toDouble())}',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

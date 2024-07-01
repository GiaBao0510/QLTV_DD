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
    String getGreetingMessage() {
      int hour = DateTime.now().hour;
      if (hour < 10) {
        return 'Chúc bạn buổi sáng tốt lành!';
      } else if (hour < 13) {
        return 'Chúc bạn buổi trưa tốt lành!';
      } else if (hour < 18) {
        return 'Chúc bạn buổi chiều tốt lành!';
      } else {
        return 'Chúc bạn buổi tối tốt lành!';
      }
    }

    String AnhNen(){
      int hour = DateTime.now().hour;
      if (hour < 10) {
        return 'assets/images/morning.jpg';
      } else if (hour < 13) {
        return 'assets/images/CityNoonTime.jpg';
      } else if (hour < 18) {
        return 'assets/images/CityAffterNoon.jpg';
      } else {
        return 'assets/images/Saigon night__.jpg';
      }
    }

    Color Mau_LoiChuc(){
      int hour = DateTime.now().hour;
      if (hour < 10) {
        return Color.fromARGB(255, 255, 187, 0);
      } else if (hour < 13) {
        return Color.fromARGB(255, 0, 178, 183);
      } else if (hour < 18) {
        return Color.fromARGB(255, 255, 255, 255);
      } else {
        return Color.fromARGB(255, 255, 255, 255);
      }
    }

    final danhmuc_items = [
      {
        'image': 'assets/images/gold-ingot.png',
        'text': 'Loại Vàng',
        'routeName': '/loaivang'
      },
      {
        'image': 'assets/images/treasure.png',
        'text': 'Nhóm Vàng',
        'routeName': '/nhomvang'
      },
      {
        'image': 'assets/images/box.png',
        'text': 'Hàng Hóa',
        'routeName': '/hanghoa'
      },
      {
        'image': 'assets/images/database.png',
        'text': 'Kho',
        'routeName': '/khohang'
      },
      {
        'image': 'assets/images/boy.png',
        'text': 'Nhà Cung Cấp',
        'routeName': '/nhacungcap'
      },
      {
        'image': 'assets/images/avatar-design.png',
        'text': 'Khách Hàng',
        'routeName': '/khach'
      },
      {
        'image': 'assets/images/computer-worker.png',
        'text': 'Đơn Vị',
        'routeName': '/dvi'
      },
    ];

    final hethong_items = [
      {
        'image': 'assets/images/users.png',
        'text': 'Nhóm Người Dùng',
        'routeName': '/nhom'
      },
      {
        'image': 'assets/images/person.png',
        'text': 'Người Dùng',
        'routeName': '/nguoidung'
      },
      {
        'image': 'assets/images/remote-access.png',
        'text': 'Kết Nối',
        'routeName': '/ketnoi'
      },
    ];

    final camvang_items = [
      {
        'image': 'assets/images/sticky-notes.png',
        'text': 'Phiếu Đang Cầm',
        'routeName': '/phieudangcam'
      },
      {
        'image': 'assets/images/pencil.png',
        'text': 'Phiếu Đang Cầm Chi Tiết',
        'routeName': '/phieudangcamchitiet'
      },
    ];

    final baocao_items = [
      {
        'image': 'assets/images/budget.png',
        'text': 'Báo Cáo Phiếu Xuất',
        'routeName': '/baocaophieuxuat'
      },
      {
        'image': 'assets/images/report.png',
        'text': 'Báo Cáo Tồn Kho Loại Vàng',
        'routeName': '/baocaotonkholoaivang'
      },
      {
        'image': 'assets/images/clipboards.png',
        'text': 'Báo Cáo Tồn Kho Vàng',
        'routeName': '/baocaotonkhovang'
      },
      {
        'image': 'assets/images/documents.png',
        'text': 'Báo Cáo Tồn Kho Theo Nhóm Vàng',
        'routeName': '/baocaotonkhonhomvang'
      },
      {
        'image': 'assets/images/shopping-bag.png',
        'text': 'Kho Vàng Mua Vào',
        'routeName': '/KhoVangMuaVao'
      },
      // {
      //   'image': 'assets/images/paper.png',
      //   'text': 'In Phiếu Xuất',
      //   'routeName': '/loaivang'
      // },
      {
        'image': 'assets/images/presentation.png',
        'text': 'Khách Hàng Giao Dịch Nhiều',
        'routeName': '/topkhachhang'
      },
      {
        'image': 'assets/images/shopping-list.png',
        'text': 'Báo Cáo Phiếu Mua Vào',
        'routeName': '/baocaophieumua'
      },
      {
        'image': 'assets/images/document.png',
        'text': 'Báo Cáo Phiếu Đổi',
        'routeName': '/baocaophieudoi'
      },
    ];

    const crossAxisCount = 3;
    final int divisor = MediaQuery.of(context).size.height < 750
        ? 3
        : (MediaQuery.of(context).size.height > 900 ? 3 : 5);
    final itemHeight =
        (MediaQuery.of(context).size.height - kToolbarHeight - 150) / divisor;
    print('SIZE item:');
    print(itemHeight);
    final rowCount_DanhMuc = (danhmuc_items.length / crossAxisCount).ceil();
    final gridHeight_DanhMuc =
        itemHeight * rowCount_DanhMuc + (10.0 * (rowCount_DanhMuc - 1));

    final rowCount_HeThong = (hethong_items.length / crossAxisCount).ceil();
    final gridHeight_HeThong =
        itemHeight * rowCount_HeThong + (10.0 * (rowCount_HeThong - 1));

    final rowCount_CamVang = (camvang_items.length / crossAxisCount).ceil();
    final gridHeight_CamVang =
        itemHeight * rowCount_CamVang + (10.0 * (rowCount_CamVang - 1));

    final rowCount_BaoCao = (baocao_items.length / crossAxisCount).ceil();
    final gridHeight_BaoCao =
        itemHeight * rowCount_BaoCao + (10.0 * (rowCount_BaoCao - 1));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 228, 200, 126),
        title: const Text(
          'Phần Mềm Vàng',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
        ),
      ),
      drawer: const drawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            //Ảnh nền
            const SizedBox(height: 20),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child:Stack(
                children: [
                  Positioned(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Image.asset(
                          AnhNen(),
                          width: double.maxFinite,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      )
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 80,),
                        Text(
                          'XIN CHÀO!',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 187, 0),
                            fontWeight: FontWeight.w900,
                            fontSize: 30,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          getGreetingMessage(),
                          style: TextStyle(
                            color: Mau_LoiChuc(),
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),


            const SizedBox(height: 20),
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 40, right: 20, bottom: 50),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 228, 200, 126),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/category.png',
                        width: 24.0,
                        height: 24.0,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Danh Mục',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 50, left: 10, right: 10),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 218, 218, 218),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  width: double.infinity,
                  child: SizedBox(
                    height: gridHeight_DanhMuc,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: danhmuc_items.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, danhmuc_items[index]['routeName']!);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                danhmuc_items[index]['image']!,
                                width: 64.0,
                                height: 64.0,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                danhmuc_items[index]['text']!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 40, right: 20, bottom: 50),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 228, 200, 126),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/management.png',
                        width: 24.0,
                        height: 24.0,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Hệ Thống',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 50, left: 10, right: 10),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 218, 218, 218),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  width: double.infinity,
                  child: SizedBox(
                    height: gridHeight_HeThong,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: hethong_items.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, hethong_items[index]['routeName']!);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  hethong_items[index]['image']!,
                                  width: 64.0,
                                  height: 64.0,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  hethong_items[index]['text']!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ));
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 40, right: 20, bottom: 50),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 228, 200, 126),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/pawnshop.png',
                        width: 24.0,
                        height: 24.0,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Cầm Vàng',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 50, left: 10, right: 10),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 218, 218, 218),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  width: double.infinity,
                  child: SizedBox(
                    height: gridHeight_CamVang,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: camvang_items.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, camvang_items[index]['routeName']!);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                camvang_items[index]['image']!,
                                width: 64.0,
                                height: 64.0,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                camvang_items[index]['text']!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 40, right: 20, bottom: 50),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 228, 200, 126),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/clipboard.png',
                        width: 24.0,
                        height: 24.0,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Báo Cáo',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 50, left: 10, right: 10),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 218, 218, 218),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  width: double.infinity,
                  child: SizedBox(
                    height: gridHeight_BaoCao,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: baocao_items.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, baocao_items[index]['routeName']!);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                baocao_items[index]['image']!,
                                width: 64.0,
                                height: 64.0,
                              ),
                              const SizedBox(height: 5),
                              Expanded(
                                child: Text(
                                  baocao_items[index]['text']!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

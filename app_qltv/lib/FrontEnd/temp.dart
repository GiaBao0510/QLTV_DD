import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:number_paginator/number_paginator.dart';

class TestPage extends StatefulWidget {
  static const routeName = '/testfunction';

  const TestPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TestPage();
}

class _TestPage extends State<TestPage> {
  List posts = [];
  final scrollController = ScrollController();
  int page = 1;
  bool isLoadingMore = false;

  int numberOfPages = 20; //So luong tran
  List Pages = [];
  int stt = 0;

  //Load
  Future<void> fetchPosts() async {
    final url =
        'https://techcrunch.com/wp-json/wp/v2/posts?context=embed&per_page=5&$page';
    final uri = Uri.parse(url);
    final res = await http.get(uri);

    if (res.statusCode == 200) {
      final json = jsonDecode(res.body) as List;
      setState(() {
        posts = json;
        Pages.add(posts);
      });
    } else {
      print('Unexpected response');
    }
    print('- Pages: ${Pages}');
  }

  //Xư lý khi  cuon xuong de lay dữ liệu ke tiep
  Future<void> _scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        isLoadingMore = true;
      });
      page += 1;
      await fetchPosts();
      setState(() {
        isLoadingMore = false;
      });
    } else {
      print('Don\'t call');
    }
  }

  //Xu ly khi bam nút sang trang
  void getNewData() async {
    await fetchPosts();
  }

  //------------------
  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    fetchPosts();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => fetchPosts(),
      child: Scaffold(
          backgroundColor: Colors.grey.shade400,
          appBar: AppBar(
            title: Text('Test Page.'),
          ),

          //----
          //Phần tải dữ liệu cuộn trang
          //----
          // body: ListView.builder(
          //   padding: EdgeInsets.all(5),
          //   controller: scrollController,
          //   itemCount: isLoadingMore ? posts.length +1 : posts.length,
          //   itemBuilder: (context ,index){
          //     if(index < posts.length){
          //       final post = posts[index];
          //       final title = post['title']['rendered'];
          //       final description = post['yoast_head_json']['description'];
          //       return Card(
          //         child: ListTile(
          //           leading: CircleAvatar(
          //               child: Text('${index + 1}')
          //           ),
          //           title: Text('$title', maxLines:1,),
          //           subtitle: Text('$description'),
          //         ),
          //       );
          //     }else{
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //   }
          // ),

          //----
          //Phần tải dữ liệu bấm nút sang trang
          //----
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final item = posts[index];
                      final title = item['title']['rendered'];
                      final description =
                          item['yoast_head_json']['description'];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(child: Text('${stt++}')),
                          title: Text(
                            '$title',
                            maxLines: 1,
                          ),
                          subtitle: Text('$description'),
                        ),
                      );
                    }),
              ),

              // NumberPaginator(
              //     numberPages: numberOfPages,
              //   onPageChange: (index) => getNewData(),

              // ),
            ],
          )),
    );
  }
}

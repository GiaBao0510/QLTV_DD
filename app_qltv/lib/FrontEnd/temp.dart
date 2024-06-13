import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TestPage extends StatefulWidget{
  static const routeName = '/testfunction';

  const TestPage({Key? key}) : super(key:key);

  @override
  State<StatefulWidget> createState() => _TestPage();
}

class _TestPage extends State<TestPage>{
  List posts = [];
  final scrollController = ScrollController();
  int page =1;
  bool isLoadingMore = false;

  //Load
  Future<void> fetchPosts() async{
    final url ='https://techcrunch.com/wp-json/wp/v2/posts?context=embed&per_page=10&$page';
    final uri = Uri.parse(url);
    final res = await http.get(uri);

    if(res.statusCode == 200){
      final json = jsonDecode(res.body) as List;
      setState(() {
        posts += json;
      });
    }else{
      print('Unexpected response');
    }
  }

  //Xư lý load dữ liệu
  Future<void> _scrollListener() async{
    if(scrollController.position.pixels ==
        scrollController.position.maxScrollExtent){
      setState(() {
        isLoadingMore = true;
      });
      page +=1;
      await fetchPosts();
      setState(() {
        isLoadingMore = false;
      });
    }else{
      print('Don\'t call');
    }
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
        body: ListView.builder(
          padding: EdgeInsets.all(5),
          controller: scrollController,
          itemCount: isLoadingMore ? posts.length +1 : posts.length,
          itemBuilder: (context ,index){
            if(index < posts.length){
              final post = posts[index];
              final title = post['title']['rendered'];
              final description = post['yoast_head_json']['description'];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                      child: Text('${index + 1}')
                  ),
                  title: Text('$title', maxLines:1,),
                  subtitle: Text('$description'),
                ),
              );
            }else{
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        ),
      ),
    );
  }
}
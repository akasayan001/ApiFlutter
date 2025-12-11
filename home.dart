import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic>? dataList;
  // Map<String, dynamic>?DonedataMap;

  Future<void> hitAPI() async {
    http.Response resresponse;
    resresponse = await http.get(Uri.parse("https://picsum.photos/v2/list"));
    if (resresponse.statusCode == 200) {
      setState(() {
        dataList = jsonDecode(resresponse.body);
        //DonedataMap=dataMap!["data"];
        print(dataList);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    hitAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("GET API")),
      body: dataList == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: dataList!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ID: ${dataList![index]['id']}"),
                      Text("Name: ${dataList![index]['author']}"),
                      Text("Width: ${dataList![index]['width']}"),
                      Text("Height: ${dataList![index]['height']}"),
                      Text("Url: ${dataList![index]['url']}"),
                      // Text("Website: ${dataList![index]['download_url']}"),
                      Image.network(dataList![index]['download_url']),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

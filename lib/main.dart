import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main(){

  runApp(MaterialApp(home: ImageListPage(),));
}


class ImageListPage extends StatefulWidget {
  @override
  _ImageListPageState createState() => _ImageListPageState();
}

class _ImageListPageState extends State<ImageListPage> {
  List<String> imageUrls = [];

  Future<void> fetchImages() async {
    final response = await http.get(Uri.parse('http://192.168.29.37:3000/images/'));
    print(response);
    final List<dynamic> files = jsonDecode(response.body)['files'];
    final baseUrl = 'http://192.168.29.37:3000/images/';

    setState(() {
      imageUrls = files.map((fileName) => baseUrl + fileName).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image List'),
      ),
      body: Stack(children: [
        Positioned(
          width: 300,
          top: 100,
          left: 70,
          bottom: 90,
          child: ListView.builder(
          itemCount: imageUrls.length,
          itemBuilder: (BuildContext context, int index) {
            return Image.network(
              imageUrls[index],
              fit: BoxFit.cover,
            );
          },
        ),)

      ],)
    );
  }
}


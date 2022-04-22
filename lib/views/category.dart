import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/data/data.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/widgets/widget.dart';

class Category extends StatefulWidget {
  const Category({Key? key, required this.categoryName}) : super(key: key);
  final String categoryName;

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  TextEditingController searchController = TextEditingController();
  List<WallpaperModel> wallpapers = [];

  Future getSearchedWallpapers(String query) async {
    var response = await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$query&per_page=50&page=1"),
        headers: {"Authorization": apiKEY});
    log(response.body.toString());

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      //print(element);
      WallpaperModel wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {});
  }

  @override
  void initState() {
    getSearchedWallpapers(widget.categoryName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: brandName(),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: const Color(0xfff5f8fd),
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          wallpapersList(wallpapers: wallpapers, context: context)
        ]),
      ),
    );
  }
}

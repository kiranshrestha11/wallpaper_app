import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/data/data.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/widgets/widget.dart';

class Search extends StatefulWidget {
  final String searchQuery;

  const Search({Key? key, required this.searchQuery}) : super(key: key);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  List<WallpaperModel> wallpapers = [];

  getSearchedWallpapers(String query) async {
    var value = await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$query&per_page=50&page=1"),
        headers: {"Authorization": apiKEY});

    setState(() {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //print(element);
        WallpaperModel wallpaperModel = WallpaperModel.fromMap(element);
        wallpapers.add(wallpaperModel);
      });
    });
  }

  @override
  void initState() {
    getSearchedWallpapers(widget.searchQuery);
    searchController.text = widget.searchQuery;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                        hintText: "Search Wallpapers",
                        border: InputBorder.none),
                  ),
                ),
                InkWell(
                    onTap: () {
                      setState(() {
                        getSearchedWallpapers(searchController.text);
                      });
                    },
                    child: const Icon(Icons.search)),
              ],
            ),
          ),
          wallpapersList(wallpapers: wallpapers, context: context)
        ]),
      ),
    );
  }
}

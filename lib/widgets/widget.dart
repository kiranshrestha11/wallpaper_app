import 'package:flutter/material.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/views/image_view.dart';

Widget brandName() {
  return RichText(
    text: const TextSpan(
      style: TextStyle(
          fontFamily: "overpass", fontSize: 18, fontWeight: FontWeight.w600),
      children: <TextSpan>[
        TextSpan(text: 'Wallpaper', style: TextStyle(color: Colors.black)),
        TextSpan(text: 'Hub', style: TextStyle(color: Colors.blue)),
      ],
    ),
  );
}

Widget wallpapersList({required List<WallpaperModel> wallpapers, context}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      padding: const EdgeInsets.all(4.0),
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      physics: const ClampingScrollPhysics(),
      children: wallpapers.map((wallpaper) {
        return GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Imageview(
                            imgUrl: wallpaper.src.portrait,
                          )));
            },
            child: Hero(
              tag: wallpaper.src.portrait,
              child: Container(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  wallpaper.src.portrait,
                  //height: 50,
                  //width: 100,
                  fit: BoxFit.cover,
                ),
              )),
            ),
          ),
        );
      }).toList(),
    ),
  );
}

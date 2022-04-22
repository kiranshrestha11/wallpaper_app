import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class Imageview extends StatefulWidget {
  const Imageview({Key? key, required this.imgUrl}) : super(key: key);
  final String imgUrl;

  @override
  _ImageviewState createState() => _ImageviewState();
}

class _ImageviewState extends State<Imageview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.imgUrl,
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  widget.imgUrl,
                  fit: BoxFit.cover,
                )),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    _save();
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xff1C1B1B).withOpacity(0.8),
                        ),
                      ),
                      Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width / 2,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white54),
                              gradient: const LinearGradient(colors: [
                                Color(0x36FFFFFF),
                                Color(0x0FFFFFFF),
                              ]),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Column(
                            children: const [
                              Text(
                                "Set Wallpaper",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white54),
                              ),
                              Text(
                                "Image will be saved in gallery",
                                style: TextStyle(
                                    fontSize: 8, color: Colors.white60),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 25,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xff1C1B1B).withOpacity(0.5)),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.white54,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 80,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _save() async {
    if (Platform.isAndroid) {
      await _askPermission();
    }
    var response = await Dio()
        .get(widget.imgUrl, options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);
  }

  _askPermission() async {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      return Permission.photos;
    } else {
      return Permission.storage;
    }
  }
}

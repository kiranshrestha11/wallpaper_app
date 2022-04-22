class WallpaperModel {
  String url;
  String photographer;
  String photographerUrl;
  int photographerId;
  SrcModel src;

  WallpaperModel(
    this.url,
    this.photographer,
    this.photographerId,
    this.photographerUrl,
    this.src,
  );

  factory WallpaperModel.fromMap(Map<String, dynamic> parsedJson) {
    return WallpaperModel(
        parsedJson["url"],
        parsedJson["photographer"],
        parsedJson["photographer_id"],
        parsedJson["photographer_url"],
        SrcModel.fromMap(parsedJson["src"]));
  }
}

class SrcModel {
  String original;
  String small;
  String portrait;

  SrcModel(
      {required this.original, required this.small, required this.portrait});

  factory SrcModel.fromMap(Map<String, dynamic> srcJson) {
    return SrcModel(
        original: srcJson["original"],
        small: srcJson["small"],
        portrait: srcJson["portrait"]);
  }
}

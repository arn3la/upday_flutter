class ImageValuesShutterStock {
  int height;
  int width;
  String url;

  ImageValuesShutterStock({
    this.height,
    this.width,
    this.url,
  });

  factory ImageValuesShutterStock.fromJson(Map<String, dynamic> json) =>
      ImageValuesShutterStock(
        height: json['height'],
        width: json['width'],
        url: json['url'],
      );
}

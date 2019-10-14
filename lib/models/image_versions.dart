import 'image_values.dart';

class ImageVersionShutterStock {
  String id;
  Map<String, ImageValuesShutterStock> assets;
  String description;
  String imageType;
  bool hasModelRelease;
  String mediaType;

  ImageVersionShutterStock({
    this.id,
    this.assets,
    this.description,
    this.imageType,
    this.hasModelRelease,
    this.mediaType,
  });

  factory ImageVersionShutterStock.fromJson(Map<String, dynamic> json) {
    final Map<String, ImageValuesShutterStock> assetList = {};
    final Map<String, dynamic> asset = json['assets'];

    assetList['large_thumb'] =
        ImageValuesShutterStock.fromJson(asset['large_thumb']);
    assetList['huge_thumb'] =
        ImageValuesShutterStock.fromJson(asset['huge_thumb']);

    return ImageVersionShutterStock(
      id: json['id'],
      assets: assetList,
      description: json['description'],
      imageType: json['image_type'],
      hasModelRelease: json['has_model_release'],
      mediaType: json['media_type'],
    );
  }
}

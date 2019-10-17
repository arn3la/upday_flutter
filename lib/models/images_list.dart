import 'package:jasarevic_arnela/models/image_versions.dart';

class ImagesListShutterStock {
  int page;
  int perPage;
  int totalCount;
  String searchId;
  List<ImageVersionShutterStock> data;

  ImagesListShutterStock({
    this.page,
    this.perPage,
    this.totalCount,
    this.searchId,
    this.data,
  });

  factory ImagesListShutterStock.fromJson(Map<String, dynamic> json) =>
      ImagesListShutterStock(
        page: json['page'],
        perPage: json['per_page'],
        totalCount: json['total_count'],
        searchId: json['search_id'],
        data: (json['data'] != null && '${json['data']}' != '[]')
            // ignore: avoid_as
            ? (json['data'] as List)
                .map((i) => ImageVersionShutterStock.fromJson(i))
                .toList()
            : [],
      );
}

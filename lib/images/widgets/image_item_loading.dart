import 'package:flutter/material.dart';
import 'package:jasarevic_arnela/images/widgets/image_item.dart';
import 'package:jasarevic_arnela/images/widgets/image_loading.dart';

/// Based on the loading status, show new image or loading indicator
class ImageItemLoading extends StatelessWidget {
  final bool isLoading;
  final String url;

  ImageItemLoading({this.isLoading = false, this.url});

  @override
  Widget build(BuildContext context) =>
      isLoading ? ImageLoading() : ImageItem(url);
}

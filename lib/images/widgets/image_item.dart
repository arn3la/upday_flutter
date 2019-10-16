import 'package:flutter/material.dart';

class ImageItem extends StatelessWidget {
  final String url;

  ImageItem(this.url);

  @override
  Widget build(BuildContext context) => Container(
        child: FadeInImage.assetNetwork(
          fit: BoxFit.cover,
          placeholder: 'assets/placeholder.png',
          image: url,
        ),
        decoration:
            BoxDecoration(border: Border.all(color: Colors.white, width: 4)),
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class ImageListError extends StatelessWidget {
  @override
  Widget build(BuildContext context) => IgnorePointer(
          child: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Text(
            FlutterI18n.translate(context, 'error_loading'),
            style: TextStyle(color: Colors.white),
          ),
          decoration: BoxDecoration(
              color: Color(0xFF000000),
              borderRadius: BorderRadius.circular(24)),
        ),
      ));
}

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

/// In case that the list of images is not empty,
/// show error on the top of screen, with option try again
class ImageListError extends StatelessWidget {
  final Function _onPressed;

  ImageListError(this._onPressed);

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 70,
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              FlutterI18n.translate(context, 'error_loading'),
              style: TextStyle(color: Colors.white),
            ),
            FlatButton(
              onPressed: _onPressed,
              child: Text(
                FlutterI18n.translate(context, 'button_try_again'),
                style: TextStyle(color: Colors.deepOrange),
              ),
            )
          ],
        ),
      );
}

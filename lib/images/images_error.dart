import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:jasarevic_arnela/providers/images_provider.dart';
import 'package:provider/provider.dart';

/// Show error when there is no data in the list of images
class ImagesError extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  ImagesError(this.scaffoldKey);

  @override
  Widget build(BuildContext context) => ListView(
        children: <Widget>[
          SizedBox(height: 50),
          Image.asset(
            'assets/error.png',
            height: 200,
            width: 300,
          ),
          _buildInfoText(
            FlutterI18n.translate(context, 'images_error_title'),
            marginTop: 30,
            textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 32),
          ),
          _buildInfoText(
            FlutterI18n.translate(context, 'images_error_description_1'),
          ),
          _buildInfoText(
            FlutterI18n.translate(context, 'images_error_description_2'),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 56,
            ),
            child: FlatButton(
              onPressed: () => Provider.of<ImagesProvider>(context)
                  .getData(1)
                  .catchError((e) =>
                      scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text(
                            FlutterI18n.translate(context, 'error_loading')),
                      ))),
              child: Text(FlutterI18n.translate(context, 'button_try_again')
                  .toUpperCase()),
              color: Colors.deepOrange,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  side: BorderSide(color: Colors.red)),
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ],
      );

  _buildInfoText(String text, {TextStyle textStyle, double marginTop}) =>
      Container(
        margin: EdgeInsets.only(top: marginTop ?? 10),
        child: Center(
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      );
}

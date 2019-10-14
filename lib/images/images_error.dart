import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:jasarevic_arnela/providers/images_provider.dart';
import 'package:provider/provider.dart';

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
          SizedBox(height: 30),
          Center(
            child: Text(
              FlutterI18n.translate(context, 'images_error_title'),
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 32),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              FlutterI18n.translate(context, 'images_error_description_1'),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
                FlutterI18n.translate(context, 'images_error_description_2')),
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
              child: Text(FlutterI18n.translate(context, 'button_try_again')),
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
}

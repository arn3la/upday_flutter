import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:jasarevic_arnela/providers/images_provider.dart';
import 'package:provider/provider.dart';

import 'images_error.dart';
import 'images_loading.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int pageNumber = 1;
  int visitedIndex = 0;
  int currentIndex = 0;
  ImagesProvider provider;

  @override
  void initState() {
    super.initState();

    provider = Provider.of<ImagesProvider>(context, listen: false);
    provider.getData(1);
  }

  @override
  Widget build(BuildContext context) {
    print('BUILD IS CALLED ##');
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, 'images_list_title')),
      ),
      body: Consumer(
        builder: (context, ImagesProvider provider, _) => provider.getError ==
                    null ||
                provider.getError.pageNumber > 1
            ? provider.getImages != null && provider.getImages.length > 1
                ? OrientationBuilder(
                    builder: (context, orientation) => Stack(
                      children: <Widget>[
                        GridView.builder(
                          padding:
                              EdgeInsets.only(left: 12, top: 12, right: 12),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      (orientation == Orientation.portrait)
                                          ? 2
                                          : 3),
                          itemCount: provider.getImages.length,
                          itemBuilder: (BuildContext context, int index) {
                            final int listLength =
                                provider.getImages.length ?? 0;
                            currentIndex = index;
                            if (listLength - 1 - index == 15 &&
                                listLength > 29) {
                              try {
                                provider
                                    .getData(pageNumber)
                                    .then((result) => (visitedIndex = index));
                                if (visitedIndex < index) {
                                  pageNumber++;
                                }
                              } catch (e) {
                                print(e);
                              }
                            }
                            if (listLength - index <= 2) {
                              return Container(
                                child: Image.asset(
                                  'assets/placeholder.png',
                                  fit: BoxFit.cover,
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 4)),
                              );
                            } else {
                              return Container(
                                child: FadeInImage.assetNetwork(
                                  fit: BoxFit.cover,
                                  placeholder: 'assets/placeholder.png',
                                  image: provider.getImages[index]
                                      .assets['huge_thumb'].url,
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 4)),
                              );
                            }
                          },
                        ),
                        if (provider.getError != null &&
                            provider.getError.pageNumber > 1)
                          IgnorePointer(
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
                          )),
                      ],
                    ),
                  )
                : Center(child: ImageLoader())
            : ImagesError(scaffoldKey),
      ),
    );
  }
}

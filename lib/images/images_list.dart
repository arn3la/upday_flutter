import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:jasarevic_arnela/providers/images_provider.dart';
import 'package:provider/provider.dart';

import 'images_error.dart';
import 'widgets/image_item.dart';
import 'widgets/image_list_error.dart';
import 'widgets/image_loading.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _pageNumber = 2;
  int _visitedIndex = 0;

  @override
  void initState() {
    super.initState();

    Provider.of<ImagesProvider>(context, listen: false).getData(1);
  }

  @override
  Widget build(BuildContext context) {
    print('BUILD IS CALLED ##');
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, 'images_list_title')),
      ),
      body: Consumer(
        builder: (context, ImagesProvider provider, _) =>
            provider.getError != null &&
                    (provider.getImages == null || provider.getImages.isEmpty)
                ? ImagesError(_scaffoldKey)
                : provider.getImages != null && provider.getImages.isNotEmpty
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
                              itemCount: provider.getImages.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                final int listLength =
                                    provider.getImages.length ?? 0;
                                if (listLength - 1 - index == 15 &&
                                    listLength > 29) {
                                  try {
                                    provider.getData(_pageNumber);
                                    if (_visitedIndex < index) {
                                      _pageNumber++;
                                    }
                                    _visitedIndex = index;
                                  } catch (e) {
                                    print(e);
                                  }
                                }
                                if (listLength - index <= 2) {
                                  return ImageLoading();
                                }
                                return ImageItem(provider
                                    .getImages[index].assets['huge_thumb'].url);
                              },
                            ),
                            if (provider.getError != null) ImageListError(),
                          ],
                        ),
                      )
                    : Container(),
      ),
    );
  }
}

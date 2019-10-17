import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:jasarevic_arnela/images/images_error.dart';
import 'package:jasarevic_arnela/images/widgets/image_item_loading.dart';
import 'package:jasarevic_arnela/images/widgets/image_list_error.dart';
import 'package:jasarevic_arnela/providers/images_provider.dart';
import 'package:provider/provider.dart';

/// Main page with infinite scroll in form of the grid view
class MainPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(FlutterI18n.translate(context, 'images_list_title')),
        ),
        body: Consumer(
          builder: (context, ImagesProvider provider, _) =>
              _buildBody(provider),
        ),
      );

  Widget _buildBody(ImagesProvider provider) => provider.showErrorOnEmptyList()
      ? ImagesError(_scaffoldKey)
      : OrientationBuilder(
          builder: (context, orientation) => Stack(
            children: <Widget>[
              GridView.builder(
                padding: EdgeInsets.only(left: 12, top: 12, right: 12),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        (orientation == Orientation.portrait) ? 2 : 3),
                itemCount: provider.getImages.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  provider.onIndexChanged(index);
                  // Based on loading status, show loader or new images
                  return ImageItemLoading(
                      isLoading: provider.isLoadingRowVisible(),
                      url: provider.getImages[index].assets['huge_thumb'].url);
                },
              ),
              // If there is an error, show it on the top of screen
              // Has possibility to tap on try again button
              if (provider.getError != null)
                ImageListError(
                  () => provider.getData(provider.getPageNumber).then(
                    (_) {
                      provider.setPageNumber = provider.getPageNumber + 1;
                    },
                  ),
                ),
            ],
          ),
        );
}

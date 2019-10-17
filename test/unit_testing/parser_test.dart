import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:jasarevic_arnela/models/images_list.dart';

void main() {
  test('Regular data fetch from service, should load properly', () async {
    final file = File('../test_source/images_one_object.json');

    final String contentFile = await file.readAsString();

    final ImagesListShutterStock galleryObject =
        ImagesListShutterStock.fromJson(json.decode(contentFile));

    expect(galleryObject.data.isNotEmpty, true);
    expect(galleryObject.data.first.assets['huge_thumb'].url.isNotEmpty, true);
  });
}

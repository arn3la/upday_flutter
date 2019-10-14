import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jasarevic_arnela/models/image_versions.dart';
import 'package:jasarevic_arnela/models/images_list.dart';

const String numberOfElementsPerPage = '30';

class ImagesProvider extends ChangeNotifier {
  ImagesProvider() {
//    getData(1);
  }

  final List<ImageVersionShutterStock> _images = [];
  ErrorProvider _error;

  List<ImageVersionShutterStock> get getImages => _images;

  ErrorProvider get getError => _error;

  set setImages(List<ImageVersionShutterStock> images) {
    _images.addAll(images);
    _error = null;
    notifyListeners();
  }

  set setError(ErrorProvider error) {
    _error = error;
    notifyListeners();
  }

  Future<dynamic> getData(int pageNumber) async {
    try {
      final HttpClient httpClient = HttpClient();
      HttpClientRequest request;
      final Map<String, String> queryParameters = {
        'per_page': numberOfElementsPerPage,
        'page': pageNumber.toString(),
      };
      request = await httpClient.getUrl(Uri.https(
          'api.shutterstock.com', '/v2/images/search', queryParameters));
      request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
      request.headers.set(
          HttpHeaders.authorizationHeader,
          'Basic ${base64Encode(utf8.encode('0222c-'
              'f18bc-b5fcd-7031d-843a3-a5cdb'
              ':86f45-bcb6d-62601-f8084-61eb5-e34e3'))}');

      final HttpClientResponse response = await request.close();

      final String responseString =
          await response.transform(utf8.decoder).join();

      final listImages =
          ImagesListShutterStock.fromJson(jsonDecode(responseString));

      setImages = listImages.data;

      return listImages;
    } catch (e) {
      setError = ErrorProvider(e.message, pageNumber);
      throw e;
    }
  }
}

class ErrorProvider {
  final String error;
  final int pageNumber;

  ErrorProvider(this.error, this.pageNumber);
}

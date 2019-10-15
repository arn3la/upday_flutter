import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jasarevic_arnela/http/http.dart';
import 'package:jasarevic_arnela/models/image_versions.dart';
import 'package:jasarevic_arnela/models/images_list.dart';

const String _numberOfElementsPerPage = '30';

class ImagesProvider extends ChangeNotifier {
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
      final _apiService = ApiService();
      final Map<String, String> queryParameters = {
        'per_page': _numberOfElementsPerPage,
        'page': pageNumber.toString(),
      };
      await _apiService
          .getHttp(path: '/v2/images/search', queryParameters: queryParameters)
          .then((response) {
        final listImages =
            ImagesListShutterStock.fromJson(jsonDecode(response));
        setImages = listImages.data;
      }).catchError((e) {
        setError = ErrorProvider(e.message, pageNumber);
        throw e;
      });
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

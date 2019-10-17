import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jasarevic_arnela/http/http.dart';
import 'package:jasarevic_arnela/models/image_versions.dart';
import 'package:jasarevic_arnela/models/images_list.dart';

const String _numberOfElementsPerPage = '30';

class ImagesProvider extends ChangeNotifier {
  ImagesProvider() {
    getData(1);
  }

  final List<ImageVersionShutterStock> _images = [];
  String _error;
  int _pageNumber = 2;

  // Last index from which getData is called for pagination
  int _visitedIndex = 0;
  int _currentIndex = 0;

  List<ImageVersionShutterStock> get getImages => _images;

  String get getError => _error;

  int get getPageNumber => _pageNumber;

  int get getVisitedIndex => _visitedIndex;

  int get getCurrentIndex => _currentIndex;

  set setImages(List<ImageVersionShutterStock> images) {
    _images.addAll(images);
    _error = null;
    notifyListeners();
  }

  set setError(String error) {
    _error = error;
    notifyListeners();
  }

  set setPageNumber(int pageNumber) {
    _pageNumber = pageNumber;
  }

  set setCurrentIndex(int index) {
    _currentIndex = index;
  }

  set setVisitedIndex(int visitedIndex) {
    _visitedIndex = visitedIndex;
  }

  /// Fetch data from API service and parse response to list of images
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
      });
    } catch (e) {
      setError = e.message;
      throw e;
    }
  }

  /// Based on the index of every image, decide will new data be fetched
  void onIndexChanged(int index) {
    _currentIndex = index;
    if (shouldFetchNewData()) {
      try {
        getData(_pageNumber).then((_) {
          _pageNumber++;
        });
        _visitedIndex = index;
      } catch (e) {
        print(e);
      }
    }
  }

  @visibleForTesting
  bool shouldFetchNewData() {
    final int listLength = getImages.length ?? 0;
    return listLength - 1 - _currentIndex == 15 &&
        listLength > 29 &&
        _visitedIndex < _currentIndex;
  }

  /// Based on the condition, show loader or item of the list
  bool isLoadingRowVisible() => getImages.length - _currentIndex <= 2;

  /// If error exist and there is no data in the list, show error
  bool showErrorOnEmptyList() =>
      getError != null && (getImages == null || getImages.isEmpty);
}

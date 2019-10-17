import 'package:flutter_test/flutter_test.dart';
import 'package:jasarevic_arnela/models/image_versions.dart';
import 'package:jasarevic_arnela/providers/images_provider.dart';

void main() {
  test('Show error if list is empty', () async {
    final ImagesProvider providerObject = ImagesProvider();

    providerObject.setImages = [];
    providerObject.setError = 'List of images is empty';

    expect(providerObject.showErrorOnEmptyList(), true);
  });

  test('Remove error if list is not empty', () async {
    final ImagesProvider providerObject = ImagesProvider();

    providerObject.setImages = [ImageVersionShutterStock(id: 'some_id')];
    providerObject.setError = null;

    expect(providerObject.showErrorOnEmptyList(), false);
  });

  test('Visibility of loading row - should be visible', () async {
    final ImagesProvider providerObject = ImagesProvider();

    providerObject.setImages = [
      ImageVersionShutterStock(id: 'some_id_1'),
      ImageVersionShutterStock(id: 'some_id_2'),
      ImageVersionShutterStock(id: 'some_id_3'),
    ];
    providerObject.setCurrentIndex = 2;

    expect(providerObject.isLoadingRowVisible(), true);
  });

  test('Visibility of loading row - should not be visible', () async {
    final ImagesProvider providerObject = ImagesProvider();

    providerObject.setImages = [
      ImageVersionShutterStock(id: 'some_id_1'),
      ImageVersionShutterStock(id: 'some_id_2'),
      ImageVersionShutterStock(id: 'some_id_3'),
      ImageVersionShutterStock(id: 'some_id_4'),
      ImageVersionShutterStock(id: 'some_id_5'),
    ];
    providerObject.setCurrentIndex = 2;

    expect(providerObject.isLoadingRowVisible(), false);
  });

  test('Should new data load - case when it is smaller index', () async {
    final ImagesProvider providerObject = ImagesProvider();

    final List<ImageVersionShutterStock> imageSource = [];

    for (int i = 0; i < 29; i++) {
      imageSource.add(ImageVersionShutterStock(id: 'some_id_$i'));
    }

    providerObject.setImages = imageSource;
    providerObject.setCurrentIndex = 10;
    providerObject.setVisitedIndex = providerObject.getCurrentIndex - 1;

    expect(providerObject.shouldFetchNewData(), false);
  });

  test('Should new data load - case when it is bigger index index', () async {
    final ImagesProvider providerObject = ImagesProvider();

    final List<ImageVersionShutterStock> imageSource = [];

    for (int i = 0; i < 30; i++) {
      imageSource.add(ImageVersionShutterStock(id: 'some_id_$i'));
    }

    providerObject.setImages = imageSource;
    providerObject.setCurrentIndex = 20;
    providerObject.setVisitedIndex = providerObject.getCurrentIndex - 1;

    expect(providerObject.shouldFetchNewData(), false);
  });

  test(
      'Should new data load - call API on every 15th element from'
      'recived data, to get new set of data', () async {
    final ImagesProvider providerObject = ImagesProvider();

    final List<ImageVersionShutterStock> imageSource = [];

    for (int i = 0; i < 30; i++) {
      imageSource.add(ImageVersionShutterStock(id: 'some_id_$i'));
    }

    providerObject.setImages = imageSource;
    providerObject.setCurrentIndex = 14;
    providerObject.setVisitedIndex = providerObject.getCurrentIndex - 1;

    expect(providerObject.shouldFetchNewData(), true);
  });
}

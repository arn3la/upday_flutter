import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  // Define elements for controlling
  final gridView = find.byValueKey('gridview_key');

  FlutterDriver driver;

  // Connectivity to driver of flutter
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  // Dispose driver reference
  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  test(
      'Scroll list to some point to call API points in middle,'
      'idea is to test infinitive scrolling from user', () async {
    await driver.scroll(gridView, 0, -10000, Duration(seconds: 8));
  });
}

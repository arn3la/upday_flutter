import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jasarevic_arnela/images/widgets/image_item_loading.dart';
import 'package:mockito/mockito.dart';
import 'package:transparent_image/transparent_image.dart';

void main() {
  testWidgets('Case when row for loading items should be visible',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ImageItemLoading(
        isLoading: true,
        url: 'https://www.dummy.com/image.jpg',
      ),
    );

    expect(find.byType(FadeInImage), findsNothing);
  });

  testWidgets('In this case row with real item (pictures) should be visible',
      (WidgetTester tester) async {
    HttpOverrides.runZoned(() async {
      await tester.pumpWidget(ImageItemLoading(
        isLoading: false,
        url: 'https://www.dummy.com/image.jpg',
      ));

      expect(find.byType(FadeInImage), findsOneWidget);
    }, createHttpClient: createMockImageHttpClient);
  });
}

// Returns a mock HTTP client that responds with a blank image to all requests.
MockHttpClient createMockImageHttpClient(SecurityContext _) {
  final MockHttpClient client = MockHttpClient();
  final MockHttpClientRequest request = MockHttpClientRequest();
  final MockHttpClientResponse response = MockHttpClientResponse();
  final MockHttpHeaders headers = MockHttpHeaders();

  when(client.getUrl(any))
      .thenAnswer((_) => Future<HttpClientRequest>.value(request));
  when(request.headers).thenAnswer((_) => headers);
  when(request.close())
      .thenAnswer((_) => Future<HttpClientResponse>.value(response));
  when(response.contentLength).thenAnswer((_) => kTransparentImage.length);
  when(response.statusCode).thenAnswer((_) => HttpStatus.ok);
  when(response.listen(any)).thenAnswer((Invocation invocation) {
    final void Function(List<int>) onData = invocation.positionalArguments[0];
    final void Function() onDone = invocation.namedArguments[#onDone];
    final void Function(Object, [StackTrace]) onError =
        invocation.namedArguments[#onError];
    final bool cancelOnError = invocation.namedArguments[#cancelOnError];

    return Stream<List<int>>.fromIterable(<List<int>>[kTransparentImage])
        .listen(onData,
            onDone: onDone, onError: onError, cancelOnError: cancelOnError);
  });

  return client;
}

class MockHttpClient extends Mock implements HttpClient {}

class MockHttpClientRequest extends Mock implements HttpClientRequest {}

class MockHttpClientResponse extends Mock implements HttpClientResponse {}

class MockHttpHeaders extends Mock implements HttpHeaders {}

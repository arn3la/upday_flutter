import 'dart:convert';
import 'dart:io';

class ApiService {
  final _basicPath = 'api.shutterstock.com';
  final _basicAuth = 'Basic ${base64Encode(utf8.encode('0222c-f18bc-b5fcd-7031d'
      '-843a3-a5cdb:86f45-bcb6d-62601-f8084-61eb5-e34e3'))}';

  /// Returns true for every success HTTP code
  bool isStatusCodeSuccess(int currentStatusCode) {
    switch (currentStatusCode) {
      case HttpStatus.ok:
      case HttpStatus.created:
      case HttpStatus.accepted:
      case HttpStatus.nonAuthoritativeInformation:
      case HttpStatus.noContent:
      case HttpStatus.resetContent:
      case HttpStatus.partialContent:
      case HttpStatus.multiStatus:
      case HttpStatus.alreadyReported:
      case HttpStatus.imUsed:
        return true;
        break;
    }

    return false;
  }

  Future<dynamic> getHttp({
    String path = '',
    Map<String, String> queryParameters,
    var body,
    String headerTypeValue = 'application/json',
  }) async {
    try {
      final HttpClient httpClient = HttpClient();
      HttpClientRequest request;

      request =
          await httpClient.getUrl(Uri.https(_basicPath, path, queryParameters));
      request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
      request.headers.set(HttpHeaders.authorizationHeader, _basicAuth);

      if (body != null) request.add(utf8.encode(json.encode(body)));

      final HttpClientResponse response = await request.close();

      final String responseString =
          await response.transform(utf8.decoder).join();

      if (!isStatusCodeSuccess(response.statusCode)) {
        throw Exception();
      }

      return responseString;
    } catch (e) {
      throw e;
    }
  }
}

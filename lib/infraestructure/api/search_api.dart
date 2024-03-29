import 'package:dio/dio.dart';

class SearchAPI {
  final Dio _dio;

  SearchAPI(this._dio);

  search(String query) {
    _dio.get('https://autosuggest.search.hereapi.com/v1/autosuggest',
        queryParameters: {
          "apiKey": 'gKmQKAgOGGi4sP8OgC1vc5WK2z_ZLv7KLLqQqNFfhE0',
          "q": query,
          "in": "bbox:-93.226372,16.719187,-93.050247,16.804001"
        });
  }
}

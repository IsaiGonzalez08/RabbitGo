import 'dart:async';

import 'package:dio/dio.dart';
import 'package:rabbit_go/domain/models/place.dart';

class SearchAPI {
  final Dio _dio;

  SearchAPI(this._dio);
  CancelToken? _cancelToken;
  final _controller = StreamController<List<Place>?>.broadcast();

  Stream<List<Place>?> get onResults => _controller.stream;

  void search(String query) async {
    try {
      _cancelToken = CancelToken();
      final response = await _dio.get(
        'https://discover.search.hereapi.com/v1/discover',
        queryParameters: {
          "apiKey": 'gKmQKAgOGGi4sP8OgC1vc5WK2z_ZLv7KLLqQqNFfhE0',
          "q": query,
          "in": "bbox:-93.226372,16.719187,-93.050247,16.804001"
        },
        cancelToken: _cancelToken,
      );
      final results = (response.data['items'] as List)
          .map(
            (e) => Place.fromJson(e),
          )
          .toList();
      _controller.sink.add(results);
      _cancelToken = null;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        _controller.sink.add(null);
      }
    }
  }

  void cancel() {
    if (_cancelToken != null) {
      _cancelToken!.cancel();
      _cancelToken = null;
    }
  }

  void dispose() {
    cancel();
    _controller.close();
  }
}

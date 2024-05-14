import 'dart:async';

import 'package:dio/dio.dart';
import 'package:rabbit_go/domain/models/Route/route.dart';
import 'package:rabbit_go/infraestructure/providers/user_provider.dart';

class RouteAPI {
  final Dio _dio;
  final UserProvider _userProvider;
  CancelToken? _cancelToken;
  final _controller = StreamController<List<RouteModel>?>.broadcast();
  RouteAPI(this._dio, this._userProvider);
  Stream<List<RouteModel>?> get onResults => _controller.stream;

  void find(String query) async {
    try {
      String? token = _userProvider.token;
      Map<String, dynamic> headers = {
        "Content-Type": "application/json",
        "Authorization": "$token",
      };
      _cancelToken = CancelToken();
      final response = await _dio.get(
        'https://rabbitgo.sytes.net/bus/route/name/$query',
        options: Options(headers: headers),
        cancelToken: _cancelToken,
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data['data'];
        RouteModel route = RouteModel.fromJson(responseData);
        _controller.sink.add([route]);
      } else {
        _controller.sink.add(null);
      }

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

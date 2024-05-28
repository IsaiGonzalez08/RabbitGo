import 'package:dio/dio.dart';
import 'package:rabbit_go/domain/models/Place/place.dart';
import 'package:rabbit_go/domain/models/Place/repositories/place_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceRepositoryImpl implements PlaceRepository {
  final _dio = Dio();
  CancelToken? _cancelToken;

  @override
  Future<List<Marker>> onResults(String query) async {
    List<Marker> hereMarkers = [];
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
      hereMarkers.clear();
      for (var place in results) {
        final id = place.id;
        LatLng position = place.position;
        hereMarkers.add(Marker(
            markerId: MarkerId(id),
            position: position,
            infoWindow:
                InfoWindow(title: place.title, snippet: place.address)));
      }
      _cancelToken = null;
      return hereMarkers;
    } catch (e) {
      throw ('el error es $e');
    }
  }

  @override
  void cancel() {
    if (_cancelToken != null) {
      _cancelToken!.cancel();
      _cancelToken = null;
    }
  }
  
}

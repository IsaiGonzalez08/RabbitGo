import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rabbit_go/domain/models/Place/place.dart';
import 'package:rabbit_go/domain/models/Place/repositories/place_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceRepositoryImpl implements PlaceRepository {
  final _dio = Dio();
  final String token = dotenv.env['HERE_MAPS_API_TOKEN'] ?? '';

  @override
  Future<List<Marker>> onResults(String query) async {
    List<Marker> hereMarkers = [];
    try {
      final response = await _dio.get(
        'https://discover.search.hereapi.com/v1/discover',
        queryParameters: {
          "apiKey": token.toString(),
          "q": query,
          "in": "bbox:-93.226372,16.719187,-93.050247,16.804001"
        },
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
      return hereMarkers;
    } catch (e) {
      throw ('el error es $e');
    }
  }
  
}

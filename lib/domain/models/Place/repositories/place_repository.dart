import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class PlaceRepository {
  Future<List<Marker>> onResults(String query);
}
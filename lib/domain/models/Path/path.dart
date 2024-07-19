import 'package:google_maps_flutter/google_maps_flutter.dart';

class Path {
  final List<LatLng> ida;
  final List<LatLng> vuelta;

  Path({required this.ida, required this.vuelta});

  factory Path.fromJson(Map<String, dynamic> json) {
    return Path(
      ida: (json['ida'] as List<dynamic>)
          .map((coord) => LatLng(coord[0], coord[1]))
          .toList(),
      vuelta: (json['vuelta'] as List<dynamic>)
          .map((coord) => LatLng(coord[0], coord[1]))
          .toList(),
    );
  }
}

import 'package:google_maps_flutter/google_maps_flutter.dart';

class PathModel {
  final String pathId;
  final List<LatLng> routeCoordinates;
  final String shuttleId;
  final String estimatedTripTime;

  PathModel({
    required this.pathId,
    required this.routeCoordinates,
    required this.shuttleId,
    required this.estimatedTripTime,
  });

  factory PathModel.fromJson(Map<String, dynamic> json) {
    return PathModel(
      pathId: json['id'],
      routeCoordinates: (json['route'] as List)
          .map((coordinate) => LatLng(coordinate[0], coordinate[1]))
          .toList(),
      shuttleId: json['shuttleId'],
      estimatedTripTime: json['estimatedTripTime'],
    );
  }
}

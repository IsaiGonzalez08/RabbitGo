import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  final String title, address, id;
  final LatLng position;
  final int distance;

  Place(
      {required this.title,
      required this.address,
      required this.id,
      required this.position,
      required this.distance});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
        title: json['title'],
        address: json['address']['label'],
        id: json['id'],
        position: LatLng(json['position']['lat'], json['position']['lng']),
        distance: json['distance']);
  }
}

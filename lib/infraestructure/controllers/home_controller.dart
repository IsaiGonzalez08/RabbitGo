import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController {
  String? token;
  final Map<MarkerId, Marker> _markers = {};

  Set<Marker> get markers => _markers.values.toSet();
  late GoogleMapController _mapController;

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }
  

}

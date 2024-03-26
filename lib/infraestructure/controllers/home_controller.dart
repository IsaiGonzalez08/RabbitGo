import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class HomeController {
  String? token;
  final Map<MarkerId, Marker> _markers = {};

  Set<Marker> get markers => _markers.values.toSet();
  late GoogleMapController _mapController;

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

    Future<LatLng?> getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      print("Error al obtener la ubicación del usuario: $e");
      return null;
    }
  }
}

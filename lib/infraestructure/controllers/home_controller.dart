 import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rabbit_go/infraestructure/helpers/map_style.dart';

class HomeController {
  String? token;
  final Map<MarkerId, Marker> _markers = {};

  Set<Marker> get markers => _markers.values.toSet();

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(newMapStyle);
  }

  Future<LatLng?> getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      return null;
    }
  }
}

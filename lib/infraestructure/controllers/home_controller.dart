import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class HomeController {
  String? token;
  final Map<MarkerId, Marker> _markers = {};

  Set<Marker> get markers => _markers.values.toSet();
  late GoogleMapController _mapController;

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void addMarker(double latitude, double longitude, String markerId) async {
    print('Adding marker with lat: $latitude, lng: $longitude, markerId: $markerId');
    final MarkerId id = MarkerId(markerId);
    final Marker marker = Marker(
      markerId: id,
      position: LatLng(latitude, longitude),
    );
    _markers[id] = marker;
  }

  Future<void> getMarkers(String? token) async {
    try {
      String url = 'http://rabbitgo.sytes.net/bus/stop/';

      final response =
          await http.get(Uri.parse(url), headers: {'Authorization': token!});

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        for (var item in data) {
          final double lat = item['latitude'];
          final double lng = item['longitude'];
          final String markerId = item['uuid'];
          print(lat);
          print(lng);
          print(markerId);
          addMarker(lat, lng, markerId);
        }
      } else {
        print('Error en el login, Código de estado: ${response.statusCode}');
      }
    } catch (error) {
      print('Error al conectar con el servidor: $error');
    }
  }

  
}

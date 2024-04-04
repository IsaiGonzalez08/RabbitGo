import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteCoordinatesModel extends ChangeNotifier {
  List<LatLng>? coordinates = [];

  void setDataCoordinates(
    List<LatLng>? routesCoordinates,
  ) {
    coordinates = routesCoordinates;
    notifyListeners();
  }
}

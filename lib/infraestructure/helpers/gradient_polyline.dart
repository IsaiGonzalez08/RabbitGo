import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class GradientPolyline extends Polyline {
  GradientPolyline({
    required PolylineId polylineId,
    required List<LatLng> points,
    required int width,
    required List<Color> gradientColors,
  }) : super(
          polylineId: polylineId,
          points: points,
          width: width,
          color: gradientColors.first,
        );
}

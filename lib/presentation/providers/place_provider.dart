import 'dart:async';

import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rabbit_go/domain/models/Place/repositories/place_repository.dart';
import 'package:rabbit_go/infraestructure/repositories/Place/place_repository_impl.dart';

class PlaceProvider extends ChangeNotifier {
  final PlaceRepository _placeRepository = PlaceRepositoryImpl();
  PlaceProvider();

  List<Marker> _hereMarkers = [];

  List<Marker> get hereMarkers => _hereMarkers;

  Future<void> handleSubmitted(String query) async {
    try {
      if (query.isNotEmpty) {
        _hereMarkers = await _placeRepository.onResults(query);
        notifyListeners();
      } else {
        _placeRepository.cancel();
      }
    } catch (e) {
      throw ('El error es $e');
    }
  }
}

import 'dart:async';

import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:rabbit_go/domain/models/Place/gateway/place_gateway.dart';
import 'package:rabbit_go/domain/models/Place/place.dart';


class PlaceProvider extends ChangeNotifier {
  final PlaceGateway _placeGateway;
  late StreamSubscription _subscription;
  List<Place>? _places = [];
  List<Place>? get places => _places;
  String _query = '';

  PlaceProvider(this._placeGateway) {
    _subscription = _placeGateway.onResults.listen(
      (results) {
        _places = results;
        notifyListeners();
      },
    );
  }
  
  String get query => _query;

  void handleSubmiitted(String text) {
    _query = text;
    if (_query.length >= 3) {
      _placeGateway.cancel();
      _placeGateway.find(query);
    } else {
      _placeGateway.cancel();
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    _placeGateway.dispose();
    super.dispose();
  }
}

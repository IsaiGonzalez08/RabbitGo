import 'dart:async';

import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:rabbit_go/domain/models/place.dart';
import 'package:rabbit_go/domain/repository/search_place_repository.dart';

class SearchPlaceController extends ChangeNotifier {
  final SearchRepository _searchRepository;
  String _query = '';
  late StreamSubscription _subscription;

  List<Place>? _places = [];
  List<Place>? get places => _places;

  SearchPlaceController(this._searchRepository) {
    _subscription = _searchRepository.onResults.listen(
      (results) {
        print('resultados: ${results?.length}');
        _places = results;
        notifyListeners();
      },
    );
  }
  String get query => _query;

  void handleSubmiitted(String text) {
    _query = text;
    if (_query.length >= 3) {
      print('Call API $query');
      _searchRepository.cancel();
      _searchRepository.search(query);
    } else {
      print('Cancel call API');
      _searchRepository.cancel();
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    _searchRepository.dispose();
    super.dispose();
  }
}

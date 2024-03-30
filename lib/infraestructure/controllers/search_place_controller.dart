import 'dart:async';

import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:rabbit_go/domain/repository/search_repository.dart';

class SearchPlaceController extends ChangeNotifier {
  final SearchRepository _searchRepository;
  String _query = '';
  late StreamSubscription _subscription;

  SearchPlaceController(this._searchRepository) {
    _subscription = _searchRepository.onResults.listen(
      (results) {
        print('resultados: ${results?.length}');
      },
    );
  }
  String get query => _query;

  Timer? _debouncer;

  void onQueryChanged(String text) {
    _query = text;
    _debouncer?.cancel();
    _debouncer = Timer(const Duration(milliseconds: 500), () {
      if (_query.length >= 3) {
        print('Call API $query');
        _searchRepository.cancel();
        _searchRepository.search(query);
      } else {
        print('Cancel call API');
        _searchRepository.cancel();
      }
    });
  }

  @override
  void dispose() {
    _debouncer?.cancel();
    _subscription.cancel();
    _searchRepository.dispose();
    super.dispose();
  }
}

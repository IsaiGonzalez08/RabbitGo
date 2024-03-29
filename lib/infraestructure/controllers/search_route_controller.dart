import 'dart:async';

import 'package:flutter/material.dart' show ChangeNotifier;

class SearchRouteController extends ChangeNotifier {
  String _query = '';
  String get query => _query;

  Timer? _debouncer;

  void onQueryChanged(String text) {
    _query = text;
    _debouncer?.cancel();
    _debouncer = Timer(const Duration(milliseconds: 400), () {
      if (_query.length >= 3) {
        throw('Call API');
      } else {
        throw('Cancel call API');
      }
    });
  }

  @override
  void dispose() {
    _debouncer?.cancel();
    super.dispose();
  }
}

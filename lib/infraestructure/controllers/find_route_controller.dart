import 'dart:async';

import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:rabbit_go/domain/models/route.dart';
import 'package:rabbit_go/domain/repository/find_route_repository.dart';

class FindRouteController extends ChangeNotifier {
  final FindRouteRepository _findRouteRepository;
  String _query = '';
  late StreamSubscription _subscription;

  List<Route>? _routes = [];
  List<Route>? get routes => _routes;

  Route? _origin;
  Route? get origin => _origin;

  FindRouteController(this._findRouteRepository) {
    _subscription = _findRouteRepository.onResults.listen(
      (results) {
        print('resultados: ${results?.length}');
        _routes = results;
        notifyListeners();
      },
    );
  }

  String get query => _query;
  Timer? _debouncer;

  void queryChanged(String text) {
    _query = text;
    _debouncer?.cancel();
    _debouncer = Timer(const Duration(milliseconds: 500), () {
      if (_query.length >= 3) {
        print('Call API $query');
        _findRouteRepository.cancel();
        _findRouteRepository.find(query);
      } else {
        print('Cancel call API');
        _findRouteRepository.cancel();
        _routes = [];
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _debouncer?.cancel();
    _subscription.cancel();
    _findRouteRepository.dispose();
    super.dispose();
  }
}

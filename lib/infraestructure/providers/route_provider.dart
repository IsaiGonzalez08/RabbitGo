import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rabbit_go/domain/models/Route/repositories/route_repository.dart';
import 'package:rabbit_go/domain/models/Route/route.dart';
import 'package:rabbit_go/infraestructure/repositories/Route/route_repository_impl.dart';

class RouteProvider extends ChangeNotifier {
  final RouteRepository _routeRepository = RouteRepositoryImpl();

  late StreamSubscription _subscription;

  String _query = '';

  List<RouteModel>? _routes = [];
  List<RouteModel>? get routes => _routes;

  RouteProvider();

  String get query => _query;
  Timer? _debouncer;

  void queryChanged(String text) {
    _query = text;
    _debouncer?.cancel();
    _debouncer = Timer(const Duration(milliseconds: 800), () {
      if (_query.length >= 3) {
        _routeRepository.cancel();
        _routeRepository.getRouteByName(query);
      } else {
        _routeRepository.cancel();
        _routes = [];
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _debouncer?.cancel();
    _subscription.cancel();  
    super.dispose();
  }
}

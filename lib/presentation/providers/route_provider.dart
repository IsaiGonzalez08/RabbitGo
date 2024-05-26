import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rabbit_go/domain/models/Route/repositories/route_repository.dart';
import 'package:rabbit_go/domain/models/Route/route.dart';
import 'package:rabbit_go/infraestructure/repositories/Route/route_repository_impl.dart';

class RouteProvider extends ChangeNotifier {
  BuildContext context;
  final RouteRepository _routeRepository;

  List<RouteModel>? _routes = [];
  List<RouteModel>? get routes => _routes;

  RouteProvider(this.context): _routeRepository = RouteRepositoryImpl(context);
  Timer? _debouncer;

  void queryChanged(String? token, String query) {
    _debouncer?.cancel();
    _debouncer = Timer(const Duration(milliseconds: 800), () async {
      if (query.isNotEmpty) {
        _routeRepository.cancel();
        List<RouteModel> routes =
            await _routeRepository.getRouteByName(token, query);
        _routes = routes;
        notifyListeners();
      } else {
        _routeRepository.cancel();
        _routes = [];
        notifyListeners();
      }
    });
  }

  void cleanListRoutes() {
    _routes = [];
    notifyListeners();
  }
}

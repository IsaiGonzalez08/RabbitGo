import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rabbit_go/domain/models/Route/repositories/route_repository.dart';
import 'package:rabbit_go/domain/models/Route/route.dart';
import 'package:rabbit_go/infraestructure/repositories/Route/route_repository_impl.dart';

class RouteProvider extends ChangeNotifier {
  final RouteRepository _routeRepository = RouteRepositoryImpl();

  List<RouteModel> _routes = [];
  List<RouteModel> get routes => _routes;
  List<RouteModel> _routesAlert = [];
  List<RouteModel> get routesAlert => _routesAlert;
  List<LatLng> _routePath = [];
  List<LatLng> get routePath => _routePath;
  bool _loading = false;
  bool get loading => _loading;

  Timer? _debouncer;

  void queryChanged(String token, String query) {
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

  void getRouteByBusStopId(String token, String busStopId) async {
    _loading = true;
    List<RouteModel> routesAlert =
        await _routeRepository.getRouteByBusStopId(token, busStopId);
    _routesAlert = routesAlert;
    _loading = false;
    notifyListeners();
  }

  Future<void> getRouteBusPath(String token, String busRouteId) async {
    List<LatLng> routePath =
        await _routeRepository.getRouteBusPath(token, busRouteId);
    _routePath = routePath;
    notifyListeners();
  }

  void cleanListRoutes() {
    _routes = [];
    notifyListeners();
  }
}

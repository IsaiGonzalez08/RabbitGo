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

  void getAllRoutes(String token) async {
    _loading = true;
    List<RouteModel> routes = await _routeRepository.getAllRoutes(token);
    _routes = routes;
    _loading = false;
    notifyListeners();
  }

  void getRouteByBusStopId(String token, String busStopId) async {
    _loading = true;
    List<RouteModel> routesAlert =
        await _routeRepository.getRouteByBusStopId(token, busStopId);
    _routesAlert = routesAlert;
    _loading = false;
    notifyListeners();
  }

  Future<void> createBusRoute(routeName, routePrice, routeStartTime,
      routeEndTime, routeBusStopUuid, token) async {
    RouteModel newRoute = await _routeRepository.createBusRoute(routeName,
        routePrice, routeStartTime, routeEndTime, routeBusStopUuid, token);
    _routes.add(newRoute);
    notifyListeners();
  }

  Future<void> updateBusRoute(
    routeUuid,
    routeName,
    routePrice,
    routeStartTime,
    routeEndTime,
    token,
    routeBusStopUuid,
  ) async {
    await _routeRepository.updateBusRoute(routeUuid, routeName, routePrice,
        routeStartTime, routeEndTime, routeBusStopUuid, token);
  }

  Future<void> getRouteBusPath(String token, String busRouteId) async {
    List<LatLng> routePath =
        await _routeRepository.getRouteBusPath(token, busRouteId);
    _routePath = routePath;
    notifyListeners();
  }

  void deleteRouteByUuid(String token, String busRouteUuid) async {
    await _routeRepository.deleteRouteById(token, busRouteUuid);
    _removeRouteLocally(busRouteUuid);
    notifyListeners();
  }

  void _removeRouteLocally(String busRouteUuid) {
    routes.removeWhere((route) => route.uuid == busRouteUuid);
    notifyListeners();
  }
}

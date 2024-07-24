import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rabbit_go/domain/models/Route/repositories/route_repository.dart';
import 'package:rabbit_go/domain/models/Route/route.dart';
import 'package:rabbit_go/infraestructure/repositories/Route/route_repository_impl.dart';

class RouteProvider extends ChangeNotifier {
  final RouteRepository _routeRepository = RouteRepositoryImpl();

  List<RouteModel> _routes = [];
  List<RouteModel> get routes => _routes;

  List<RouteModel> _routesAlert = [];
  List<RouteModel> get routesAlert => _routesAlert;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> getAllRoutes(String token) async {
    _loading = true;
    List<RouteModel> routes = await _routeRepository.getAllRoutes(token);
    _routes = routes;
    _loading = false;
    notifyListeners();
  }

  Future<void> getRouteByBusStopId(String token, String busStopId) async {
    _loading = true;
    List<RouteModel> routesAlert =
        await _routeRepository.getRouteByBusStopId(token, busStopId);
    _routesAlert = routesAlert;
    _loading = false;
    notifyListeners();
  }

  Future<void> createBusRoute(
      String routeName,
      int routePrice,
      String? routeStartTime,
      String? routeEndTime,
      List<String> colonies,
      List<String> shuttleStopId) async {
    await _routeRepository.createBusRoute(routeName, routePrice, routeStartTime,
        routeEndTime, colonies, shuttleStopId);
  }

  Future<void> updateBusRoute(
    String routeUuid,
    String routeName,
    int routePrice,
    String? routeStartTime,
    String? routeEndTime,
    List<String> colonies,
    List<String> shuttleStopId,
  ) async {
    await _routeRepository.updateBusRoute(routeUuid, routeName, routePrice,
        routeStartTime, routeEndTime, colonies, shuttleStopId);
  }

  void deleteRouteByUuid(String busRouteUuid) async {
    await _routeRepository.deleteRouteById(busRouteUuid);
    _removeRouteLocally(busRouteUuid);
    notifyListeners();
  }

  void _removeRouteLocally(String busRouteUuid) {
    routes.removeWhere((route) => route.id == busRouteUuid);
    notifyListeners();
  }
}

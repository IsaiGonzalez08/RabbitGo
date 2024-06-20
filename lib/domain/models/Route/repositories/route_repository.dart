import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rabbit_go/domain/models/Route/route.dart';

abstract class RouteRepository {
  Future<List<RouteModel>> getAllRoutes(String token);
  Future<void> deleteRouteById(String token, String busRouteUuid);
  Future<void> createBusRoute(
      String routeName,
      String routePrice,
      String routeStartTime,
      String routeEndTime,
      String routeBusStopUuid,
      String token);
  Future<void> updateBusRoute(
      String routeName,
      String routePrice,
      String routeStartTime,
      String routeEndTime,
      String routeBusStop,
      String token,
      String id);
  Future<List<RouteModel>> getRouteByBusStopId(String token, String busStopId);
  Future<List<LatLng>> getRouteBusPath(String token, String busRouteId);
}

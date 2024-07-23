import 'package:rabbit_go/domain/models/Route/route.dart';

abstract class RouteRepository {
  Future<List<RouteModel>> getAllRoutes(String token);
  Future<void> deleteRouteById(String busRouteUuid);
  Future<void> createBusRoute(
      String routeName,
      int routePrice,
      String? routeStartTime,
      String? routeEndTime,
      List<String> colonies,
      List<String> shuttleStopId);
  Future<void> updateBusRoute(
      String routeId,
      String routeName,
      int routePrice,
      String? routeStartTime,
      String? routeEndTime,
      List<String> colonies,
      List<String> shuttleStopId
      );
  Future<List<RouteModel>> getRouteByBusStopId(String token, String busStopId);
}

import 'package:rabbit_go/domain/models/Route/route.dart';

abstract class RouteRepository {
  Future<List<RouteModel>> getAllRoutes(String token);
  Future<void> deleteRouteById(String busRouteUuid);
  Future<RouteModel> createBusRoute(
      String routeName,
      int routePrice,
      String routeStartTime,
      String routeEndTime,
      String routeBusStopUuid);
  Future<void> updateBusRoute(
      String routeId,
      String routeName,
      String routePrice,
      String routeStartTime,
      String routeEndTime,
      String routeBusStopId,
      String token,
      );
  Future<List<RouteModel>> getRouteByBusStopId(String token, String busStopId);
}

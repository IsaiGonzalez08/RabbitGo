import 'package:rabbit_go/domain/models/Route/route.dart';

abstract class RouteRepository {
  Future<List<RouteModel>> getAllRoutes(String token);
  Future<void> deleteRouteById(String? token, String? id);
  Future<void> createBusRoute(
      String routeName,
      String routePrice,
      String routeStartTime,
      String routeEndTime,
      String routeBusStop,
      String token);
}

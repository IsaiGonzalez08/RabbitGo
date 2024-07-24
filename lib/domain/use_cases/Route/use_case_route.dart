import 'package:rabbit_go/domain/models/Route/repositories/route_repository.dart';
import 'package:rabbit_go/domain/models/Route/route.dart';

class GetAllRoutesUseCase {
  final RouteRepository _routeRepository;
  GetAllRoutesUseCase(this._routeRepository);

  Future<List<RouteModel>> getAllRoutes(String token) async {
    return await _routeRepository.getAllRoutes(token);
  }
}

class DeleteRouteById {
  final RouteRepository _routeRepository;

  DeleteRouteById(this._routeRepository);

  Future<void> deleteRouteById(String busRouteUuid) async {
    return await _routeRepository.deleteRouteById(busRouteUuid);
  }
}

class CreateBusRouteUseCase {
  final RouteRepository _routeRepository;

  CreateBusRouteUseCase(this._routeRepository);

  Future<void> createBusRoute(
      String routeName,
      int routePrice,
      String? routeStartTime,
      String? routeEndTime,
      List<String> colonies,
      List<String> shushuttleStopId) async {
    await _routeRepository.createBusRoute(routeName, routePrice, routeStartTime,
        routeEndTime, colonies, shushuttleStopId);
  }
}

class UpdateBusRouteUseCase {
  final RouteRepository _routeRepository;

  UpdateBusRouteUseCase(this._routeRepository);

  Future<void> updateBusRoute(
      String routeUuid,
      String routeName,
      int routePrice,
      String? routeStartTime,
      String? routeEndTime,
      List<String> colonies,
      List<String> shuttleStopId) async {
    await _routeRepository.updateBusRoute(routeUuid, routeName, routePrice,
        routeStartTime, routeEndTime, colonies, shuttleStopId);
  }
}

class GetRouteByBusStopIdUseCase {
  final RouteRepository _routeRepository;

  GetRouteByBusStopIdUseCase(this._routeRepository);

  Future<void> getRouteByBusStopId(String token, String busStopId) async {
    await _routeRepository.getRouteByBusStopId(token, busStopId);
  }
}

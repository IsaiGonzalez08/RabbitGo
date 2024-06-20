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

  Future<void> deleteRouteById(String token, String id) async {
    return await _routeRepository.deleteRouteById(token, id);
  }
}

class CreateBusRouteUseCase {
  final RouteRepository _routeRepository;

  CreateBusRouteUseCase(this._routeRepository);

  Future<void> createBusStop(
      String routeName,
      String routePrice,
      String routeStartTime,
      String routeEndTime,
      String routeBusStopUuid,
      String token) async {
    await _routeRepository.createBusRoute(routeName, routePrice, routeStartTime,
        routeEndTime, routeBusStopUuid, token);
  }
}

class UpdateBusRouteUseCase {
  final RouteRepository _routeRepository;

  UpdateBusRouteUseCase(this._routeRepository);

  Future<void> updateBusStop(
      String routeName,
      String routePrice,
      String routeStartTime,
      String routeEndTime,
      String routeBusStop,
      String token,
      String id) async {
    await _routeRepository.updateBusRoute(routeName, routePrice, routeStartTime,
        routeEndTime, routeBusStop, token, id);
  }
}

class GetRouteByBusStopIdUseCase {
  final RouteRepository _routeRepository;

  GetRouteByBusStopIdUseCase(this._routeRepository);

  Future<void> getRouteByBusStopId(String token, String busStopId) async {
    await _routeRepository.getRouteByBusStopId(token, busStopId);
  }
}

class GetRouteBusPath {
  final RouteRepository _routeRepository;
  GetRouteBusPath(this._routeRepository);
  Future<void> getRouteBusPath(String token, String busRouteId) async {
    await _routeRepository.getRouteBusPath(token, busRouteId);
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/domain/models/Route/repositories/route_repository.dart';
import 'package:rabbit_go/domain/models/Route/route.dart';
import 'package:rabbit_go/infraestructure/repositories/Route/api_route_repository.dart';
import 'package:rabbit_go/infraestructure/repositories/Route/local_route_repository.dart';

import '../../../presentation/providers/connectivity_services.dart';

class RouteRepositoryImpl extends ChangeNotifier implements RouteRepository {
  CancelToken? cancelToken;
  final dio = Dio();
  final ApiRouteRepository _apiRouteRepository = ApiRouteRepository();
  final LocalRouteRepository _localRouteRepository = LocalRouteRepository();
  final BuildContext context;

  RouteRepositoryImpl(
       this.context);

  @override
  Future<List<RouteModel>> getAllRoutes(String token) async {
    var connectivityService =
        Provider.of<ConnectivityService>(context, listen: false);
    if (connectivityService.status == ConnectivityStatus.connected) {
      print('hay internet');
      await _localRouteRepository.proccessPendingOperations(
          _apiRouteRepository, token);
      final routes = await _apiRouteRepository.getAllRoutes(token);
      await _localRouteRepository.saveRoutesLocally(routes);
      return routes;
    } else {
      print('no hay internet');
      return _localRouteRepository.getAllRoutes(token);
    }
  }

  @override
  Future<void> deleteRouteById(String token, String id) async {
    var connectivityService =
        Provider.of<ConnectivityService>(context, listen: false);
    if (connectivityService.status == ConnectivityStatus.connected) {
      print('hay internet');
      await _localRouteRepository.proccessPendingOperations(
          _apiRouteRepository, token);
      await _apiRouteRepository.deleteRouteById(token, id);
    } else {
      print('no hay internet');
      await _localRouteRepository.deleteRoutesLocally(id);
      final operation = {'action': 'delete', 'token': token, 'uuid': id};
      await _localRouteRepository.savePendingOperations(operation);
    }
  }

  @override
  Future<void> createBusRoute(
      String routeName,
      String routePrice,
      String routeStartTime,
      String routeEndTime,
      String routeBusStop,
      String token) async {
    var connectivityService =
        Provider.of<ConnectivityService>(context, listen: false);
    if (connectivityService.status == ConnectivityStatus.connected) {
      await _localRouteRepository.proccessPendingOperations(
          _apiRouteRepository, token);
      await _apiRouteRepository.createBusRoute(routeName, routePrice,
          routeStartTime, routeEndTime, routeBusStop, token);
    } else {
      final operation = {
        'action': 'create',
        'name': routeName,
        'price': routePrice,
        'startTime': routeStartTime,
        'endTime': routeEndTime,
        'busStopId': routeBusStop,
      };
      await _localRouteRepository.savePendingOperations(operation);
    }
  }

  @override
  Future<void> updateBusRoute(
      String routeName,
      String routePrice,
      String routeStartTime,
      String routeEndTime,
      String routeBusStop,
      String token,
      String id) async {
    var connectivityService =
        Provider.of<ConnectivityService>(context, listen: false);
    if (connectivityService.status == ConnectivityStatus.connected) {
      await _localRouteRepository.proccessPendingOperations(
          _apiRouteRepository, token);
      await _apiRouteRepository.updateBusRoute(routeName, routePrice,
          routeStartTime, routeEndTime, routeBusStop, token, id);
    } else {
      final operation = {
        'action': 'update',
        'uuid': id,
        'name': routeName,
        'price': routePrice,
        'startTime': routeStartTime,
        'endTime': routeEndTime,
        'busStopId': routeBusStop,
      };
      await _localRouteRepository.savePendingOperations(operation);
    }
  }

  @override
  Future<List<RouteModel>> getRouteByName(String? token, String query) async {
    try {
      Map<String, dynamic> headers = {
        "Content-Type": "application/json",
        "Authorization": token,
      };
      cancelToken = CancelToken();
      final response = await dio.get(
        'https://rabbitgo.sytes.net/bus/route/name/$query',
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        if (jsonResponse is Map<String, dynamic> &&
            jsonResponse.containsKey('data')) {
          final data = jsonResponse['data'];
          if (data != null) {
            List<RouteModel> routes = [RouteModel.fromJson(data)];
            return routes;
          } else {
            throw Exception('Data is null or empty');
          }
        } else {
          throw Exception(
              'Response does not contain "data" or is not a valid JSON object');
        }
      } else {
        throw ('error en la petición: ${response.statusCode}');
      }
    } catch (e) {
      throw ('El error es $e');
    }
  }

  @override
  void cancel() {
    if (cancelToken != null) {
      cancelToken!.cancel();
      cancelToken = null;
    }
  }
}

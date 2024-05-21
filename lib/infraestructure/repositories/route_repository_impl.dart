import 'dart:convert';

import 'package:rabbit_go/domain/models/Route/repositories/route_repository.dart';
import 'package:rabbit_go/domain/models/Route/route.dart';
import 'package:http/http.dart' as http;

class RouteRepositoryImpl implements RouteRepository {
  @override
  Future<List<RouteModel>> getAllRoutes(String token) async {
    try {
      String url = ('https://rabbitgo.sytes.net/bus/route/time/18:00');

      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': token, 'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey('data')) {
          List<dynamic> routeJson = jsonResponse['data'];
          List<RouteModel> routes =
              routeJson.map((route) => RouteModel.fromJson(route)).toList();
          return routes;
        } else {
          throw Exception('Response does not contain "data"');
        }
      } else {
        throw ('error en la petición: ${response.statusCode}');
      }
    } catch (e) {
      throw ('el error es $e');
    }
  }

  @override
  Future<void> deleteRouteById(String? token, String? id) async {
    try {
      String url = ('https://rabbitgo.sytes.net/bus/route/$id');
      final response = await http.delete(
        Uri.parse(url),
        headers: {'Authorization': token!, 'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        print('Ruta Borrada Correctamente');
      } else {
        print('No se pudo borrar la ruta');
      }
    } catch (e) {
      throw ('el error es $e');
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
    try {
      String url = ('https://rabbitgo.sytes.net/bus/route');
      final userData = {
        'name': routeName,
        'price': routePrice,
        'startTime': routeStartTime,
        'endTime': routeEndTime,
        'busStopId': routeBusStop,
      };
      final response = await http.post(
        Uri.parse(url),
        headers: {'Authorization': token, 'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );
      if (response.statusCode == 200) {
        print('Ruta creada Correctamente');
      } else {
        print('No se pudo crear la ruta');
      }
    } catch (e) {
      throw ('el error es $e');
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
    try {
      String url = ('https://rabbitgo.sytes.net/bus/route/$id');
      final userData = {
        'name': routeName,
        'price': routePrice,
        'startTime': routeStartTime,
        'endTime': routeEndTime,
        'busStopId': routeBusStop,
      };
      final response = await http.put(
        Uri.parse(url),
        headers: {'Authorization': token, 'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );
      if (response.statusCode == 200) {
        print('Ruta actualizada Correctamente');
      } else {
        print('No se pudo actualizar la ruta');
      }
    } catch (e) {
      throw ('el error es $e');
    }
  }
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rabbit_go/domain/models/Route/repositories/route_repository.dart';
import 'package:rabbit_go/domain/models/Route/route.dart';
import 'package:http/http.dart' as http;

class ApiRouteRepository implements RouteRepository {
  CancelToken? cancelToken;
  final dio = Dio();

  @override
  void cancel() {
    if (cancelToken != null) {
      cancelToken!.cancel();
      cancelToken = null;
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
  Future<List<RouteModel>> getRouteByName(String? token, String query) async {
    try {
      Map<String, dynamic> headers = {
        "Content-Type": "application/json",
        "Authorization": token,
      };
      cancelToken = CancelToken();
      final response = await dio.get(
        'https://rabbitgo.sytes.net/bus/route/name/Ruta $query',
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

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rabbit_go/domain/models/Route/repositories/route_repository.dart';
import 'package:rabbit_go/domain/models/Route/route.dart';
import 'package:http/http.dart' as http;

class RouteRepositoryImpl implements RouteRepository {
  CancelToken? cancelToken;
  final dio = Dio();

  @override
  Future<List<RouteModel>> getAllRoutes(String token) async {
    try {
      final response = await http.get(
          Uri.parse('https://rabbitgo.sytes.net/bus/route/time/18:00'),
          headers: {'Authorization': token});

      if (response.statusCode == 200) {
        final List<dynamic> stopsJson = json.decode(response.body);
        final List<RouteModel> stops =
            stopsJson.map((json) => RouteModel.fromJson(json)).toList();
        return stops;
      } else {
        throw Exception('Error con el servidor: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error con el servidor: $error');
    }
  }

  @override
  Future<void> deleteRouteById(String token, String id) async {}

  @override
  Future<void> createBusRoute(
      String routeName,
      String routePrice,
      String routeStartTime,
      String routeEndTime,
      String routeBusStop,
      String token) async {}

  @override
  Future<void> updateBusRoute(
      String routeName,
      String routePrice,
      String routeStartTime,
      String routeEndTime,
      String routeBusStop,
      String token,
      String id) async {}

  @override
  Future<List<RouteModel>> getRouteByName(String token, String query) async {
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
  void cancel() {
    if (cancelToken != null) {
      cancelToken!.cancel();
      cancelToken = null;
    }
  }

  @override
  Future<List<RouteModel>> getRouteByBusStopId(
      String token, String busStopId) async {
    try {
      String url = ('https://rabbitgo.sytes.net/bus/route/at/$busStopId');

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
    } catch (error) {
      throw ('Error al conectar con el servidor: $error');
    }
  }

  @override
  Future<List<LatLng>> getRouteBusPath(String token, String busRouteId) async {
    try {
      List<LatLng> listCordinates = [];
      listCordinates.clear();
      String url = ('https://rabbitgo.sytes.net/path/route/$busRouteId');

      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': token, 'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        if (responseData != null && responseData['data'] != null) {
          final List<dynamic> data = responseData['data'];
          listCordinates = data.expand((element) {
            final path = element['path'] as List<dynamic>;
            return path.map((coord) => LatLng(coord[0], coord[1]));
          }).toList();
          return listCordinates;
        } else {
          throw ('Los datos recibidos de la API no son válidos.');
        }
      } else {
        throw ('Error en la respuesta del servidor: ${response.statusCode}');
      }
    } catch (error) {
      throw ('Error al conectar con el servidor: $error');
    }
  }
}

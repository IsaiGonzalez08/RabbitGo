import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rabbit_go/domain/models/Route/repositories/route_repository.dart';
import 'package:rabbit_go/domain/models/Route/route.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RouteRepositoryImpl implements RouteRepository {
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  Future<List<RouteModel>> getAllRoutes(String token) async {
    String? token = await getToken();
    try {
      final response = await http.get(
          Uri.parse('https://rabbitgo.sytes.net/bus/route/time/18:00'),
          headers: {'Authorization': token!});
      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedResponse = json.decode(response.body);
        final List<dynamic> routesJson = decodedResponse['data'];
        final List<RouteModel> routes =
            routesJson.map((json) => RouteModel.fromJson(json)).toList();
        return routes;
      } else {
        throw Exception('Error con el servidor: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error con el servidor: $error');
    }
  }

  @override
  Future<void> deleteRouteById(String token, String busRouteUuid) async {
    String? token = await getToken();
    print('El token es : $token');
    try {
      String url = 'https://rabbitgo.sytes.net/bus/route/$busRouteUuid';
      await http.delete(Uri.parse(url), headers: {'Authorization': token!});
    } catch (error) {
      throw ('Error al eliminar el usuario, $error');
    }
  }

  @override
  Future<void> createBusRoute(
      String routeName,
      String routePrice,
      String routeStartTime,
      String routeEndTime,
      String routeBusStopUuid,
      String token) async {
    String? token = await getToken();
    print('El token es : $token');
    try {
      final userData = {
        'name': routeName,
        'price': routePrice,
        'startTime': routeStartTime,
        'endTime': routeEndTime,
        'busStopId': routeBusStopUuid
      };
      final response = await http.post(
          Uri.parse('https://rabbitgo.sytes.net/bus/route'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': token!
          },
          body: jsonEncode(userData));
      if (response.statusCode == 201) {
        print('Ruta Creada Correctamente');
      } else {
        throw Exception('Error con el servidor: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error con el servidor: $error');
    }
  }

  @override
  Future<void> updateBusRoute(
      String routeUuid,
      String routeName,
      String routePrice,
      String routeStartTime,
      String routeEndTime,
      String routeBusStopUuid,
      String token) async {
    String? token = await getToken();
    print('El token desde impl es: $token');
    try {
      final userData = {
        'name': routeName,
        'price': routePrice,
        'startTime': routeStartTime,
        'endTime': routeEndTime,
        'busStopId': routeBusStopUuid
      };
      final response = await http.put(
          Uri.parse('https://rabbitgo.sytes.net/bus/route/$routeUuid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': token!
          },
          body: jsonEncode(userData));
      if (response.statusCode == 200) {
        print('Ruta Actualizada Correctamente');
      } else {
        throw Exception('Error con el servidor: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error con el servidor: $error');
    }
  }

  @override
  Future<List<RouteModel>> getRouteByBusStopId(
      String token, String busStopId) async {
    String? token = await getToken();
    try {
      String url = ('https://rabbitgo.sytes.net/bus/route/at/$busStopId');

      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': token!, 'Content-Type': 'application/json'},
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
    String? token = await getToken();
    try {
      List<LatLng> listCordinates = [];
      listCordinates.clear();
      String url = ('https://rabbitgo.sytes.net/path/route/$busRouteId');

      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': token!, 'Content-Type': 'application/json'},
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

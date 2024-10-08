import 'dart:convert';
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
          Uri.parse('https://rabbit-go.sytes.net/shuttle_mcs/shuttle'),
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
  Future<void> deleteRouteById(String busRouteUuid) async {
    String? token = await getToken();
    try {
      String url =
          'https://rabbit-go.sytes.net/shuttle_mcs/shuttle/$busRouteUuid';
      await http.delete(Uri.parse(url), headers: {'Authorization': token!});
    } catch (error) {
      throw ('Error al eliminar el usuario, $error');
    }
  }

  @override
  Future<void> createBusRoute(
      String routeName,
      int routePrice,
      String? routeStartTime,
      String? routeEndTime,
      List<String> colonies,
      List<String> shuttleStopId) async {
    String? token = await getToken();
    try {
      final userData = {
        'name': routeName,
        'price': routePrice,
        'colonies': colonies,
        'shuttleStopId': shuttleStopId,
        'shift': {'startTime': routeStartTime, 'endTime': routeEndTime}
      };
      final response = await http.post(
          Uri.parse('https://rabbit-go.sytes.net/shuttle_mcs/shuttle'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': token!
          },
          body: jsonEncode(userData));
      if (response.statusCode == 201) {
        final Map<String, dynamic> dataMap = jsonDecode(response.body);
        if (dataMap['status'] == 'success') {
          if (dataMap['data'].isEmpty) {
            print(
                'La creación de la ruta fue exitosa pero no se recibió información adicional.');
          } else {
            final routeData = dataMap['data'][0];
            print('Información adicional de la ruta: $routeData');
          }
        } else {
          throw Exception(
              'Respuesta del servidor no exitosa: ${dataMap['status']}');
        }
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
      int routePrice,
      String? routeStartTime,
      String? routeEndTime,
      List<String> colonies,
      List<String> shuttleStopId) async {
    String? token = await getToken();
    try {
      final userData = {
        'name': routeName,
        'price': routePrice,
        'colonies': colonies,
        'shuttleStopId': shuttleStopId,
        'shift': {
          'startTime': routeStartTime,
          'endTime': routeEndTime,
        }
      };
      await http.put(
          Uri.parse('https://rabbit-go.sytes.net/shuttle_mcs/shuttle/$routeUuid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': token!
          },
          body: jsonEncode(userData));
    } catch (error) {
      throw Exception('Error con el servidor: $error');
    }
  }

  @override
  Future<List<RouteModel>> getRouteByBusStopId(
      String token, String busStopId) async {
    String? token = await getToken();
    try {
      String url =
          ('https://rabbit-go.sytes.net/shuttle_mcs/shuttle/from/$busStopId');
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
}

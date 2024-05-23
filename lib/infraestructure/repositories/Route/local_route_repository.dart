import 'dart:convert';

import 'package:rabbit_go/domain/models/Route/route.dart';
import 'package:rabbit_go/infraestructure/repositories/Route/api_route_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalRouteRepository {
  static const String _pendingOperationsKey = 'pending_operations';

  Future<void> proccessPendingOperations(
      ApiRouteRepository apiRouteRepository, String token) async {
    final prefs = await SharedPreferences.getInstance();
    final pendingOperations = prefs.getStringList('pendingOperations');
    if (pendingOperations != null) {
      for (final operationsJson in pendingOperations) {
        final operation = json.decode(operationsJson);
        final action = operation['action'];
        if (action == 'create') {
          final routeName = operation['name'];
          final routeStartTime = operation['startTime'];
          final routeEndTime = operation['endTime'];
          final routePrice = operation['price'];
          final routeBusStop = operation['busStopId'];
          await apiRouteRepository.createBusRoute(routeName, routePrice,
              routeStartTime, routeEndTime, routeBusStop, token);
        } else if (action == 'update') {
          final id = operation['uuid'];
          final routeName = operation['name'];
          final routeStartTime = operation['startTime'];
          final routeEndTime = operation['endTime'];
          final routePrice = operation['price'];
          final routeBusStop = operation['busStopId'];
          await apiRouteRepository.updateBusRoute(routeName, routePrice,
              routeStartTime, routeEndTime, routeBusStop, token, id);
        } else if (action == 'delete') {
          final id = operation['uuid'];
          await apiRouteRepository.deleteRouteById(token, id);
        }
      }
      await prefs.remove('pendingOperations');
    }
  }

  Future<void> savePendingOperations(Map<String, dynamic> operation) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> pendingOperations =
        prefs.getStringList(_pendingOperationsKey) ?? [];
    pendingOperations.add(json.encode(operation));
    await prefs.setStringList(_pendingOperationsKey, pendingOperations);
  }

  Future<List> getPendingOperations() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? pendingOperations =
        prefs.getStringList(_pendingOperationsKey);
    if (pendingOperations != null) {
      return pendingOperations
          .map((operation) => json.decode(operation))
          .toList();
    } else {
      return [];
    }
  }

  Future<List<RouteModel>> getAllRoutes(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final String? routesString = prefs.getString('routes');
    if (routesString != null) {
      final List<dynamic> routesJson = json.decode(routesString);
      return routesJson
          .map((routeJson) => RouteModel.fromJson(routeJson)).toList();
    } else {
      return [];
    }
  }

  Future<void> saveRoutesLocally(List<RouteModel> routes) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> routesJson =
        routes.map((route) => json.encode(route.toJson())).toList();
    await prefs.setStringList('routes', routesJson);
  }

  Future<void> deleteRoutesLocally(String routeId) async {
  final prefs = await SharedPreferences.getInstance();
  final String? routesString = prefs.getString('routes');
  
  if (routesString != null) {
    // Decodificar la cadena JSON a una lista de mapas
    final List<dynamic> routesJson = json.decode(routesString);

    // Realizar un casting explícito
    final List<Map<String, dynamic>> routes = 
        List<Map<String, dynamic>>.from(routesJson);

    // Filtrar las rutas para eliminar la que tiene el ID proporcionado
    final List<Map<String, dynamic>> updatedRoutes = 
        routes.where((route) => route['id'] != routeId).toList();

    // Codificar de nuevo las rutas actualizadas como una cadena JSON
    final String updatedRoutesJson = json.encode(updatedRoutes);

    // Guardar la cadena JSON actualizada en SharedPreferences
    await prefs.setString('routes', updatedRoutesJson);
    
    print('Route deleted locally');
  }
}

  Future<void> createRoutesLocally(RouteModel route) async {
    final prefs = await SharedPreferences.getInstance();
    final String? routesString = prefs.getString('routes');
    if (routesString != null) {
      final List<dynamic> routesJson = json.decode(routesString);
      routesJson.add(route.toJson());
      final createRoutesJson =
          routesJson.map((routes) => json.encode(routes)).toList();
      await prefs.setStringList('routes', createRoutesJson);
    }
  }

  Future<void> updateRoutesLocally(RouteModel updatedRoute) async {
    final prefs = await SharedPreferences.getInstance();
    final String? routesString = prefs.getString('routes');
    if (routesString != null) {
      final List<dynamic> routesJson = json.decode(routesString);
      final updatedRoutes = routesJson.map((route) {
        if (route['uuid'] == updatedRoute.uuid) {
          return updatedRoute.toJson();
        }
      }).toList();
      final updatedRoutesJson =
          updatedRoutes.map((route) => json.encode(route)).toList();
      await prefs.setStringList('routes', updatedRoutesJson);
    }
  }

}

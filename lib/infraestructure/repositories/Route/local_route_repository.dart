import 'dart:convert';

import 'package:rabbit_go/domain/models/Route/route.dart';
import 'package:rabbit_go/infraestructure/repositories/Route/api_route_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalRouteRepository {
  static const String _pendingOperationsKey = 'pending_operations';

  Future<void> proccessPendingOperations(
      ApiRouteRepository apiRouteRepository, String token) async {
    final prefs = await SharedPreferences.getInstance();
    final pendingOperations = prefs.getStringList(_pendingOperationsKey);
    
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
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      print("SharedPreferences cleared");
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
    final List<String>? routesStringList = prefs.getStringList('routes');
    if (routesStringList != null) {
      final List<RouteModel> routes = routesStringList.map((routeString) {
        final Map<String, dynamic> routeJson = json.decode(routeString);
        print(RouteModel.fromJson(routeJson));
        return RouteModel.fromJson(routeJson);
      }).toList();
      print(routes);
      return routes;
    } else {
      print('No hay nada');
      return [];
    }
  }

  Future<void> deleteRoutesLocally(String routeId) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? routesStringList = prefs.getStringList('routes');

    if (routesStringList != null) {
      // Decodifica la lista de rutas
      final List<Map<String, dynamic>> routesJson =
          routesStringList.map((routeString) {
        return json.decode(routeString) as Map<String, dynamic>;
      }).toList();

      // Filtra la ruta que no coincide con el `routeId` proporcionado
      final List<Map<String, dynamic>> updatedRoutes =
          routesJson.where((route) {
        return route['uuid'] != routeId;
      }).toList();

      // Codifica la lista de rutas actualizada
      final List<String> updatedRoutesJson =
          updatedRoutes.map((route) => json.encode(route)).toList();

      // Guarda la lista actualizada de vuelta en `SharedPreferences`
      await prefs.setStringList('routes', updatedRoutesJson);
      print('Route deleted locally');
    }
  }

  Future<void> saveRoutesLocally(List<RouteModel> routes) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> routesJson =
        routes.map((route) => json.encode(route.toJson())).toList();
    await prefs.setStringList('routes', routesJson);
    print('Productos almacenados localmente: $routesJson');
  }

  Future<void> createRoutesLocally(RouteModel route) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? routesStringList = prefs.getStringList('routes');

    // Verificar si routesStringList no es null y contiene datos
    if (routesStringList != null) {
      print('Existing routes found: $routesStringList');
    } else {
      print('No existing routes found, initializing new list.');
    }

    // Decodificar las rutas existentes o inicializar una lista vacía si no existen
    final List<Map<String, dynamic>> routesJson = routesStringList != null
        ? routesStringList.map((routeString) {
            return json.decode(routeString) as Map<String, dynamic>;
          }).toList()
        : [];

    // Agregar la nueva ruta
    routesJson.add(route.toJson());
    print('New route added: ${route.toJson()}');

    // Codificar la lista actualizada de rutas
    final List<String> updatedRoutesJson =
        routesJson.map((route) => json.encode(route)).toList();
    print('Updated routes list: $updatedRoutesJson');

    // Guardar la lista actualizada de vuelta en `SharedPreferences`
    await prefs.setStringList('routes', updatedRoutesJson);

    // Confirmar si los datos se guardaron correctamente
    final List<String>? checkSavedRoutes = prefs.getStringList('routes');
    if (checkSavedRoutes != null && checkSavedRoutes.isNotEmpty) {
      print('Route created locally: $checkSavedRoutes');
    } else {
      print('Failed to save routes locally.');
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

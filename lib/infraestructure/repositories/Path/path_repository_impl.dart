import 'dart:convert';
import 'package:rabbit_go/domain/models/Path/path.dart';
import 'package:rabbit_go/domain/models/Path/repository/path_repository.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PathRepositoryImpl implements PathRepository {
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  Future<List<PathModel>> getRoutePaths(String busRouteId) async {
    try {
      String? token = await getToken();
      String url =
          'https://rabbit-go.sytes.net/shuttle_mcs/shuttleRoute/byShuttle/$busRouteId';
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': token!, 'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        if (responseData != null && responseData['data'] != null) {
          List<dynamic> pathList = responseData['data'];
          List<PathModel> paths = [];
          for (var pathJson in pathList) {
            PathModel path = PathModel.fromJson(pathJson);
            paths.add(path);
          }
          return paths;
        } else {
          throw Exception('Los datos recibidos de la API no son válidos.');
        }
      } else {
        throw Exception(
            'Error en la respuesta del servidor: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error al conectar con el servidor: $error');
    }
  }
}

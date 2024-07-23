import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rabbit_go/domain/models/Stop/repositories/stop_repository.dart';
import 'package:rabbit_go/domain/models/Stop/stop.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StopRepositoryImpl implements StopRepository {
  @override
  Future<List<Stop>> getAllBusStops() async {
    Future<String?> getToken() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('token');
    }
    String? token = await getToken();
    try {
      final response = await http.get(
        Uri.parse('https://rabbit-go.sytes.net/shuttle_mcs/shuttleStop'),
        headers: {'Authorization': token!},
      );
      if (response.statusCode == 200) {
        final decodedResponse =
            json.decode(response.body) as Map<String, dynamic>;
        final stopsJson = decodedResponse['data'] as List<dynamic>;
        final stops = stopsJson.map((json) => Stop.fromJson(json)).toList();
        return stops;
      } else {
        throw Exception('Error con el servidor: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error con el servidor: $error');
    }
  }
}

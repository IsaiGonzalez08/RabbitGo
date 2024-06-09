import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rabbit_go/domain/models/Stop/repositories/stop_repository.dart';
import 'package:rabbit_go/domain/models/Stop/stop.dart';

class StopRepositoryImpl implements StopRepository {
  @override
  Future<List<Stop>> getAllBusStops(String? token) async {
    try {
      final response = await http.get(
          Uri.parse('https://rabbitgo.sytes.net/bus/stop/'),
          headers: {'Authorization': token!});
      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedResponse = json.decode(response.body);
        final List<dynamic> stopsJson = decodedResponse['data'];
        final List<Stop> stops =
            stopsJson.map((json) => Stop.fromJson(json)).toList();
        return stops;
      } else {
        throw Exception('Error con el servidor: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error con el servidor: $error');
    }
  }
}

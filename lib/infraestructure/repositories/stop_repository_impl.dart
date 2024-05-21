import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rabbit_go/domain/models/Stop/repositories/stop_repository.dart';
import 'package:rabbit_go/domain/models/Stop/stop.dart';

class StopRepositoryImpl implements StopRepository {
  @override
    Future<List<Stop>> getAllBusStops(String token) async {
    try {
      String url = ('https://rabbitgo.sytes.net/bus/stop/');

      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': token, 'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey('data')) {
          List<dynamic> stopJson = jsonResponse['data'];
          List<Stop> stops =
              stopJson.map((route) => Stop.fromJson(route)).toList();
          return stops;
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
}
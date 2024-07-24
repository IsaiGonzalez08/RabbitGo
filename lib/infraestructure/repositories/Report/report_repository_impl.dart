import 'dart:convert';

import 'package:rabbit_go/domain/models/Report/report.dart';
import 'package:rabbit_go/domain/models/Report/repository/report_repository.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReportRepositoryImpl implements ReportRepository {
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  Future<ReportModel> analizeTextReport(String text) async {
    String? token = await getToken();
    try {
      final analize = {
        'text': text,
      };
      final response = await http.post(
          Uri.parse('https://rabbit-go.sytes.net/tm/analyze'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': token!
          },
          body: jsonEncode(analize));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ReportModel.fromJson(data);
      } else {
        throw Exception('Error con el servidor: ${response.statusCode}');
      }
    } catch (error) {
      throw ('El error es: $error');
    }
  }

  @override
  Future<bool> createComplaint(String userId, String complaint, double score,
      int stars, List categories) async {
    String? token = await getToken();
    try {
      final reportData = {
        'userId': userId,
        'type': 'Received',
        'complaint': complaint,
        'score': score,
        'stars': stars,
        'categories': categories
      };
      final response = await http.post(
          Uri.parse('https://rabbit-go.sytes.net/report_mcs/complaint'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': token!
          },
          body: jsonEncode(reportData));
      if (response.statusCode == 201) {
        print('Reporte creado correctamente');
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw ('El error es: $error');
    }
  }
}

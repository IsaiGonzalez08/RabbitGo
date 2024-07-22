import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rabbit_go/domain/models/Results/repository/results_repository.dart';
import 'package:rabbit_go/domain/models/Results/results.dart';

class ResultsRepositoryImpl implements ResultsRepository {
  final _dio = Dio();
  final String token = dotenv.env['HERE_MAPS_API_TOKEN'] ?? '';

  @override
  Future<List<ResultsModel>> getTrafficResults(String coordinatesEncoded) async {
    try {
      final response = await _dio.get(
        'https://data.traffic.hereapi.com/v7/flow',
        queryParameters: {
          "apiKey": token,
          "in": "corridor:$coordinatesEncoded;r=100",
          "locationReferencing": "none"
        },
      );
      if (response.data['results'] != null &&
          response.data['results'].isNotEmpty) {
        List<ResultsModel> results = (response.data['results'] as List)
            .map((result) => ResultsModel.fromJson(result))
            .toList();
        return results;
      } else {
        throw ('No se encontraron resultados para la ubicación proporcionada');
      }
    } catch (e) {
      throw Exception('El error es: $e');
    }
  }
}

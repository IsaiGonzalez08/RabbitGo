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
        throw Exception('No se encontraron resultados para la ubicación proporcionada');
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode != null) {
        if (e.response!.statusCode! >= 400 && e.response!.statusCode! < 500) {
          throw Exception('Error del cliente: ${e.response!.statusCode}');
        } else if (e.response!.statusCode! >= 500) {
          throw Exception('Error del servidor: ${e.response!.statusCode}');
        }
      } else {
        throw Exception('Error de red: ${e.message}');
      }
    } catch (e) {
      throw Exception('El error es: $e');
    }
    // Agregar un throw al final para cubrir todos los casos
    throw Exception('Error desconocido');
  }
}

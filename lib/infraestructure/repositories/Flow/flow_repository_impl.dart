import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rabbit_go/domain/models/Flow/flow.dart';
import 'package:rabbit_go/domain/models/Flow/repository/flow_repository.dart';

class FlowRepositoryImpl implements FlowRepository {
  final _dio = Dio();
  final String token = dotenv.env['HERE_MAPS_API_TOKEN'] ?? '';

  @override
  Future<List<FlowModel>> getTrafficFlow(String coordinatesEncoded) async {
    try {
      final response = await _dio.get(
        'https://data.traffic.hereapi.com/v7/flow',
        queryParameters: {
          "apiKey": token,
          "in": "corridor:$coordinatesEncoded;r=20",
          "locationReferencing": "none"
        },
      );
      if (response.data['results'] != null &&
          response.data['results'].isNotEmpty) {
        List<FlowModel> flows = (response.data['results'] as List)
            .map((result) => FlowModel.fromJson(result['currentFlow']))
            .toList();
        return flows;
      } else {
        throw ('No se encontraron direcciones para la ubicación proporcionada');
      }
    } catch (e) {
      throw ('el error es $e');
    }
  }
}

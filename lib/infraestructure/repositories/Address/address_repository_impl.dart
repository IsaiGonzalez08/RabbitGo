import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rabbit_go/domain/models/Address/address.dart';
import 'package:rabbit_go/domain/models/Address/repositories/address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  final _dio = Dio();
  final String token = dotenv.env['HERE_MAPS_API_TOKEN'] ?? '';

  @override
  Future<Address> getAddress(String latitude, String longitude) async {
    try {
      final response = await _dio.get(
        'https://browse.search.hereapi.com/v1/browse',
        queryParameters: {"apiKey": token, "at": "$latitude,$longitude"},
      );
      if (response.data['items'] != null && response.data['items'].isNotEmpty) {
        final firstItem = response.data['items'][0];
        final address = Address.fromJson(firstItem);
        return address;
      } else {
        throw ('No se encontraron direcciones para la ubicación proporcionada');
      }
    } catch (e) {
      throw ('el error es $e');
    }
  }
}

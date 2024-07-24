import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rabbit_go/domain/models/Place/repositories/place_repository.dart';

class GetPlaceUseCase {
  final PlaceRepository _placeRepository;
  GetPlaceUseCase(this._placeRepository);

  Future<List<Marker>?> getPlaceByName(String query) async {
     return await _placeRepository.getPlaceByName(query);
  } 
  
}

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rabbit_go/domain/models/Place/repositories/place_repository.dart';

class GetPlaceUseCase {
  final PlaceRepository _placeRepository;
  GetPlaceUseCase(this._placeRepository);

  Future<List<Marker>?> onResults(String query) async {
     return await _placeRepository.onResults(query);
  } 
  
  void cancel() {
    _placeRepository.cancel();
  }
}

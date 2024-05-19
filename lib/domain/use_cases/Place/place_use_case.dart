import 'package:rabbit_go/domain/models/Place/gateway/place_gateway.dart';
import 'package:rabbit_go/domain/models/Place/place.dart';

import 'package:rabbit_go/infraestructure/api/place_api/place_api.dart';

class PlaceUseCase implements PlaceGateway {
  final PlaceAPI _placeAPI = PlaceAPI();
  PlaceUseCase();
  @override
  void cancel() {
    _placeAPI.cancel();
  }

  @override
  void dispose() {
    _placeAPI.dispose();
  }

  @override
  void find(String query) {
    _placeAPI.find(query);
  }

  @override
  Stream<List<Place>?> get onResults => _placeAPI.onResults;
}

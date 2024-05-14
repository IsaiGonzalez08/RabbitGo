import 'package:rabbit_go/domain/models/Place/place.dart';

abstract class PlaceGateway {
  Stream<List<Place>?> get onResults;
  void cancel();
  void dispose();
  void find(String query);
}

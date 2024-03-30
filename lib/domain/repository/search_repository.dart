import 'package:rabbit_go/domain/models/place.dart';

abstract class SearchRepository {
  Stream<List<Place>?> get onResults;
  void cancel();
  void dispose();
  void search(String query);
}

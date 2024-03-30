import 'package:rabbit_go/domain/api/search_place_api.dart';
import 'package:rabbit_go/domain/models/place.dart';
import 'package:rabbit_go/domain/repository/search_place_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchAPI _searchAPI;

  SearchRepositoryImpl(this._searchAPI);

  @override
  void search(String query) {
    _searchAPI.search(query);
  }

  @override
  void cancel() {
    _searchAPI.cancel();
  }

  @override
  void dispose() {
    _searchAPI.dispose();
  }

  @override
  Stream<List<Place>?> get onResults => _searchAPI.onResults;
}

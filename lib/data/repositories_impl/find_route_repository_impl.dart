import 'package:rabbit_go/domain/api/find_route_api.dart';
import 'package:rabbit_go/domain/models/route.dart';
import 'package:rabbit_go/domain/repository/find_route_repository.dart';

class FindRouteRepositoryImpl implements FindRouteRepository {
  final FindRouteAPI _findRouteAPI;

  FindRouteRepositoryImpl(this._findRouteAPI);

  @override
  void cancel() {
    _findRouteAPI.cancel();
  }

  @override
  void dispose() {
    _findRouteAPI.dispose();
  }

  @override
  void find(String query) {
    _findRouteAPI.find(query);
  }

  @override
  Stream<List<Route>?> get onResults => _findRouteAPI.onResults;
}

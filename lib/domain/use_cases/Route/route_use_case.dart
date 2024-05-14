import 'package:rabbit_go/domain/models/Route/gateway/route_gateway.dart';
import 'package:rabbit_go/domain/models/Route/route.dart';
import 'package:rabbit_go/infraestructure/api/route_api/route_api.dart';

class RouteUseCase implements RouteGateway {
  final RouteAPI _routeAPI;
  RouteUseCase(this._routeAPI);
  @override
  void cancel() {
    _routeAPI.cancel();
  }

  @override
  void dispose() {
    _routeAPI.dispose();
  }

  @override
  void find(String query) {
    _routeAPI.find(query);
  }

  @override
  Stream<List<RouteModel>?> get onResults => _routeAPI.onResults;
}

import 'package:rabbit_go/domain/models/Route/route.dart';

abstract class RouteGateway {
  Stream<List<RouteModel>?> get onResults;
  void cancel();
  void dispose();
  void find(String query);
}

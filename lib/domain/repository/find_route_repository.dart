import 'package:rabbit_go/domain/models/route.dart';

abstract class FindRouteRepository {
  Stream<List<Route>?> get onResults;
  void cancel();
  void dispose();
  void find(String query);
}

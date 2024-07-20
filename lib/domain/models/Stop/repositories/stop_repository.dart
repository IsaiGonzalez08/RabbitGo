import 'package:rabbit_go/domain/models/Stop/stop.dart';

abstract class StopRepository {
  Future<List<Stop>> getAllBusStops(String token);
}
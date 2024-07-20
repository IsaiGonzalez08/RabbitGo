import 'package:flutter/material.dart';
import 'package:rabbit_go/domain/models/Stop/repositories/stop_repository.dart';
import 'package:rabbit_go/domain/models/Stop/stop.dart';
import 'package:rabbit_go/infraestructure/repositories/Stop/stop_repository_impl.dart';

class BusStopProvider extends ChangeNotifier {
  final StopRepository _stopRepository = StopRepositoryImpl();

  List<Stop> _stops = [];
  List<Stop> get stops => _stops;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> getAllBusStops(String token) async {
    _loading = true;
    List<Stop> stops = await _stopRepository.getAllBusStops(token);
    _stops = stops;
    _loading = false;
    notifyListeners();
  }
}

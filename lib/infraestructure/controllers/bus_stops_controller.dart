import 'package:flutter/material.dart';

class BusStopController extends ChangeNotifier {
  String? id;

  void setDataBusStops(String? busStopId){
    id = busStopId;
    notifyListeners();
  }
}

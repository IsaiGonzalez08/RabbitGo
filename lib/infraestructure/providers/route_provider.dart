import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rabbit_go/domain/models/Route/route.dart';
import 'package:rabbit_go/domain/models/Route/gateway/route_gateway.dart';

class RouteProvider extends ChangeNotifier {
  List<RouteModel>? _routes = [];
  List<RouteModel>? get routes => _routes;
  RouteModel? _origin;
  RouteModel? get origin => _origin;
  final RouteGateway _routeGateway;
  late StreamSubscription _subscription;
  String _query = '';

  RouteProvider(this._routeGateway) {
    _subscription = _routeGateway.onResults.listen(
      (results) {
        _routes = results;
        notifyListeners();
      },
    );
  }

  String get query => _query;
  Timer? _debouncer;

  void queryChanged(String text) {
    _query = text;
    _debouncer?.cancel();
    _debouncer = Timer(const Duration(milliseconds: 200), () {
      if (_query.length >= 3) {
        _routeGateway.cancel();
        _routeGateway.find(query);
      } else {
        _routeGateway.cancel();
        _routes = [];
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _debouncer?.cancel();
    _subscription.cancel();
    _routeGateway.dispose();
    super.dispose();
  }
}

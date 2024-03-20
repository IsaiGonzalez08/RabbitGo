import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:permission_handler/permission_handler.dart';

class WaitController extends ChangeNotifier {
  final Permission _locationPermission;

  WaitController(this._locationPermission);

  Future<bool> checkPermission() async {
    final isGranted = await _locationPermission.isGranted;
    return isGranted;
  }
}

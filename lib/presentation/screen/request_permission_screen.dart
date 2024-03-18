import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rabbit_go/infraestructure/controllers/request_permission_controller.dart';
import 'package:rabbit_go/routes/routes.dart';

class MyRequestPermissionScreen extends StatefulWidget {
  const MyRequestPermissionScreen({super.key});

  @override
  State<MyRequestPermissionScreen> createState() =>
      _MyRequestPermissionScreenState();
}

class _MyRequestPermissionScreenState extends State<MyRequestPermissionScreen> {
  final _controller = RequestPermissionController(Permission.locationWhenInUse);
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = _controller.onStatusChanged.listen((status) {
      if (status == PermissionStatus.granted) {
        Navigator.pushReplacementNamed(context, Routes.TAPBAR);
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OutlinedButton(
            onPressed: () {
              _controller.request();
            },
            child: const Text('Permitir')),
      ),
    );
  }
}

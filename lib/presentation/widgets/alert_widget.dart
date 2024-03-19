import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rabbit_go/infraestructure/controllers/request_permission_controller.dart';

class MyAlertWidget extends StatefulWidget {
  const MyAlertWidget({super.key});

  @override
  State<MyAlertWidget> createState() => _MyAlertWidgetState();
}

class _MyAlertWidgetState extends State<MyAlertWidget> {
  final _controller = RequestPermissionController(Permission.locationWhenInUse);
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = _controller.onStatusChanged.listen((status) {
      if (status == PermissionStatus.granted) {
        return;
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
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'La aplicación necesita\n saber tú ubicación',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              _controller.request();
              Navigator.pop(context);
            },
            child: const Text('Continuar'),
          ),
        ],
      ),
    );
  }
}

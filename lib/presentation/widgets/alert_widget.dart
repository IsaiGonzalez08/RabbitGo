import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rabbit_go/presentation/providers/request_permission_controller.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';

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
      padding: const EdgeInsets.only(left: 30, right: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.0),
        image: const DecorationImage(
          image: AssetImage('assets/images/bg-bienvenida.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/AlertLocation.png',
            width: 200,
          ),
          const Text(
            'Activa tú ubicación',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 34.0,
              color: Color(0xFF3B3B3B),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Da los permisos necesarios para que la\naplicación funcione de la manera mas optima\npara brindarte la mejor experiencia.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.0,
              color: Color(0xFFBCBCBC),
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
            onPressed: () {
              _controller.request();
              Navigator.pop(context);
            },
            textButton: 'Activar',
            width: MediaQuery.of(context).size.width * 0.9,
            height: 40,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF01142B),
            colorText: const Color(0xFFFFFFFF),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Denegar acceso',
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF01142B),
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rabbit_go/infraestructure/controllers/wait_controller.dart';

class MyWaitScreen extends StatefulWidget {
  const MyWaitScreen({super.key});

  @override
  State<MyWaitScreen> createState() => _MyWaitScreenState();
}

class _MyWaitScreenState extends State<MyWaitScreen> {
  final _controller = WaitController(Permission.locationWhenInUse);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      _controller.checkPermission();
    });
    _controller.addListener(() {
      if (_controller.routeName != null) {
        Navigator.pushReplacementNamed(context, _controller.routeName!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

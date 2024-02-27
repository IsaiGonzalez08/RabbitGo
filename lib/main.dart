import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/screen/login_signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      lowerBound: 0.2,
      upperBound: 1.0,
    )..repeat(reverse: true);

    Timer(const Duration(seconds: 3), () {
      // Navega a la primera vista después de que se complete el temporizador
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MyLoginSignPage(
            title: 'MyLoginSingPage',
          ), // Reemplaza la pantalla de carga con la primera vista
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF01142B),
      body: Center(
        child: AnimatedOpacity(
          opacity: _controller.value,
          duration: const Duration(milliseconds: 500),
          child: Image.asset('assets/images/LogoRabbitGo1.png'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

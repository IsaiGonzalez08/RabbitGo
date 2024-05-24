import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/presentation/providers/connectivity_services.dart';
import 'package:rabbit_go/presentation/providers/place_provider.dart';
import 'package:rabbit_go/presentation/providers/route_coordinates_provider.dart';
import 'package:rabbit_go/presentation/providers/route_provider.dart';
import 'package:rabbit_go/presentation/providers/user_provider.dart';
import 'package:rabbit_go/infraestructure/helpers/themes.dart';
import 'package:rabbit_go/infraestructure/helpers/themes_provider.dart';
import 'package:rabbit_go/infraestructure/repositories/Route/api_route_repository.dart';
import 'package:rabbit_go/infraestructure/repositories/Route/local_route_repository.dart';
import 'package:rabbit_go/infraestructure/repositories/Route/route_repository_impl.dart';
import 'package:rabbit_go/presentation/screen/login_signup_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider()),
        ChangeNotifierProvider<RouteCoordinatesProvider>(
          create: (_) => RouteCoordinatesProvider(),
        ),
        ChangeNotifierProvider<PlaceProvider>(
          create: (context) => PlaceProvider(),
        ),
        ChangeNotifierProvider<RouteProvider>(
            create: (context) => RouteProvider(context)),
        ChangeNotifierProvider(create: (_)=> ConnectivityService()),
        Provider(create: (_) => ApiRouteRepository()),
        Provider(create: (_) => LocalRouteRepository()),
        ChangeNotifierProvider<RouteRepositoryImpl>(
          create: (context) => RouteRepositoryImpl(
            context, // Agrega el contexto aquí
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(lightTheme),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: const Color(0xFF01142B)),
              useMaterial3: true,
            ),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MyLoginSignPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF01142B),
      body: Center(
        child: SvgPicture.asset('assets/images/LogoRabbitGo1.svg'),
      ),
    );
  }
}

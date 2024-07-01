import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/presentation/providers/bus_stops_provider.dart';
import 'package:rabbit_go/presentation/providers/place_provider.dart';
import 'package:rabbit_go/presentation/providers/route_provider.dart';
import 'package:rabbit_go/presentation/providers/user_provider.dart';
import 'package:rabbit_go/presentation/screen/login_signup_screen.dart';
import 'package:rabbit_go/presentation/widgets/tapbar_admin.dart';
import 'package:rabbit_go/presentation/widgets/tapbar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  final String? token = prefs.getString('token');
  final String? rol = prefs.getString('rol');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider()),
        ChangeNotifierProvider<PlaceProvider>(
          create: (context) => PlaceProvider(),
        ),
        ChangeNotifierProvider<RouteProvider>(
            create: (context) => RouteProvider()),
        ChangeNotifierProvider<BusStopProvider>(
            create: (context) => BusStopProvider())
      ],
      child: MyApp(
        isLoggedIn: isLoggedIn,
        token: token,
        rol: rol,
      ),
    ),
  );
}

Future<void> checkDataExpiration(SharedPreferences prefs) async {
  final int? storedTimestamp = prefs.getInt('storedTimestamp');
  if (storedTimestamp != null) {
    final DateTime storedDate = DateTime.fromMillisecondsSinceEpoch(storedTimestamp);
    final DateTime now = DateTime.now();
    if (now.difference(storedDate).inDays > 30) {
      await prefs.clear();
    }
  }
}

Future<void> saveDataWithTimestamp(SharedPreferences prefs, String key, dynamic value) async {
  if (value is int) {
    await prefs.setInt(key, value);
  } else if (value is double) {
    await prefs.setDouble(key, value);
  } else if (value is bool) {
    await prefs.setBool(key, value);
  } else if (value is String) {
    await prefs.setString(key, value);
  } else if (value is List<String>) {
    await prefs.setStringList(key, value);
  }
  await prefs.setInt('storedTimestamp', DateTime.now().millisecondsSinceEpoch);
}

class MyApp extends StatelessWidget {
  final bool? isLoggedIn;
  final String? token;
  final String? rol;
  const MyApp(
      {Key? key, this.isLoggedIn, this.token, this.rol})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget homeScreen;
    if (isLoggedIn!) {
      if (rol == 'admin') {
        homeScreen = const MyTapBarAdminWidget();
      } else if (rol == 'user') {
        homeScreen = const MyTapBarWidget();
      } else {
        homeScreen = const SplashScreen();
      }
    } else {
      homeScreen = const SplashScreen();
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF01142B)),
        useMaterial3: true,
      ),
      home: homeScreen,
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

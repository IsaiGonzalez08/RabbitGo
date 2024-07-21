import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/domain/models/User/user.dart';
import 'package:rabbit_go/presentation/providers/bus_stops_provider.dart';
import 'package:rabbit_go/presentation/providers/route_provider.dart';
import 'package:rabbit_go/presentation/providers/user_provider.dart';
import 'package:rabbit_go/presentation/screen/configuration_screen.dart';
import 'package:rabbit_go/presentation/screen/favorite_route_screen.dart';
import 'package:rabbit_go/presentation/screen/home_screen.dart';
import 'package:rabbit_go/presentation/screen/find_route_screen.dart';
import 'package:rabbit_go/presentation/screen/suscription_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTapBarWidget extends StatefulWidget {
  const MyTapBarWidget({Key? key}) : super(key: key);

  @override
  State<MyTapBarWidget> createState() => _MyTapBarWidgetState();
}

class _MyTapBarWidgetState extends State<MyTapBarWidget> {
  int _currentIndex = 0;
  String? type;
  late User user;
  List<Widget> body = [const SizedBox.shrink()];
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeNavigation();
  }

  Future<void> _initializeNavigation() async {
    try {
      await _loadUserData();
      setState(() {
        body = [
          const MyHomeScreen(),
          const MyFindRouteScreen(),
          const MyFavoriteRoutesScreen(),
          const MyConfigurationScreen()
        ];
        isInitialized = true;
      });
    } catch (e) {
      throw ("Error en _initializeNavigation: $e");
    }
  }

  Future<void> _loadUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      type = prefs.getString('type') ?? 'unsubscribe';
      user = Provider.of<UserProvider>(context, listen: false).userData;
      type = user.type;
    } catch (e) {
      throw ("Error en _loadUserData: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      body: Center(
        child: body.isNotEmpty ? body[_currentIndex] : const SizedBox.shrink(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 24,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFFFFFFFF),
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          if (!Provider.of<BusStopProvider>(context, listen: false).loading &&
              !Provider.of<RouteProvider>(context, listen: false).loading) {
            if (newIndex == 2 && type != 'subscribe') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MySuscriptionScreen()));
            } else {
              setState(() {
                _currentIndex = newIndex;
              });
            }
          }
        },
        items: [
          BottomNavigationBarItem(
              label: 'Home',
              activeIcon: Image.asset(
                'assets/images/active_home.png',
                width: 24,
              ),
              icon: Image.asset(
                'assets/images/home.png',
                width: 24,
              )),
          BottomNavigationBarItem(
              label: 'Buscar',
              activeIcon: Image.asset(
                'assets/images/active_search.png',
                width: 24,
              ),
              icon: Image.asset(
                'assets/images/search.png',
                width: 24,
              )),
          BottomNavigationBarItem(
              label: 'Favoritos',
              activeIcon: Image.asset(
                'assets/images/active_favorite.png',
                width: 24,
              ),
              icon: Image.asset(
                'assets/images/favorite.png',
                width: 24,
              )),
          BottomNavigationBarItem(
              label: 'Configuración',
              activeIcon: Image.asset(
                'assets/images/active_settings.png',
                width: 24,
              ),
              icon: Image.asset(
                'assets/images/settings.png',
                width: 24,
              )),
        ],
        selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Color(0xFF01142B)),
        unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Color(0xFF979797)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rabbit_go/presentation/screen/admin_screen.dart';
import 'package:rabbit_go/presentation/screen/configuration_screen.dart';
import 'package:rabbit_go/presentation/screen/find_route_screen.dart';

class MyTapBarAdminWidget extends StatefulWidget {
  const MyTapBarAdminWidget({Key? key}) : super(key: key);

  @override
  State<MyTapBarAdminWidget> createState() => _MyTapBarAdminWidgetState();
}

class _MyTapBarAdminWidgetState extends State<MyTapBarAdminWidget> {
  int _currentIndex = 0;
  List<Widget> body = const [
    MyAdminScreen(),
    MyFindRouteScreen(),
    MyConfigurationScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: body[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
              label: 'Home',
              activeIcon: SvgPicture.asset('assets/images/home.svg'),
              icon: SvgPicture.asset('assets/images/homewhite.svg')),
          BottomNavigationBarItem(
            label: 'Agregar',
            activeIcon: SvgPicture.asset('assets/images/Add.png'),
            icon: SvgPicture.asset('assets/images/Add_active.png'),
          ),
          BottomNavigationBarItem(
              label: 'Buscar',
              activeIcon: SvgPicture.asset('assets/images/Search.png'),
              icon: SvgPicture.asset('assets/images/search_active.png')),
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

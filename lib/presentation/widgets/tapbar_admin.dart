import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rabbit_go/presentation/providers/bus_stops_provider.dart';
import 'package:rabbit_go/presentation/screen/admin_add_route_screen.dart';
import 'package:rabbit_go/presentation/screen/admin_find_route_screen.dart';
import 'package:rabbit_go/presentation/screen/admin_screen.dart';

import 'package:provider/provider.dart';
import 'package:rabbit_go/presentation/providers/route_provider.dart';

class MyTapBarAdminWidget extends StatefulWidget {
  const MyTapBarAdminWidget({Key? key}) : super(key: key);

  @override
  State<MyTapBarAdminWidget> createState() => _MyTapBarAdminWidgetState();
}

class _MyTapBarAdminWidgetState extends State<MyTapBarAdminWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> body = [
      const MyAdminScreen(),
      const MyAdminAddRouteScreen(),
      const MyAdminFindRouteScreen(),
    ];

    return Scaffold(
      body: Center(
        child: body[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          if (!Provider.of<RouteProvider>(context, listen: false).loading &&
              !Provider.of<BusStopProvider>(context, listen: false).loading) {
            setState(() {
              _currentIndex = newIndex;
            });
          } 
        },
        items: [
          BottomNavigationBarItem(
              label: 'Home',
              activeIcon: SvgPicture.asset('assets/images/home.svg'),
              icon: SvgPicture.asset('assets/images/homewhite.svg')),
          BottomNavigationBarItem(
            label: 'Agregar',
            activeIcon: Image.asset('assets/images/Add_active.png', width: 25),
            icon: Image.asset('assets/images/Add.png', width: 25),
          ),
          BottomNavigationBarItem(
              label: 'Buscar',
              activeIcon:
                  Image.asset('assets/images/search_active.png', width: 25),
              icon: Image.asset('assets/images/Search.png', width: 25)),
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

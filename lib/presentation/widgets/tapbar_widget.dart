import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rabbit_go/presentation/screen/configuration_screen.dart';
import 'package:rabbit_go/presentation/screen/home_screen.dart';

class MyTapBarWidget extends StatefulWidget {
  const MyTapBarWidget({super.key});

  @override
  State<MyTapBarWidget> createState() => _MyTapBarWidgetState();
}

class _MyTapBarWidgetState extends State<MyTapBarWidget> {
  int _currentIndex = 0;
  List<Widget> body = const [MyHomeScreen(), MyConfigurationScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: body[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
              label: 'Perfil',
              activeIcon: SvgPicture.asset('assets/images/profile2.svg'),
              icon: SvgPicture.asset('assets/images/profile.svg')),
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

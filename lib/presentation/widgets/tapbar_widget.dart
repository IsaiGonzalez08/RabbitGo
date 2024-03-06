import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rabbit_go/presentation/screen/configuration_screen.dart';
import 'package:rabbit_go/presentation/screen/home_screen.dart';

class TapBar extends StatelessWidget {
  const TapBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 10),
            height: 60,
            color: const Color(0xFFFFFFFF),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyHomeScreen(),
                          ),
                        );
                      },
                      child: SvgPicture.asset('assets/images/home.svg'),
                    ),
                    const Text(
                      'Home',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF979797),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 40),
                Column(
                  children: [
                    InkWell(
                        onTap: () {},
                        child: SvgPicture.asset('assets/images/love.svg')),
                    const Text(
                      'Favoritos',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF979797),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 40),
                Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: SvgPicture.asset('assets/images/marker.svg'),
                    ),
                    const Text(
                      'Marcar',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF979797),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 40),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyConfigurationScreen(),
                          ),
                        );
                      },
                      child: SvgPicture.asset('assets/images/profile.svg'),
                    ),
                    const Text(
                      'Perfil',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF979797),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

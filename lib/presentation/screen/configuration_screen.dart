import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/screen/general_screen.dart';
import 'package:rabbit_go/presentation/screen/login_signup_screen.dart';
import 'package:rabbit_go/presentation/screen/profile_screen.dart';
import 'package:rabbit_go/presentation/screen/suscription_screen.dart';
import 'package:rabbit_go/presentation/widgets/button_configuration_widget.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';
import 'package:rabbit_go/presentation/widgets/tapbar_widget.dart';

class MyConfigurationScreen extends StatelessWidget {
  const MyConfigurationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Configuración',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFB5B5B5),
                      fontSize: 14),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Victor Villava',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF737373),
                              fontSize: 18),
                        ),
                        Text(
                          'Prueba@gmail.com',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF737373),
                              fontSize: 14),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CustomButton(
                        textButton: 'Gratis',
                        width: 68,
                        height: 30,
                        fontSize: 14,
                        fontWeight: FontWeight.w800)
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                MyButtonConfigurationWidget(
                  text: 'Perfil',
                  space: 100,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyProfileScreen()));
                  },
                ),
                MyButtonConfigurationWidget(
                  space: 55,
                  text: 'Subscripción',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MySuscriptionScreen()));
                  },
                ),
                MyButtonConfigurationWidget(
                  space: 90,
                  text: 'General',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyGeneralScreen()));
                  },
                ),
              ],
            ),
          ),
          Column(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyLoginSignPage(
                                title: 'hola',
                              )),
                    );
                  },
                  child: SizedBox(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Cerrar sesión',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFFF7878),
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 180,
                        ),
                        Image.asset('assets/images/Logout.png'),
                        const Padding(padding: EdgeInsets.only(right: 10))
                      ],
                    ),
                  )),
              const Row(
                children: [
                  Expanded(
                    child: TapBar(),
                  ),
                ],
              ),
            ],
          ),
        ],
      )),
    );
  }
}

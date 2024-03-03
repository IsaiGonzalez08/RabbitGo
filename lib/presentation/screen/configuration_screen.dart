import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/screen/general_screen.dart';
import 'package:rabbit_go/presentation/screen/login_signup_screen.dart';
import 'package:rabbit_go/presentation/screen/profile_screen.dart';
import 'package:rabbit_go/presentation/screen/suscription_screen.dart';
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
        children: [
          const Padding(padding: EdgeInsets.only(top: 30)),
          const Center(
            child: Text(
              'Configuración',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFB5B5B5),
                  fontSize: 12),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            children: [
              Padding(padding: EdgeInsets.only(left: 20)),
              Column(
                children: [
                  Text(
                    'Victor Villava',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF737373),
                        fontSize: 16),
                  ),
                  Text(
                    'Prueba@gmail.com',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF737373),
                        fontSize: 10),
                  )
                ],
              ),
              SizedBox(
                width: 120,
              ),
              CustomButton(textButton: 'Gratis', width: 30, height: 30, fontSize: 12, fontWeight: FontWeight.w800)
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyProfileScreen()),
              );
            },
            child: Row(
              children: [
                const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 40, horizontal: 10)),
                const Text(
                  'Perfil',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6B6B6B)),
                ),
                const SizedBox(
                  width: 210,
                ),
                Image.asset('assets/images/Forward.png')
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MySuscriptionScreen()),
              );
            },
            child: Row(
              children: [
                const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 40, horizontal: 10)),
                const Text(
                  'Suscripción',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6B6B6B)),
                ),
                const SizedBox(
                  width: 170,
                ),
                Image.asset('assets/images/Forward.png')
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyGeneralScreen()),
              );
            },
            child: Row(
              children: [
                const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 40, horizontal: 10)),
                const Text(
                  'General',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6B6B6B)),
                ),
                const SizedBox(
                  width: 195,
                ),
                Image.asset('assets/images/Forward.png')
              ],
            ),
          ),
          const SizedBox(
            height: 163.8,
          ),
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
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Row(
                  children: [
                    const Text(
                      'Cerrar sesión',
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFFFF7878),
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      width: 171,
                    ),
                    Image.asset('assets/images/Logout.png')
                  ],
                )),
          ),
          const SizedBox(
            height: 79.5,
          ),
          const Row(
            children: [
              Expanded(
                child: TapBar(),
              ),
            ],
          ),
        ],
      )),
    );
  }
}

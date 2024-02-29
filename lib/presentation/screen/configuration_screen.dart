import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/screen/profile_screen.dart';
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
              CustomButton(
                textButton: 'Gratis',
                fontSize: 12,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                fontWeight: FontWeight.w800,
              )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 20)),
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
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyProfileScreen()),
                    );
                  },
                  child: Image.asset('assets/images/Forward.png'))
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 20)),
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
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 20)),
              const Text(
                'Configuración',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6B6B6B)),
              ),
              const SizedBox(
                width: 155,
              ),
              Image.asset('assets/images/Forward.png')
            ],
          ),
          const SizedBox(
            height: 210.8,
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

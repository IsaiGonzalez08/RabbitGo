import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/screen/configuration_screen.dart';

class MyGeneralScreen extends StatelessWidget {
  const MyGeneralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Padding(padding: EdgeInsets.only(top: 40)),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyConfigurationScreen()),
                    );
                  },
                  child: Image.asset('assets/images/ForwardProfile.png')),
              const SizedBox(
                width: 100,
              ),
              const Text(
                'General',
                style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFB5B5B5),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Container(
              padding: const EdgeInsets.only(left: 20, top: 40),
              child: const Text(
                'Notificaciones',
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B6B6B),
                    fontWeight: FontWeight.w600),
              )),
          Container(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Row(
              children: [
                const Text(
                  'Activar notificaciones de la app',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF949494),
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 60,
                ),
                Image.asset('assets/images/Switch.png')
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, top: 15),
            child: Row(
              children: [
                const Text(
                  'Mandar al correo notificaciones',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF949494),
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 60,
                ),
                Image.asset('assets/images/Switch.png'),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.only(left: 20, top: 40),
              child: const Text(
                'Tema',
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B6B6B),
                    fontWeight: FontWeight.w600),
              )),
          Container(
            padding: const EdgeInsets.only(left: 20, top: 15),
            child: Row(
              children: [
                const Text(
                  'Activar modo oscuro',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF949494),
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 120,
                ),
                Image.asset('assets/images/Switch.png'),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.only(left: 20, top: 40),
              child: const Text(
                'Ayuda y soporte',
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B6B6B),
                    fontWeight: FontWeight.w600),
              )),
          Container(
            padding: const EdgeInsets.only(left: 20, top: 15),
            child: Row(
              children: [
                const Text(
                  'Activar modo oscuro',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF949494),
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 130,
                ),
                Image.asset('assets/images/Forward.png'),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, top: 15),
            child: Row(
              children: [
                const Text(
                  'Términos del servicio',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF949494),
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 125,
                ),
                Image.asset('assets/images/Forward.png'),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, top: 15),
            child: Row(
              children: [
                const Text(
                  'Ajuste de privacidad',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF949494),
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 130,
                ),
                Image.asset('assets/images/Forward.png'),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

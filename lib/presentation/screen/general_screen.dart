import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/infraestructure/helpers/themes.dart';
import 'package:rabbit_go/infraestructure/helpers/themes_provider.dart';
import 'package:rabbit_go/presentation/widgets/switch_widget.dart';

class MyGeneralScreen extends StatelessWidget {
  const MyGeneralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(color: Color(0xFF979797)),
          title: const Text(
            'General',
            style: TextStyle(
                fontSize: 14,
                color: Color(0xFFB5B5B5),
                fontWeight: FontWeight.w600),
          ),
        ),
        body: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.1),
                  child: const Text(
                    'Notificaciones',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF6B6B6B),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Activar notificaciones de la app',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF949494),
                          fontWeight: FontWeight.w400),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.14)),
                    const MySwitchWidget()
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Mandar al correo notificaciones',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF949494),
                          fontWeight: FontWeight.w400),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.14)),
                    const MySwitchWidget()
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1),
                child: const Text(
                  'Tema',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF6B6B6B),
                      fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Activar modo oscuro',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF949494),
                        fontWeight: FontWeight.w400),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.3),
                  ),
                  Transform.scale(
                    scale: 0.6,
                    child: Switch(
                      activeColor: const Color(0xFFFFFFFF),
                      activeTrackColor: const Color(0xFF01142B),
                      value:
                          themeProvider.themeData.brightness == Brightness.dark,
                      onChanged: (value) {
                        if (value) {
                          themeProvider.setTheme(darkTheme);
                        } else {
                          themeProvider.setTheme(lightTheme);
                        }
                      },
                    ),
                  )
                ],
              ),
            ]),
            const SizedBox(
              height: 30,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1),
                child: const Text(
                  'Ayuda y Soporte',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF6B6B6B),
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.1),
                  ),
                  const Text(
                    'Política de privacidad',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF949494),
                        fontWeight: FontWeight.w400),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.34),
                  ),
                  Image.asset('assets/images/Forward.png')
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.1),
                  ),
                  const Text(
                    'Términos del servicio',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF949494),
                        fontWeight: FontWeight.w400),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.345),
                  ),
                  Image.asset('assets/images/Forward.png')
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.1),
                  ),
                  const Text(
                    'Ajuste de privacidad',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF949494),
                        fontWeight: FontWeight.w400),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.35),
                  ),
                  Image.asset('assets/images/Forward.png')
                ],
              ),
            ]),
          ],
        ),
      );
    });
  }
}

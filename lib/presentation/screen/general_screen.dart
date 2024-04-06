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
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.07),
                  child: const Text(
                    'Notificaciones',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF6B6B6B),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.07),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Activar notificaciones de la app',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF949494),
                            fontWeight: FontWeight.w400),
                      ),
                      MySwitchWidget()
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.07),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mandar al correo notificaciones',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF949494),
                            fontWeight: FontWeight.w400),
                      ),
                      MySwitchWidget()
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.07),
                child: const Text(
                  'Tema',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF6B6B6B),
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.07),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Activar modo oscuro',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF949494),
                          fontWeight: FontWeight.w400),
                    ),
                    Transform.scale(
                      scale: 0.6,
                      child: Switch(
                        activeColor: const Color(0xFFFFFFFF),
                        activeTrackColor: const Color(0xFF01142B),
                        value: themeProvider.themeData.brightness ==
                            Brightness.dark,
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
              ),
            ]),
            const SizedBox(
              height: 30,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.07),
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
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.07),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Política de privacidad',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF949494),
                            fontWeight: FontWeight.w400),
                      ),
                      Row(
                        children: [
                          Image.asset('assets/images/Forward.png'),
                          Padding(
                              padding: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width * 0.06))
                        ],
                      ),
                    ]),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.07),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Términos del servicio',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF949494),
                          fontWeight: FontWeight.w400),
                    ),
                    Row(
                      children: [
                        Image.asset('assets/images/Forward.png'),
                        Padding(
                            padding: EdgeInsets.only(
                                right:
                                    MediaQuery.of(context).size.width * 0.06))
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.07),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Ajuste de privacidad',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF949494),
                            fontWeight: FontWeight.w400),
                      ),
                      Row(
                        children: [
                          Image.asset('assets/images/Forward.png'),
                          Padding(
                              padding: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width * 0.06))
                        ],
                      ),
                    ]),
              ),
            ]),
          ],
        ),
      );
    });
  }
}

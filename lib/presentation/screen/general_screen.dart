import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/infraestructure/helpers/themes.dart';
import 'package:rabbit_go/infraestructure/helpers/themes_provider.dart';
import 'package:rabbit_go/presentation/screen/configuration_screen.dart';
import 'package:rabbit_go/presentation/widgets/switch_widget.dart';

class MyGeneralScreen extends StatelessWidget {
  const MyGeneralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xFF01142B)),
            useMaterial3: true,
          ),
          home: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 30)),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyConfigurationScreen(),
                          ),
                        );
                      },
                      child: Image.asset('assets/images/ForwardProfile.png'),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    const Text(
                      'General',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFB5B5B5),
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        'Notificaciones',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF6B6B6B),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      'Tema',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF6B6B6B),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'Activar modo oscuro',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF949494),
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(),
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
                ]),
                const SizedBox(
                  height: 30,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      'Ayuda y Soporte',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF6B6B6B),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(left: 30, top: 40)),
                      const Text(
                        'Política de privacidad',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF949494),
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        width: 135,
                      ),
                      Image.asset('assets/images/Forward.png')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(left: 30, top: 40)),
                      const Text(
                        'Términos del servicio',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF949494),
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        width: 137,
                      ),
                      Image.asset('assets/images/Forward.png')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(left: 30, top: 40)),
                      const Text(
                        'Ajuste de privacidad',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF949494),
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        width: 138,
                      ),
                      Image.asset('assets/images/Forward.png')
                    ],
                  ),
                ]),
              ],
            ),
          ));
    });
  }
}

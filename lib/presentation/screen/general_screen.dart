import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/infraestructure/helpers/themes.dart';
import 'package:rabbit_go/infraestructure/helpers/themes_provider.dart';
import 'package:rabbit_go/presentation/screen/status_account_screen.dart';
import 'package:rabbit_go/presentation/widgets/general_button_widget.dart';
import 'package:rabbit_go/presentation/widgets/general_seccion_title_widget.dart';
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const MyTitleGeneralWidget(title: 'Notificaciones'),
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
            const SizedBox(
              height: 30,
            ),
            const MyTitleGeneralWidget(title: 'Tema'),
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
            ),
            const SizedBox(
              height: 30,
            ),
            const MyTitleGeneralWidget(title: 'Ayuda y Soporte'),
            MyGeneralButton(onTap: () {}, subtitle: 'Política de privacidad'),
            MyGeneralButton(onTap: () {}, subtitle: 'Terminos del servicio'),
            MyGeneralButton(onTap: () {}, subtitle: 'Ajuste de privacidad'),
            const SizedBox(
              height: 30,
            ),
            const MyTitleGeneralWidget(title: 'Más información'),
            MyGeneralButton(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyStatusAccountScreen()));
                },
                subtitle: 'Estatus de cuenta')
          ],
        ),
      );
    });
  }
}

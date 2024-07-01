import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/screen/status_account_screen.dart';
import 'package:rabbit_go/presentation/widgets/general_button_widget.dart';
import 'package:rabbit_go/presentation/widgets/general_seccion_title_widget.dart';
import 'package:rabbit_go/presentation/widgets/switch_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class MyGeneralScreen extends StatelessWidget {
  const MyGeneralScreen({super.key});

  final String _url =
      'https://rabbitgopoliticasprivacidad.blogspot.com/p/rabbitgo-politicas-de-privacidad.html';

  Future<void> _launchURL() async {
    final url = Uri.parse(_url);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'No se pudo abrir $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/images/ForwardLeft.png',
            width: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
          const SizedBox(
            height: 30,
          ),
          const MyTitleGeneralWidget(title: 'Tema'),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.07),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Activar modo oscuro',
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
          const MyTitleGeneralWidget(title: 'Ayuda y Soporte'),
          MyGeneralButton(
              onTap: () {
                _launchURL();
              },
              subtitle: 'Política de privacidad'),
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
  }
}

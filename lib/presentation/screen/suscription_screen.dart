import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/screen/configuration_screen.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';

class MySuscriptionScreen extends StatelessWidget {
  const MySuscriptionScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg-bienvenida.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyConfigurationScreen(),
                    ),
                  );
                },
                child: Image.asset('assets/images/LeftArrow.png'),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Container(
              padding: const EdgeInsets.only(left: 126),
              child: Image.asset(
                'assets/images/Logo.png',
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 24),
              child: const Text(
                'Únete a la versión \nPremium, para disfrutar de \nlo mejor de RabbitGo.',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color(0xFF01142B),
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(left: 24),
              child: const Text(
                "Inicia hoy tu suscripción por \$20.00 y descubre los \ndiferentes beneficios que RabbitGo te ofrece.",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 11,
                  color: Color(
                    0xFF000000,
                  ),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(left: 24),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sin auncios",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Más funcionalidades",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Guardar rutas favoritas",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(left: 24),
              child: const CustomButton(
                  textButton: 'Continuar-Total \$20.00',
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}

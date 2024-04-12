import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';

class MySuscriptionScreen extends StatelessWidget {
  const MySuscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg-bienvenida.png'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 30, top: 20),
                child: Row(
                  children: [
                    Image.asset('assets/images/ForwardProfile.png'),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Column(
              children: [
                SvgPicture.asset('assets/images/Logo.svg'),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        text:
                            'Únete a la versión\nPremium, para disfrutar de\nlo mejor de',
                        style: TextStyle(
                            fontSize: 24,
                            color: Color(0XFF01142B),
                            fontWeight: FontWeight.w600),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' Rabbit',
                              style: TextStyle(fontWeight: FontWeight.w400)),
                          TextSpan(text: 'Go.'),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Inicia hoy tu suscripción por \$20.00 y descubre los \ndiferentes beneficios que RabbitGo te ofrece.',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '• Sin anuncios',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF01142B),
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '• Más funcionalidades',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF01142B),
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '• Guardar rutas favoritas',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF01142B),
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            CustomButton(
              textButton: 'Continuar - Total \$20.00',
              width: MediaQuery.of(context).size.width * 0.9,
              height: 40,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF01142B),
              colorText: const Color(0xFFFFFFFF),
            )
          ],
        ),
      ),
    );
  }
}

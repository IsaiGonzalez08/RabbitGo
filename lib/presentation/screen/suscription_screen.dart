import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/screen/login_screen.dart';
import 'package:rabbit_go/presentation/screen/signup_screen.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';

class MySuscriptionScreen extends StatelessWidget {
  const MySuscriptionScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 100),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg-bienvenida.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/Logo.png'),
              const Text(
                'Únete a la versión \nPremium, para disfrutar de \nlo mejor de RabbitGo.',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color(0xFF01142B),
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
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
              const SizedBox(height: 5),
              const Column(
                children: [

                ],
              ),
              const CustomButton(
                  textButton: 'Continuar-Total \$20.00',
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                  fontSize: 12,
                  fontWeight: FontWeight.w600)
            ],
          ),
        ),
      ),
    );
  }
}

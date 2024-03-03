import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/screen/login_screen.dart';
import 'package:rabbit_go/presentation/screen/signup_screen.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';

class MyLoginSignPage extends StatefulWidget {
  const MyLoginSignPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyLoginSignPage> createState() => _MyLoginPage();
}

class _MyLoginPage extends State<MyLoginSignPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 210),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '¡Bienvenido!',
                style: TextStyle(
                  color: Color(0xFF01142B),
                  fontWeight: FontWeight.w700,
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                '¿Listo para recorrer la ciudad?, inicia sesión para \ncomenzar.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF6C6C6C),
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 10),
              CustomButton(
                textButton: 'Tengo una cuenta',
                fontSize: 14,
                padding:
                    const EdgeInsets.symmetric(horizontal: 75, vertical: 10),
                fontWeight: FontWeight.w600,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyLoginScreen()),
                  );
                },
              ),
              const SizedBox(height: 5),
              const Text(
                'ó',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF979797),
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 5),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Material(
                  shape: Border.all(color: const Color(0xFFEBEBEB), width: 2),
                  color: const Color(0xFFFDFEFF),
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/Google.png'),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Continuar con Google',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF9F9F9F),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '¿Aún no tienes una cuenta?,',
                    style: TextStyle(
                      color: Color(0xFF6C6C6C),
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Flexible(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MySignUpScreen()),
                        );
                      },
                      child: const Text(
                        'Crea una cuenta ahora.',
                        style: TextStyle(
                          color: Color(0xFF01142B),
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

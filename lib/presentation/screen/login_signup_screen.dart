import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/screen/login_screen.dart';
import 'package:rabbit_go/presentation/screen/signup_screen.dart';

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
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                '¿Listo para recorrer la ciudad?, inicia sesión para \ncomenzar.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF6C6C6C),
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 235,
                height: 35,
                decoration: BoxDecoration(
                  color: const Color(0xFF01142B),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyLoginPage()),
                    );
                  },
                  child: const Text(
                    'Tengo una cuenta',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
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
              SizedBox(
                width: 235,
                height: 38,
                child: TextButton.icon(
                  onPressed: () {
                    // Acción al presionar el botón
                  },
                  icon: Image.asset(
                    'assets/images/Google.png',
                    width: 20,
                    height: 20,
                  ),
                  label: const Text(
                    'Continuar con Google',
                    style: TextStyle(
                      color: Color(0xFF9F9F9F),
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                    backgroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side:
                          const BorderSide(color: Color(0xFFEBEBEB), width: 2),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '¿Aún no tienes una cuenta?,',
                    style: TextStyle(
                      color: Color(0xFF6C6C6C),
                      fontWeight: FontWeight.w400,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Flexible(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MySignUpPage()),
                        );
                      },
                      child: const Text(
                        'Crea una cuenta ahora.',
                        style: TextStyle(
                          color: Color(0xFF01142B),
                          fontWeight: FontWeight.w800,
                          fontSize: 11,
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

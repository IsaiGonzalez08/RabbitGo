import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/screen/login_signup_screen.dart';

void main() => runApp(const MyLoginPage());

class MyLoginPage extends StatelessWidget {
  const MyLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const MyLoginSignPage(title: 'LoginSingPage')));
            },
            icon: Image.asset('assets/images/LeftArrow.png'),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Image.asset('assets/images/LoginLogo.png'),
              const SizedBox(height: 15),
              const Text(
                '¡Bienvenido de vuelta!',
                style: TextStyle(
                    color: Color(0xFF01142B),
                    fontWeight: FontWeight.w600,
                    fontSize: 22),
              )
            ],
          ),
        ),
      ),
    );
  }
}

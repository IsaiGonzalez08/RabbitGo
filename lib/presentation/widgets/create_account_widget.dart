import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/screen/signup_screen.dart';

class MyCreateAccountWidget extends StatelessWidget {
  const MyCreateAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '¿Aún no tienes una cuenta?,',
          style: TextStyle(
            color: Color(0xFF6C6C6C),
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 2),
        const SizedBox(
          width: 4,
        ),
        Flexible(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MySignUpScreen()),
              );
            },
            child: const Text(
              'Crea una cuenta ahora.',
              style: TextStyle(
                color: Color(0xFF01142B),
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ),
        )
      ],
    );
  }
}

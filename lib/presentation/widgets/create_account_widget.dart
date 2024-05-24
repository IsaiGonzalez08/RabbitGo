import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/screen/signup_screen.dart';

class MyCreateAccountWidget extends StatelessWidget {
  const MyCreateAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¿Aún no tienes una cuenta?,',
          style: TextStyle(
            color: const Color(0xFF6C6C6C),
            fontWeight: FontWeight.w400,
            fontSize: MediaQuery.of(context).size.width * 0.038,
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
            child: Text(
              'Crea una cuenta ahora.',
              style: TextStyle(
                color: const Color(0xFF01142B),
                fontWeight: FontWeight.w800,
                fontSize: MediaQuery.of(context).size.width * 0.038,
              ),
            ),
          ),
        )
      ],
    );
  }
}

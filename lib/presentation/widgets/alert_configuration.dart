import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/screen/login_signup_screen.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';

class MyAlertConfiguration extends StatelessWidget {
  const MyAlertConfiguration({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(10.0)),
          backgroundColor: const Color(0xFFFFFFFF),
          title: const Center(
            child: Text(
              textAlign: TextAlign.center,
              "¿Estas seguro que desear cerrar\n sesión?",
              style: TextStyle(
                  color: Color(0xFF777777),
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
          ),
          content: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textAlign: TextAlign.center,
                "Al cerrar sesión tu información será guardada\npero la próxima vez que quieras entrar\nnecesitaras iniciar sesión nuevamente.",
                style: TextStyle(
                    color: Color(0xFFACACAC),
                    fontSize: 11,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  width: MediaQuery.of(context).size.width * 0.29,
                  height: 35,
                  textButton: 'Cerrar sesión',
                  color: const Color(0xFF01142B),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyLoginSignPage()),
                    );
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomButton(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  width: MediaQuery.of(context).size.width * 0.29,
                  height: 35,
                  textButton: 'Cancelar',
                  color: const Color(0xFFB6B6B6),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          ],
        );
  }
}

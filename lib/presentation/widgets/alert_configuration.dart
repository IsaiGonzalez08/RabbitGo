import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/screen/login_signup_screen.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAlertConfiguration extends StatelessWidget {
  const MyAlertConfiguration({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateLogin() async {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MyLoginSignScreen()),
        (Route<dynamic> route) => false,
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('isLoggedIn');
      await prefs.remove('name');
      await prefs.remove('id');
      await prefs.remove('lastName');
      await prefs.remove('email');
      await prefs.remove('role');
      await prefs.remove('token');
      await prefs.remove('type');
      await prefs.remove('listShuttleId');
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(10.0)),
      backgroundColor: const Color(0xFFFFFFFF),
      title: const Center(
        child: Text(
          textAlign: TextAlign.center,
          "¿Estas seguro que deseas cerrar\n sesión?",
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
              colorText: const Color(0xFFFFFFFF),
              onPressed: () async {
                navigateLogin();
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
              colorText: const Color(0xFFFFFFFF),
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

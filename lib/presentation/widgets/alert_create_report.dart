import 'package:flutter/material.dart';

class MyAlertCreateReport extends StatelessWidget {
  const MyAlertCreateReport({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(10.0)),
      backgroundColor: const Color(0xFFFFFFFF),
      title: Center(child: Image.asset('assets/images/check_mark.png')),
      children: const [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              "¡Reporte creado con éxito!",
              style: TextStyle(
                  color: Color(0xFF01142B),
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ],
    );
  }
}

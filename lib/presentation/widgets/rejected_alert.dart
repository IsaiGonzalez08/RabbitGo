import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';

class MyRejectedAlert extends StatefulWidget {
  const MyRejectedAlert({super.key});

  @override
  State<MyRejectedAlert> createState() => _MyRejectedAlertState();
}

class _MyRejectedAlertState extends State<MyRejectedAlert> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(10.0)),
      backgroundColor: const Color(0xFFFFFFFF),
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              textAlign: TextAlign.center,
              "¡Fallo al crear el reporte!",
              style: TextStyle(
                  color: Color(0xFF01142B),
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              textAlign: TextAlign.center,
              "Module su lenguaje",
              style: TextStyle(
                  color: Color(0xFF01142B),
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 5,
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
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';

class MyAlertProblems extends StatefulWidget {
  const MyAlertProblems({super.key});

  @override
  State<MyAlertProblems> createState() => _MyAlertProblemsState();
}

class _MyAlertProblemsState extends State<MyAlertProblems> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(10.0)),
      backgroundColor: const Color(0xFFFFFFFF),
      title: const Center(
        child: Text(
          textAlign: TextAlign.center,
          "Estamos teniendo algunos incovenientes para obtener el estado del trafico, por favor intentelo más tarde.",
          style: TextStyle(
              color: Color(0xFF01142B),
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
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

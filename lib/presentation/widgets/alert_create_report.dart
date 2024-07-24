import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';

class MyAlertCreateReport extends StatefulWidget {
  final String name, routeId;
  final int price;
  final List<dynamic> colonies;
  final bool isFavorite;
  const MyAlertCreateReport(
      {super.key,
      required this.name,
      required this.routeId,
      required this.price,
      required this.colonies,
      required this.isFavorite});

  @override
  State<MyAlertCreateReport> createState() => _MyAlertCreateReportState();
}

class _MyAlertCreateReportState extends State<MyAlertCreateReport> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(10.0)),
      backgroundColor: const Color(0xFFFFFFFF),
      title: Center(child: Image.asset('assets/images/check_mark.png')),
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              textAlign: TextAlign.center,
              "¡Reporte creado con éxito!",
              style: TextStyle(
                  color: Color(0xFF01142B),
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
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

import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';

class MyAlertMarker extends StatelessWidget {
  const MyAlertMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.06,
                  vertical: MediaQuery.of(context).size.height * 0.04),
              child: const Row(
                children: [
                  Text(
                    'Rutas cercanas',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color(0xFF3B3B3B),
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            InkWell(
                child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.06),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/Bus.png'),
                      SizedBox(
                        width: 5,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ruta 100',
                            textAlign: TextAlign.start,
                          ),
                          Text('10:00-10:00')
                        ],
                      )
                    ],
                  ),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text('Costo'), Text('\$10.00')],
                  )
                ],
              ),
            )),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.width * 0.05),
          child: CustomButton(
            onPressed: () {
              Navigator.pop(context);
            },
            textButton: 'Comenzar',
            width: MediaQuery.of(context).size.width * 0.9,
            height: 40,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF01142B),
          ),
        ),
      ],
    );
  }
}

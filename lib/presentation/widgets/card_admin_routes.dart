import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';

class AdminCard extends StatelessWidget {
  final String uuid, name;

  const AdminCard({Key? key, required this.uuid, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.009),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ID',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              Text('Ruta',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
              Text('Acciones',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(uuid),
              Text(name),
              const CustomButton(
                  textButton: 'Modificar',
                  width: 75,
                  height: 30,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFEDEDED),
                  colorText: Color(0xFF3A3A3A))
            ],
          ),
        ],
      ),
    );
  }
}

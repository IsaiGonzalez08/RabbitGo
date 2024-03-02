import 'package:flutter/material.dart';

class SwitchExample extends StatefulWidget {
  const SwitchExample({Key? key}) : super(key: key);

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.7, // Puedes ajustar este valor según tus necesidades
      child: Switch(
        value: light,
        activeColor: const Color(0xFFFFFFFF),
        activeTrackColor: const Color(
            0xFF01142B), // Cambia el color de la pista cuando el switch está activo
        onChanged: (bool value) {
          // Esto se llama cuando el usuario cambia el interruptor.
          setState(() {
            light = value;
          });
        },
      ),
    );
  }
}

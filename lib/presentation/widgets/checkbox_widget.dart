import 'package:flutter/material.dart';

class MyCheckboxWidget extends StatelessWidget {
  const MyCheckboxWidget({super.key, this.onChanged, this.value});

  final void Function(bool?)? onChanged;
  final bool? value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.009)),
        Transform.scale(
          scale: 0.75, // Ajusta el tamaño del checkbox
          child: Checkbox(
            value: value,
            onChanged: onChanged,
          ),
        ), // Ajusta el espacio entre el checkbox y el texto
        const Flexible(
          child: Text(
            'Ocultar contraseña',
            style: TextStyle(
                fontSize: 12,
                color: Color(0xFF979797)), // Ajusta el tamaño del texto
          ),
        ),
      ],
    );
  }
}

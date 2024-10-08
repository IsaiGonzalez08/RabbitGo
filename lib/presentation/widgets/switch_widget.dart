import 'package:flutter/material.dart';

class MySwitchWidget extends StatefulWidget {
  const MySwitchWidget({Key? key}) : super(key: key);

  @override
  State<MySwitchWidget> createState() => _MySwitchWidgetState();
}

class _MySwitchWidgetState extends State<MySwitchWidget> {
  bool light = false;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.6,
      child: Switch(
        value: light,
        activeColor: const Color(0xFFFFFFFF),
        activeTrackColor: const Color(0xFF01142B),
        onChanged: (bool value) {
          setState(() {
            light = value;
          });
        },
      ),
    );
  }
}

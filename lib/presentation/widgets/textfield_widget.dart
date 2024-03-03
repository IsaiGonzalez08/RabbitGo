import 'package:flutter/material.dart';

class MyTextFieldWidget extends StatelessWidget {
  const MyTextFieldWidget({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        width: 320.0,
        height: 50.0,
        child: TextField(
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 22.0, horizontal: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: BorderSide.none,
            ),
            hintText: text,
            hintStyle: const TextStyle(
                fontSize: 12,
                color: Color(0xFFB8B8B8),
                fontWeight: FontWeight.w500),
            filled: true,
            fillColor: const Color(0xFFEDEDED),
          ),
        ),
      ),
    );
  }
}

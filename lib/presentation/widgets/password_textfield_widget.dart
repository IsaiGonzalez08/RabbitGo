import 'package:flutter/material.dart';

class MyPasswordTextFieldWidget extends StatelessWidget {
  const MyPasswordTextFieldWidget({
    Key? key,
    required this.text,
    required this.width,
    required this.controllerTextField,
    required this.validator,
    required this.obscureText,
    this.onChanged,
    this.onSaved,
  }) : super(key: key);
  final String text;
  final double width;
  final String? Function(String?)? validator;
  final TextEditingController controllerTextField;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        autocorrect: false,
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
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
        validator: validator,
        onSaved: onSaved,
        controller: controllerTextField,
        obscureText: obscureText,
      ),
    );
  }
}

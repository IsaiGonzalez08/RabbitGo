import 'package:flutter/material.dart';

class MyPasswordTextFieldWidget extends StatelessWidget {
  const MyPasswordTextFieldWidget({
    Key? key,
    required this.text,
    required this.passwordErrorText,
    required this.width,
    required this.controllerTextField,
    required this.validator,
    this.onSaved,
  }): super(key: key);
  final String text;
  final String? passwordErrorText;
  final double width;
  final String? Function(String?)? validator;
  final TextEditingController controllerTextField;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50.0,
      child: TextFormField(
        decoration: InputDecoration(
          errorText: passwordErrorText,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 22.0, horizontal: 15),
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
      ),
    );
  }
}
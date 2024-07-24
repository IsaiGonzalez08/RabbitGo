import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFieldWidget extends StatelessWidget {
  const MyTextFieldWidget({
    Key? key,
    this.text,
    this.textInput,
    required this.width,
    required this.controllerTextField,
    required this.validator,
    this.inputFormatters,
    this.keyboardType,
    this.onChanged,
    this.onSaved,
  }) : super(key: key);
  final String? text;
  final TextInputAction? textInput;
  final double width;
  final String? Function(String?)? validator;
  final TextEditingController controllerTextField;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        onChanged: onChanged,
        textInputAction: textInput,
        autocorrect: false,
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
      ),
    );
  }
}

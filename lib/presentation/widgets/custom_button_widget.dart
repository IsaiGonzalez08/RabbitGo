import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.textButton,
    required this.width,
    required this.height,
    required this.fontSize,
    required this.fontWeight,
    this.onPressed,
  }) : super(key: key);
  final String textButton;
  final double fontSize;
  final double width;
  final double height;
  final FontWeight fontWeight;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF01142B),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextButton(
        onPressed:
          onPressed,
        child: Text(
          textButton,
          style: TextStyle(
            color: Colors.white,
            fontWeight: fontWeight,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}

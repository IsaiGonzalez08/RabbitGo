import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.textButton,
    required this.padding,
    required this.fontSize,
    required this.fontWeight,
    this.onTap,
  }) : super(key: key);
  final String textButton;
  final double fontSize;
  final EdgeInsetsGeometry padding;
  final FontWeight fontWeight;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Material(
        color: const Color(0xFF01142B),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: Text(
              textButton,
              style: TextStyle(
                fontSize: fontSize,
                color: const Color(0XFFFFFFFF),
                fontWeight: fontWeight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

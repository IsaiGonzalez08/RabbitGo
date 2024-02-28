import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.textButton,
    required this.padding 

  }) : super(key: key);
  final String textButton;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Material(
        color: const Color(0xFF01142B),
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: padding,
            child: Text(
              textButton,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0XFFFFFFFF),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

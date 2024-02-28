import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Material(
        color: const Color(0xFF01142B),
        child: InkWell(
          onTap: () {},
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(
              'Gratis',
              style: TextStyle(
                  fontSize: 12,
                  color: Color(0XFFFFFFFF),
                  fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
    );
  }
}

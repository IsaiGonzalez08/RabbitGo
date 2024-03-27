import 'package:flutter/material.dart';

class MyButtonConfigurationWidget extends StatelessWidget {
  const MyButtonConfigurationWidget({
    Key? key,
    required this.text,
    required this.space,
    this.onTap,
  }) : super(key: key);
  final String text;
  final double space;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              text,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B6B6B)),
            ),
            SizedBox(
              width: space,
            ),
            Image.asset('assets/images/Forward.png')
          ],
        ),
      ),
    );
  }
}

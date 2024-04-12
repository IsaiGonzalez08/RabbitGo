import 'package:flutter/material.dart';

class MyTitleGeneralWidget extends StatelessWidget {
  const MyTitleGeneralWidget({super.key, required this.title});
    final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.07),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF6B6B6B),
            fontWeight: FontWeight.w600),
      ),
    );
  }
}

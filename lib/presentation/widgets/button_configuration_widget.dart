import 'package:flutter/material.dart';

class MyButtonConfigurationWidget extends StatelessWidget {
  const MyButtonConfigurationWidget({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);
  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 80,
        child: Padding(
          padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.07,
              left: MediaQuery.of(context).size.width * 0.07),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6B6B6B)),
              ),
              Image.asset('assets/images/Forward.png')
            ],
          ),
        ),
      ),
    );
  }
}

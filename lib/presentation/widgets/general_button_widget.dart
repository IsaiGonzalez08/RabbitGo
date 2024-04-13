import 'package:flutter/material.dart';

class MyGeneralButton extends StatelessWidget {
  const MyGeneralButton({
    super.key,
    required this.subtitle,
    this.onTap,
  });

  final String subtitle;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.07),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subtitle,
                style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF949494),
                    fontWeight: FontWeight.w400),
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/Forward.png',
                    width: 20,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.06))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

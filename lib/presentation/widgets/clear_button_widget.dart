import 'package:flutter/material.dart';

class ClearButton extends StatelessWidget {
  const ClearButton(
      {Key? key,
      required this.onTap,
      required this.buttonColor,
      required this.padding})
      : super(key: key);

  final void Function()? onTap;
  final Color? buttonColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: onTap,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: buttonColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/close.png',
                      width: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MyCardRouteWidget extends StatelessWidget {
  const MyCardRouteWidget({
    Key? key,
    required this.onTap,
    required this.routeName,
    required this.startTime,
    required this.endTime,
    required this.price
  }) : super(key: key);
  final void Function()? onTap;
  final String routeName;
  final String startTime;
  final String endTime;
  final int price;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.07,
        ),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFFEDEDED)))),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/Bus.png',
                  width: 50,
                ),
                const SizedBox(width: 5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      routeName,
                      style: const TextStyle(
                        color: Color(0xFF01142B),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '$startTime-$endTime',
                      style: const TextStyle(
                        color: Color(0xFF8B8B8B),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 50),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Text(
                      'Costo ',
                      style: TextStyle(
                        color: Color(0xFFAEAEAE),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '\$$price',
                      style: const TextStyle(
                        color: Color(0xFFAEAEAE),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MyButtonRoute extends StatelessWidget {
  const MyButtonRoute(
      {super.key,
      this.onTap,
      this.routeName,
      this.routeStartTime,
      this.routeEndTime,
      this.price,
      required this.isFavorite});
  final void Function()? onTap;
  final String? routeName;
  final String? routeStartTime;
  final String? routeEndTime;
  final int? price;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.07),
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Color(0xFFEDEDED), width: 1))),
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
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      routeName!,
                      style: const TextStyle(
                          color: Color(0xFF01142B),
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '$routeStartTime am -$routeEndTime pm',
                      style: const TextStyle(
                          color: Color(0xFF8B8B8B),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Precio:',
                    style: TextStyle(
                        color: Color(0xFF01142B),
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
                Text(
                  '\$$price',
                  style: const TextStyle(
                      color: Color(0xFF01142B),
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

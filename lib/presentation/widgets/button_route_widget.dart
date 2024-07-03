import 'package:flutter/material.dart';

class MyButtonRoute extends StatelessWidget {
  const MyButtonRoute(
      {super.key,
      this.onTap,
      this.routeName,
      this.routeStartTime,
      this.routeEndTime,
      this.onTapLikeButton,
      required this.isFavorite});
  final void Function()? onTap;
  final String? routeName;
  final String? routeStartTime;
  final String? routeEndTime;
  final void Function()? onTapLikeButton;
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
                      '$routeStartTime-$routeEndTime',
                      style: const TextStyle(
                          color: Color(0xFF8B8B8B),
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 15),
              child: InkWell(
                onTap: onTapLikeButton,
                child: Image.asset(
                  isFavorite
                      ? 'assets/images/favorite.png'
                      : 'assets/images/favorite-border.png',
                  width: 25,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

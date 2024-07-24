import 'package:flutter/material.dart';

class CardSearchFavorite extends StatelessWidget {
  const CardSearchFavorite({
    super.key,
    this.routeName,
    this.routeStartTime,
    this.routeEndTime,
    this.onTap
  });
  final void Function()? onTap;
  final String? routeName;
  final String? routeStartTime;
  final String? routeEndTime;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          InkWell(
            onTap: onTap,
            child: Image.asset(
              'assets/images/add_blue.png',
              width: 15,
            ),
          )
        ],
      ),
    );
  }
}

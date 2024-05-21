import 'package:flutter/material.dart';

class RouteCard extends StatelessWidget {
  final String name, startTime, endTime, price;
  final Function()? onEdit;
  final Function()? onDelete;

  const RouteCard(
      {Key? key,
      required this.name,
      required this.startTime,
      required this.endTime,
      required this.price,
      this.onEdit,
      this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.07,
          left: MediaQuery.of(context).size.width * 0.07),
      decoration: BoxDecoration(
          border: Border.all(
        color: const Color(0xFFF5F5F5),
        width: 2,
      )),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/Bus.png',
                width: 50,
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        color: Color(0xFF8D8D8D),
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '$startTime-$endTime',
                    style: const TextStyle(
                        color: Color(0xFFE0E0E0),
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            width: 50,
          ),
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
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '\$$price.00',
                    style: const TextStyle(
                        color: Color(0xFFAEAEAE),
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  InkWell(
                      onTap: onEdit,
                      child:
                          Image.asset('assets/images/Settings.png', width: 25)),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: onDelete,
                      child: Image.asset('assets/images/Delete.png', width: 25))
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

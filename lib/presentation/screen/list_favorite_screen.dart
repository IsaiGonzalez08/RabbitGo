import 'package:flutter/material.dart';

class MyListFavotiteScreen extends StatelessWidget {
  const MyListFavotiteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.07),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tus rutas marcadas',
                          style: TextStyle(
                              color: Color(0xFF01142B),
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '[Numero] rutas.',
                          style: TextStyle(
                              color: Color(0xFF979797),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/images/add_blue.png',
                      width: 20,
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: Color(0xFFF0EEEE),
            height: 2,
          )
        ],
      ),
    );
  }
}

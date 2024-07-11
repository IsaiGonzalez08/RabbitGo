import 'package:flutter/material.dart';

class MyListFavoriteRoute extends StatelessWidget {
  const MyListFavoriteRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        leadingWidth: double.infinity,
        backgroundColor: const Color(0xFFFFFFFF),
        automaticallyImplyLeading: true,
        toolbarHeight: 80,
        leading: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.08),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  'assets/images/arrow_back.png',
                  width: 20,
                ),
              ),
              Image.asset(
                'assets/images/more_vert.png',
                width: 5,
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '[Nombre de la lista]',
                      style: TextStyle(
                          color: Color(0xFF01142B),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    Image.asset(
                      'assets/images/add_blue.png',
                      width: 20,
                    )
                  ],
                ),
                const Text(
                  '[Numero] rutas.',
                  style: TextStyle(
                      color: Color(0xFF979797),
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
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

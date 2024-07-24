import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/screen/list_favorite_routes.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';

class MyAddListFavoriteScreen extends StatelessWidget {
  const MyAddListFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width * 0.4,
            horizontal: MediaQuery.of(context).size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Ponle nombre a tú lista',
              style: TextStyle(
                  color: Color(0xFF01142B),
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: const Color(0xFFE1E1E1))),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Nombre de tú lista.',
                  hintStyle: TextStyle(
                      color: Color(0xFF7D7D7D),
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  textButton: 'Cancelar',
                  width: MediaQuery.of(context).size.width * 0.44,
                  height: 40,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFFFFFFF),
                  colorText: const Color(0xFF01142B),
                  border: Border.all(color: const Color(0xFF01142B)),
                ),
                CustomButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyListFavoriteRoute()));
                  },
                  textButton: 'Crear',
                  width: MediaQuery.of(context).size.width * 0.44,
                  height: 40,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF01142B),
                  colorText: const Color(0xFFFFFFFF),
                  border: Border.all(color: const Color(0xFF01142B)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

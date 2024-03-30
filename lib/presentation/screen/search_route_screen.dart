import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/infraestructure/controllers/search_route_controller.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';

class MySearchRouteScreen extends StatelessWidget {
  const MySearchRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchRouteController(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: Color(0xFF979797)),
          toolbarHeight: MediaQuery.of(context).size.height * 0.14,
          title: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 40,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 1),
              )
            ]),
            child: Builder(builder: (context) {
              return TextField(
                onChanged: context.read<SearchRouteController>().onQueryChanged,
                textAlignVertical: TextAlignVertical.center,
                cursorHeight: 25.0,
                cursorColor: const Color(0xFF01142B),
                style: const TextStyle(
                    color: Color(0xFF01142B), fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Buscar ruta',
                  hintStyle: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFFE0E0E0),
                      fontWeight: FontWeight.w500),
                  filled: true,
                  fillColor: const Color(0xFFFFFFFF),
                  prefixIcon: Image.asset(
                    'assets/images/search.png',
                  ), // Icono dentro del campo de texto
                ),
              );
            }),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  textButton: 'Comenzar',
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 40,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF01142B),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/infraestructure/providers/route_provider.dart';

class MyAdminFindRouteScreen extends StatelessWidget {
  const MyAdminFindRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/images/ForwardLeft.png',
            width: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF979797)),
        title: const Text(
          'Buscar Ruta',
          style: TextStyle(
              fontSize: 14,
              color: Color(0xFFB5B5B5),
              fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
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
                      onChanged: context.read<RouteProvider>().queryChanged,
                      textAlignVertical: TextAlignVertical.center,
                      cursorHeight: 25.0,
                      cursorColor: const Color(0xFF01142B),
                      style: const TextStyle(
                          color: Color(0xFF01142B),
                          fontWeight: FontWeight.w500),
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
                          'assets/images/Search.png',
                          width: 20,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

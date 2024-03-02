import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/widgets/tapbar_widget.dart';

class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        body: Center(
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg-home.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 25),
                child: SizedBox(
                  width: 280.0,
                  height: 40.0,
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 18.0,
                        horizontal: 15.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Buscar ruta',
                      hintStyle: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFFE0E0E0),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFFFFFFF),
                      prefixIcon: Image.asset(
                        'assets/images/search.png',
                      ), // Icono dentro del campo de texto
                    ),
                  ),
                ),
              ),
              const Positioned(bottom: 0, left: 0, right: 0, child: TapBar()),
            ],
          ),
        ),
      ),
    );
  }
}

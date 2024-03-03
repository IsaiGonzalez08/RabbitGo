import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/screen/home_screen.dart';
import 'package:rabbit_go/presentation/screen/login_screen.dart';

class MySignUpScreen extends StatefulWidget {
  const MySignUpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MySignScreenState createState() => _MySignScreenState();
}

class _MySignScreenState extends State<MySignUpScreen> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
          appBar: AppBar(
            title: IconButton(
              padding: const EdgeInsets.only(top: 20),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyLoginScreen(),
                  ),
                );
              },
              icon: Image.asset('assets/images/LeftArrow.png'),
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'Ingresa tus datos',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF01142B),
                        fontSize: 24),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Recuerda colocar tus datos correctamente.',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF979797),
                        fontSize: 12),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      width: 320.0,
                      height: 50.0,
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 22.0, horizontal: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Nombre',
                          hintStyle: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFFB8B8B8),
                              fontWeight: FontWeight.w500),
                          filled: true,
                          fillColor: const Color(0xFFEDEDED),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      width: 320.0,
                      height: 50.0,
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 22.0, horizontal: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Correo Electrónico',
                          hintStyle: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFFB8B8B8),
                              fontWeight: FontWeight.w500),
                          filled: true,
                          fillColor: const Color(0xFFEDEDED),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      width: 320.0,
                      height: 50.0,
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 22.0, horizontal: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Contraseña',
                          hintStyle: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFFB8B8B8),
                              fontWeight: FontWeight.w500),
                          filled: true,
                          fillColor: const Color(0xFFEDEDED),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      width: 320.0,
                      height: 50.0,
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 22.0, horizontal: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Confirmar Contraseña',
                          hintStyle: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFFB8B8B8),
                              fontWeight: FontWeight.w500),
                          filled: true,
                          fillColor: const Color(0xFFEDEDED),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 10)),
                      Checkbox(
                        value: _isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value ?? false;
                          });
                        },
                      ),
                      const Flexible(
                          child: Text(
                        'Mostrar contraseña',
                        style:
                            TextStyle(fontSize: 11, color: Color(0xFF979797)),
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 20)),
                      Image.asset('assets/images/MarkYes.png'),
                      const SizedBox(width: 5),
                      const Text(
                        'Al registrarte aceptas todos los términos y condiciones \nde la aplicación.',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFC7C7C7),
                          fontSize: 10,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 25),
                  Container(
                    width: 320,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF01142B),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyHomeScreen()),
                        );
                      },
                      child: const Text(
                        'Comenzar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

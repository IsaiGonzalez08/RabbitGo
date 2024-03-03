import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/screen/home_screen.dart';
import 'package:rabbit_go/presentation/screen/login_signup_screen.dart';
import 'package:rabbit_go/presentation/screen/signup_screen.dart';

class MyLoginScreen extends StatefulWidget {
  const MyLoginScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyLoginScreenState createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {
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
                  builder: (context) =>
                      const MyLoginSignPage(title: 'LoginSingPage'),
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
                  height: 50,
                ),
                Image.asset(
                  'assets/images/LoginLogo.png',
                  width: 90,
                  height: 90,
                ),
                const SizedBox(height: 15),
                const Text(
                  '¡Bienvenido de vuelta!',
                  style: TextStyle(
                    color: Color(0xFF01142B),
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Ingresa tus datos para poder entrar.',
                  style: TextStyle(
                    color: Color(0xFF979797),
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
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
                            fontSize: 11,
                            color: Color(0xFFB8B8B8),
                            fontWeight: FontWeight.w500),
                        filled: true,
                        fillColor: const Color(0xFFEDEDED),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    Checkbox(
                      tristate: true,
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
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF979797),
                          fontWeight: FontWeight.w400),
                    ))
                  ],
                ),
                const SizedBox(height: 40),
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
                const SizedBox(height: 120),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '¿Aún no tienes una cuenta?,',
                      style: TextStyle(
                        color: Color(0xFF6C6C6C),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MySignUpScreen()),
                          );
                        },
                        child: const Text(
                          'Crea una cuenta ahora.',
                          style: TextStyle(
                            color: Color(0xFF01142B),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

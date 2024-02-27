import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/screen/login_signup_screen.dart';
import 'package:rabbit_go/presentation/screen/signup_screen.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: IconButton(
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
                Image.asset(
                  'assets/images/LoginLogo.png',
                  width: 70,
                  height: 70,
                ),
                const SizedBox(height: 15),
                const Text(
                  '¡Bienvenido de vuelta!',
                  style: TextStyle(
                    color: Color(0xFF01142B),
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
                const Text(
                  'Ingresa tus datos para poder entrar.',
                  style: TextStyle(
                    color: Color(0xFF979797),
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    width: 280.0,
                    height: 45.0,
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
                          fontSize: 11,
                          color: Color(0xFFB8B8B8),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFEDEDED),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    width: 280.0,
                    height: 45.0,
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
                        ),
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
                      style: TextStyle(fontSize: 11, color: Color(0xFF979797)),
                    ))
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: 235,
                  height: 35,
                  decoration: BoxDecoration(
                    color: const Color(0xFF01142B),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Comenzar',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Aún no tienes una cuenta?',
                      style: TextStyle(
                        color: Color(0xFF6C6C6C),
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MySignUpPage()),
                          );
                        },
                        child: const Text(
                          'Crea una cuenta ahora.',
                          style: TextStyle(
                            color: Color(0xFF01142B),
                            fontWeight: FontWeight.w800,
                            fontSize: 10,
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

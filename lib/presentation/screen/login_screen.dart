import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/screen/home_screen.dart';
import 'package:rabbit_go/presentation/screen/login_signup_screen.dart';
import 'package:rabbit_go/presentation/widgets/checkbox_widget.dart';
import 'package:rabbit_go/presentation/widgets/create_account_widget.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';
import 'package:rabbit_go/presentation/widgets/textfield_widget.dart';

class MyLoginScreen extends StatefulWidget {
  const MyLoginScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyLoginScreenState createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 35,
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
                const SizedBox(height: 20),
                const MyTextFieldWidget(text: 'Correo Electrónico'),
                const SizedBox(
                  height: 10,
                ),
                const MyTextFieldWidget(text: 'Contraseña'),
                const MyCheckboxWidget(),
                const SizedBox(height: 40),
                CustomButton(
                  textButton: 'Comenzar',
                  width: 320,
                  height: 40,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHomeScreen()));
                  },
                ),
                const SizedBox(height: 120),
                const MyCreateAccountWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

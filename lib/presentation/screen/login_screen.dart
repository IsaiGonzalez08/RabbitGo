import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rabbit_go/infraestructure/controllers/user_controller.dart';
import 'package:rabbit_go/presentation/screen/login_signup_screen.dart';
import 'package:rabbit_go/presentation/widgets/checkbox_widget.dart';
import 'package:rabbit_go/presentation/widgets/create_account_widget.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';
import 'package:rabbit_go/presentation/widgets/tapbar_widget.dart';
import 'package:rabbit_go/presentation/widgets/textfield_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MyLoginScreen extends StatefulWidget {
  const MyLoginScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyLoginScreenState createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? uuid;
  String? token;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese un email';
    }
    if (!EmailValidator.validate(value)) {
      return 'Por favor ingrese un email correcto';
    }
    return null;
  }

  void navigateTapBar() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyTapBarWidget()),
    );
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Por favor ingrese una contraseña";
    } else if (value.length < 6) {
      return "La contraseña debe tener al menos 6 caracteres";
    } else if (value.length > 15) {
      return "La contraseña no puede ser mayor a 15 caracteres";
    } else {
      return null;
    }
  }

  void provider(String uuid, String token) {
    Provider.of<UserData>(context, listen: false).setUserId(uuid, token);
  }

  Future<void> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        String url = 'http://rabbitgo.sytes.net/user/login';

        final userData = {
          'email': _emailController.text,
          'password': _passwordController.text,
        };

        final response = await http.post(
          Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(userData),
        );

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          final uuid = responseData['data']['uuid'];
          final token = responseData['data']['token'];
          provider(uuid, token);
          navigateTapBar();
        } else {
          print('Error en el login, Código de estado: ${response.statusCode}');
        }
      } catch (error) {
        print('Error al conectar con el servidor: $error');
      }
    }
  }

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
                  builder: (context) => const MyLoginSignPage(),
                ),
              );
            },
            icon: Image.asset('assets/images/LeftArrow.png'),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  SvgPicture.asset(
                    'assets/images/LoginLogo.svg',
                    width: 100,
                    height: 100,
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
                  MyTextFieldWidget(
                    width: 320,
                    text: 'Correo Electrónico',
                    controllerTextField: _emailController,
                    validator: (value) {
                      return validateEmail(value);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextFieldWidget(
                    width: 320,
                    controllerTextField: _passwordController,
                    text: 'Contraseña',
                    validator: (value) {
                      return validatePassword(value);
                    },
                  ),
                  const MyCheckboxWidget(),
                  const SizedBox(height: 40),
                  CustomButton(
                    textButton: 'Comenzar',
                    width: 320,
                    height: 40,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    onPressed: () {
                      _formKey.currentState!.save();
                      _loginUser();
                    },
                  ),
                  const SizedBox(height: 120),
                  const MyCreateAccountWidget()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

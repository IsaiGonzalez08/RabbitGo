import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rabbit_go/infraestructure/controllers/user_controller.dart';
import 'package:rabbit_go/presentation/widgets/checkbox_widget.dart';
import 'package:rabbit_go/presentation/widgets/create_account_widget.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';
import 'package:rabbit_go/presentation/widgets/password_textfield_widget.dart';
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
  bool _isEmailInValid = false;
  bool _isPasswordInValid = false;
  bool _showPassword = true;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese un email';
    }
    if (!EmailValidator.validate(value)) {
      return 'Por favor ingrese un email correcto';
    }
    if (_isEmailInValid) {
      return "El email no existe";
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
    } else if (_isPasswordInValid) {
      return "La contraseña no existe";
    } else {
      return null;
    }
  }

  void provider(String uuid, String token, String name, String lastname, String email) {
    Provider.of<UserData>(context, listen: false).setDataUser(uuid, token, name, lastname, email);
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
          final name = responseData['data']['name'];
          final lastname = responseData['data']['lastname'];
          final email = responseData['data']['email'];
          provider(uuid, token, name, lastname, email);
          navigateTapBar();
          setState(() {
            _isEmailInValid = false;
            _isPasswordInValid = false;
          });
        } else if (response.statusCode == 400) {
          setState(() {
            _isEmailInValid = true;
            _isPasswordInValid = true;
            _emailController.clear();
            _passwordController.clear();
          });
          _formKey.currentState?.validate();
        }
      } catch (error) {
        throw ('Error al conectar con el servidor: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.03)),
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
                    width: MediaQuery.of(context).size.width * 0.9,
                    text: 'Correo Electrónico',
                    controllerTextField: _emailController,
                    validator: (value) {
                      return validateEmail(value);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyPasswordTextFieldWidget(
                    width: MediaQuery.of(context).size.width * 0.9,
                    controllerTextField: _passwordController,
                    text: 'Contraseña',
                    validator: (value) {
                      return validatePassword(value);
                    },
                    obscureText: _showPassword,
                  ),
                  MyCheckboxWidget(
                    value: _showPassword,
                    onChanged: (value) {
                      setState(() {
                        _showPassword = value ?? true;
                      });
                    },
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                    textButton: 'Comenzar',
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 40,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF01142B),
                    onPressed: () {
                      _formKey.currentState!.save();
                      _loginUser();
                    },
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.09)),
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

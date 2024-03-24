import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/screen/login_screen.dart';
import 'package:rabbit_go/presentation/widgets/checkbox_widget.dart';
import 'package:rabbit_go/presentation/widgets/textfield_widget.dart';
import 'package:dio/dio.dart';
import 'package:rabbit_go/presentation/widgets/password_textfield_widget.dart';

class MySignUpScreen extends StatefulWidget {
  const MySignUpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MySignScreenState createState() => _MySignScreenState();
}

class _MySignScreenState extends State<MySignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? _passwordErrorText;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese un email';
    }
    if (!EmailValidator.validate(value)) {
      return 'Por favor ingrese un email correcto';
    }
    return null;
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

  void navigateLoginScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyLoginScreen()),
    );
  }

  Future<void> _createUser() async {
    Dio dio = Dio();
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        setState(() {
          _passwordErrorText = 'Las contraseñas no coinciden';
          return;
        });
      } else {
        try {
          String url = ('http://rabbitgo.sytes.net/user');

          final userData = {
            'name': _usernameController,
            'lastname': _lastnameController,
            'email': _emailController.text,
            'password': _passwordController.text,
          };

          final response = await dio.post(url, data: userData);

          if (response.statusCode == 201) {
          
            navigateLoginScreen();
          } else {
          }
        } catch (error) {
          print('Error al conectar con el servidor: $error');
        }
      }
      return;
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
                    builder: (context) => const MyLoginScreen(),
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
                      height: 10,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyTextFieldWidget(
                          text: 'Nombre(s)',
                          width: 155,
                          controllerTextField: _usernameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa un nombre de usuario';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        MyTextFieldWidget(
                          text: 'Apellidos',
                          width: 155,
                          controllerTextField: _lastnameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa un apellido';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextFieldWidget(
                      controllerTextField: _emailController,
                      width: 320,
                      text: 'Correo Eletcrónico',
                      validator: (value) {
                        return validateEmail(value);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyPasswordTextFieldWidget(
                      width: 320,
                      text: 'Contraseña',
                      passwordErrorText: _passwordErrorText,
                      controllerTextField: _passwordController,
                      validator: (value) {
                        return validatePassword(value);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyPasswordTextFieldWidget(
                      width: 320,
                      controllerTextField: _confirmPasswordController,
                      passwordErrorText: _passwordErrorText,
                      text: 'Confirmar contraseña',
                      validator: (value) {
                        return validatePassword(value);
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const MyCheckboxWidget(),
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
                            fontSize: 11,
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
                          _createUser();
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
            ),
          )),
    );
  }
}

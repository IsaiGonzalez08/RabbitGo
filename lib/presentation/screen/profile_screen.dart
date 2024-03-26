import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/infraestructure/controllers/user_controller.dart';
import 'package:rabbit_go/presentation/screen/configuration_screen.dart';
import 'package:rabbit_go/presentation/widgets/checkbox_widget.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';
import 'package:rabbit_go/presentation/widgets/textfield_widget.dart';
import 'package:rabbit_go/presentation/widgets/password_textfield_widget.dart';
import 'package:http/http.dart' as http;

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _showPassword = true;

  String? userId;
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

  @override
  void initState() {
    super.initState();
    userId = Provider.of<UserData>(context, listen: false).userId;
    token = Provider.of<UserData>(context, listen: false).token;
  }

  void navigateLoginScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyConfigurationScreen()),
    );
  }

  Future<void> _updateUser() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        return;
      } else {
        try {
          String url = ('http://rabbitgo.sytes.net/user/$userId');

          final userData = {
            'name': _usernameController.text,
            'lastname': _lastnameController.text,
            'email': _emailController.text,
            'password': _passwordController.text,
          };

          final response = await http.put(Uri.parse(url),
              headers: {
                'Authorization': token!,
                'Content-Type': 'application/json'
              },
              body: jsonEncode(userData));

          if (response.statusCode == 200) {
            navigateLoginScreen();
          } else {
            print('error en la petición: ${response.statusCode}');
          }
        } catch (error) {
          print('Error al conectar con el servidor: $error');
        }
      }
      return;
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(10.0)),
          backgroundColor: const Color(0xFFFFFFFF),
          title: const Center(
            child: Text(
              textAlign: TextAlign.center,
              "¿Estas seguro de\nactualizar tus datos?",
              style: TextStyle(
                  color: Color(0xFF777777),
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
          ),
          content: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Recuerda que tus datos personales son muy\nimportantes.",
                style: TextStyle(
                    color: Color(0xFFACACAC),
                    fontSize: 11,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  width: 105,
                  height: 30,
                  textButton: 'Actualizar',
                  onPressed: () {
                    _updateUser();
                  },
                ),
                CustomButton(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  width: 105,
                  height: 30,
                  textButton: 'Cancelar',
                  onPressed: () {
                    _updateUser();
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(padding: EdgeInsets.only(left: 20)),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const MyConfigurationScreen(),
                                ),
                              );
                            },
                            child:
                                Image.asset('assets/images/ForwardProfile.png'),
                          ),
                          const SizedBox(
                            width: 125,
                          ),
                          const Text(
                            'Perfil',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFFB5B5B5),
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset('assets/images/UserProfile.png'),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Nombre(s)',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF9A9A9A),
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              MyTextFieldWidget(
                                width: 155,
                                controllerTextField: _usernameController,
                                text: 'Nombre(s)',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor ingresa un nombre de usuario';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Apellidos',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF9A9A9A),
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              MyTextFieldWidget(
                                width: 155,
                                controllerTextField: _lastnameController,
                                text: 'Apellidos',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor ingresa un apellido';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Correo Electrónico',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF9A9A9A),
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          MyTextFieldWidget(
                            width: 320,
                            controllerTextField: _emailController,
                            text: 'Correo Electrónico',
                            validator: (value) {
                              return validateEmail(value);
                            },
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Contraseña',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF9A9A9A),
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          MyPasswordTextFieldWidget(
                            width: 320,
                            controllerTextField: _passwordController,
                            text: 'Contraseña',
                            validator: (value) {
                              return validatePassword(value);
                            },
                            obscureText: _showPassword,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Confirmar Contraseña',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF9A9A9A),
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          MyPasswordTextFieldWidget(
                            width: 320,
                            controllerTextField: _confirmPasswordController,
                            text: 'Confirmar Contraseña',
                            validator: (value) {
                              return validatePassword(value);
                            },
                            obscureText: _showPassword,
                          ),
                        ],
                      ),
                      MyCheckboxWidget(
                        value: _showPassword,
                        onChanged: (value) {
                          setState(() {
                            _showPassword = value ?? true;
                          });
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomButton(
                        textButton: 'Actualizar',
                        width: 320,
                        height: 40,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        onPressed: () {
                          _formKey.currentState!.save();
                          _showSuccessDialog();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

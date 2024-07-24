import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/presentation/providers/user_provider.dart';
import 'package:rabbit_go/presentation/screen/login_screen.dart';
import 'package:rabbit_go/presentation/widgets/checkbox_widget.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';
import 'package:rabbit_go/presentation/widgets/textfield_widget.dart';
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
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _showPassword = true;

  String? validateEmail(String? value) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese un email';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Por favor ingrese un email correcto';
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,16}$');
    if (value == null || value.isEmpty) {
      return "Por favor ingrese una contraseña";
    } else if (!passwordRegex.hasMatch(value)) {
      return "La contraseña debe tener entre 6 y 16 caracteres, e incluir al menos una letra mayúscula, una letra minúscula y un número.";
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
    final String name = _usernameController.text.trim();
    final String lastname = _lastnameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String confirmPassword = _confirmPasswordController.text.trim();

    if (_formKey.currentState!.validate()) {
      if (password != confirmPassword) {
        return;
      } else {
        await Provider.of<UserProvider>(context, listen: false).createUser(name, lastname, email, password);
      }
      _usernameController.clear();
      _lastnameController.clear();
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
      navigateLoginScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFFFFF),
          leading: IconButton(
            icon: Image.asset(
              'assets/images/LeftArrow.png',
              width: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
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
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Recuerda colocar tus datos correctamente.',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF979797),
                      fontSize: 12,
                    ),
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
                        width: MediaQuery.of(context).size.width * 0.442,
                        controllerTextField: _usernameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa un nombre de usuario';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      MyTextFieldWidget(
                        text: 'Apellidos',
                        width: MediaQuery.of(context).size.width * 0.442,
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
                    height: 15,
                  ),
                  MyTextFieldWidget(
                    controllerTextField: _emailController,
                    width: MediaQuery.of(context).size.width * 0.9,
                    text: 'Correo Electrónico',
                    validator: (value) {
                      return validateEmail(value?.trim());
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MyPasswordTextFieldWidget(
                    width: MediaQuery.of(context).size.width * 0.9,
                    text: 'Contraseña',
                    controllerTextField: _passwordController,
                    validator: (value) {
                      return validatePassword(value?.trim());
                    },
                    obscureText: _showPassword,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MyPasswordTextFieldWidget(
                    width: MediaQuery.of(context).size.width * 0.9,
                    controllerTextField: _confirmPasswordController,
                    text: 'Confirmar contraseña',
                    validator: (value) {
                      return validatePassword(value?.trim());
                    },
                    obscureText: _showPassword,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  MyCheckboxWidget(
                    value: _showPassword,
                    onChanged: (value) {
                      setState(() {
                        _showPassword = value ?? true;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.03,
                        ),
                      ),
                      Image.asset(
                        'assets/images/CheckmarkYes.png',
                        width: 15,
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'Al registrarte aceptas todos los términos y condiciones \nde la aplicación.',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFC7C7C7),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  CustomButton(
                    textButton: "Comenzar",
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 40,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF01142B),
                    colorText: const Color(0xFFFFFFFF),
                    onPressed: () {
                      _createUser();
                    },
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

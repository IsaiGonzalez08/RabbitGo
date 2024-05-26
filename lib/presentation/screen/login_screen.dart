import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rabbit_go/domain/models/User/user.dart';
import 'package:rabbit_go/presentation/providers/user_provider_2.dart';
import 'package:rabbit_go/presentation/widgets/checkbox_widget.dart';
import 'package:rabbit_go/presentation/widgets/create_account_widget.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';
import 'package:rabbit_go/presentation/widgets/password_textfield_widget.dart';
import 'package:rabbit_go/presentation/widgets/tapbar_admin.dart';
import 'package:rabbit_go/presentation/widgets/tapbar_widget.dart';
import 'package:rabbit_go/presentation/widgets/textfield_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';

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

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Por favor ingrese una contraseña";
    } else if (value.length < 4) {
      return "La contraseña debe tener al menos 4 caracteres";
    } else if (value.length > 15) {
      return "La contraseña no puede ser mayor a 15 caracteres";
    } else if (_isPasswordInValid) {
      return "La contraseña no existe";
    } else {
      return null;
    }
  }

  void navigateUser(String role) {
    if (role == 'admin') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyTapBarAdminWidget()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyTapBarWidget()),
      );
    }
  }

  Future<void> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text;
      final String password = _passwordController.text;
      Provider.of<UserProvider2>(context, listen: false).loginUser(email, password);
      final User user = Provider.of<UserProvider2>(context, listen: false).userData;
      final userRole = user.role;
      _emailController.clear();
      _passwordController.clear();
      navigateUser(userRole);
    } else {
      _isEmailInValid = true;
      _isPasswordInValid = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
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
                    colorText: const Color(0xFFFFFFFF),
                    onPressed: () {
                      _isPasswordInValid = false;
                      _isEmailInValid = false;
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

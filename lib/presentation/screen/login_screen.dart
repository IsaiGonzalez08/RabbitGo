import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rabbit_go/domain/models/User/user.dart';
import 'package:rabbit_go/presentation/providers/user_provider.dart';
import 'package:rabbit_go/presentation/widgets/checkbox_widget.dart';
import 'package:rabbit_go/presentation/widgets/create_account_widget.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';
import 'package:rabbit_go/presentation/widgets/password_textfield_widget.dart';
import 'package:rabbit_go/presentation/widgets/tapbar_admin.dart';
import 'package:rabbit_go/presentation/widgets/tapbar_widget.dart';
import 'package:rabbit_go/presentation/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class MyLoginScreen extends StatefulWidget {
  const MyLoginScreen({Key? key}) : super(key: key);

  @override
  _MyLoginScreenState createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late User _user;
  late String _role;
  bool _isEmailInValid = false;
  bool _isPasswordInValid = false;
  bool _showPassword = true;

  String? validateEmail(String? value) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese un email';
    }
    if (!emailRegex.hasMatch(value)) {
      return 'Por favor ingrese un email correcto';
    }
    if (_isEmailInValid) {
      return "El email no existe";
    }
    return null;
  }

  String? validatePassword(String? value) {
    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,16}$');
    if (value == null || value.isEmpty) {
      return "Por favor ingrese una contraseña";
    } else if (!passwordRegex.hasMatch(value)) {
      return "La contraseña debe tener entre 6 y 16 caracteres, e incluir al menos una letra mayúscula, una letra minúscula y un número.";
    } else if (_isPasswordInValid) {
      return "La contraseña no existe";
    } else {
      return null;
    }
  }

  void providerUserData() {
    _user = Provider.of<UserProvider>(context, listen: false).userData;
  }

  void _loginUser() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (_formKey.currentState!.validate()) {
      await Provider.of<UserProvider>(context, listen: false).loginUser(email, password);
      providerUserData();
      _role = _user.role;
      navigateUser(_role);
    } else {
      setState(() {
        _isEmailInValid = true;
        _isPasswordInValid = true;
      });
    }
    _emailController.clear();
    _passwordController.clear();
  }

  void navigateUser(String role) async {
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
                      return validateEmail(value?.trim());
                    },
                    onChanged: (value) {
                      setState(() {
                        _isEmailInValid = false;
                      });
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
                      return validatePassword(value?.trim());
                    },
                    obscureText: _showPassword,
                    onChanged: (value) {
                      setState(() {
                        _isPasswordInValid = false;
                      });
                    },
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

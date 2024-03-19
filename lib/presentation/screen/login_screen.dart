import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rabbit_go/presentation/screen/login_signup_screen.dart';
import 'package:rabbit_go/presentation/widgets/checkbox_widget.dart';
import 'package:rabbit_go/presentation/widgets/create_account_widget.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';
import 'package:rabbit_go/presentation/widgets/tapbar_widget.dart';
import 'package:rabbit_go/presentation/widgets/textfield_widget.dart';
import 'package:email_validator/email_validator.dart';

class MyLoginScreen extends StatefulWidget {
  const MyLoginScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyLoginScreenState createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // ignore: unused_field
  String? _email;
  // ignore: unused_field
  String? _password;

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

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyTapBarWidget()),
      );
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
                    validator: validateEmail,
                    onSaved: (value) => _email = value,
                    controllerTextField: _emailController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextFieldWidget(
                    width: 320,
                    controllerTextField: _passwordController,
                    text: 'Contraseña',
                    validator: validatePassword,
                    onSaved: (value) => _password = value,
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
                      submitForm();
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

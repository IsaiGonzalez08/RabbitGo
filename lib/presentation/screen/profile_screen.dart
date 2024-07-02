import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/domain/models/User/user.dart';
import 'package:rabbit_go/presentation/providers/user_provider.dart';
import 'package:rabbit_go/presentation/widgets/checkbox_widget.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';
import 'package:rabbit_go/presentation/widgets/textfield_widget.dart';
import 'package:rabbit_go/presentation/widgets/password_textfield_widget.dart';
import 'package:rabbit_go/presentation/widgets/update_user_data_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _usernameController;
  late TextEditingController _lastnameController;
  late TextEditingController _emailController;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _showPassword = true;
  late User _user;
  late String _name;
  late String _lastname;
  late String _email;

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
    _user = Provider.of<UserProvider>(context, listen: false).userData;
    _name = _user.name;
    _lastname = _user.lastname;
    _email = _user.email;
    
    _usernameController = TextEditingController(text: _name);
    _lastnameController = TextEditingController(text: _lastname);
    _emailController = TextEditingController(text: _email);

    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? _name;
      _lastname = prefs.getString('lastname') ?? _lastname;
      _email = prefs.getString('email') ?? _email;

      _usernameController.text = _name;
      _lastnameController.text = _lastname;
      _emailController.text = _email;
    });
  }

  void _showSuccessDialog(
      String name, String lastname, String email, String password) {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        return;
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return MyConfirmUpdateDataWidget(
                name: name,
                lastname: lastname,
                email: email,
                password: password,
              );
            });
        _usernameController.clear();
        _lastnameController.clear();
        _emailController.clear();
        _passwordController.clear();
        _confirmPasswordController.clear();
      }
    }
    return;
  }

  String getInitials(String firstName, String lastName) {
    String firstInitial = firstName.isNotEmpty ? firstName[0] : '';
    String lastInitial = lastName.isNotEmpty ? lastName[0] : '';
    return '$firstInitial$lastInitial';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/images/ForwardLeft.png',
            width: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF979797)),
        title: const Text(
          'Perfil',
          style: TextStyle(
              fontSize: 14,
              color: Color(0xFFB5B5B5),
              fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color(0xFF01142B),
                    child: Consumer<UserProvider>(
                      builder: (context, userData, child) {
                        String initials = getInitials(_name, _lastname);
                        return Text(initials,
                            style: const TextStyle(
                                fontSize: 36, color: Color(0xFFFFFFFF)));
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 35,
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
                            width: MediaQuery.of(context).size.width * 0.438,
                            controllerTextField: _usernameController = TextEditingController(text: _name),
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
                            width: MediaQuery.of(context).size.width * 0.438,
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
                        width: MediaQuery.of(context).size.width * 0.9,
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
                        width: MediaQuery.of(context).size.width * 0.9,
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
                        width: MediaQuery.of(context).size.width * 0.9,
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
              const SizedBox(
                height: 60,
              ),
              CustomButton(
                textButton: 'Actualizar',
                width: MediaQuery.of(context).size.width * 0.9,
                height: 40,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF01142B),
                colorText: const Color(0xFFFFFFFF),
                onPressed: () {
                  _formKey.currentState!.save();
                  final name = _usernameController.text;
                  final lastname = _lastnameController.text;
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  _showSuccessDialog(name, lastname, email, password);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

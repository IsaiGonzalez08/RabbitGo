import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/screen/configuration_screen.dart';
import 'package:rabbit_go/presentation/widgets/checkbox_widget.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';
import 'package:rabbit_go/presentation/widgets/textfield_widget.dart';
import 'package:rabbit_go/presentation/widgets/widget_password_textfiedl.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  String? _passwordErrorText;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        body: Column(
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
                            builder: (context) => const MyConfigurationScreen(),
                          ),
                        );
                      },
                      child: Image.asset('assets/images/ForwardProfile.png'),
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
                        return null;
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
                      passwordErrorText: _passwordErrorText,
                      controllerTextField: _passwordController,
                      text: 'Contraseña',
                      validator: (value) {
                        return null;
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
                      'Confirmar Contraseña',
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
                      controllerTextField: _confirmPasswordController,
                      text: 'Confirmar Contraseña',
                      validator: (value) {
                        return null;
                      },
                    ),
                  ],
                ),
                const MyCheckboxWidget()
              ],
            ),
            const Column(
              children: [
                CustomButton(
                    textButton: 'Actualizar',
                    width: 320,
                    height: 40,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

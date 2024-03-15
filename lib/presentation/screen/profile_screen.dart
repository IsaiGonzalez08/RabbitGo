import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/screen/configuration_screen.dart';
import 'package:rabbit_go/presentation/widgets/checkbox_widget.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';
import 'package:rabbit_go/presentation/widgets/textfield_widget.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Nombre',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF9A9A9A),
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    MyTextFieldWidget(
                      text: 'Nombre',
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
                    MyTextFieldWidget(
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

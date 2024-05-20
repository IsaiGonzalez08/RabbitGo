import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';
import 'package:rabbit_go/presentation/widgets/textfield_widget.dart';

class MyAdminAddRouteScreen extends StatefulWidget {
  const MyAdminAddRouteScreen({super.key});

  @override
  State<MyAdminAddRouteScreen> createState() => _MyAdminAddRouteScreenState();
}

class _MyAdminAddRouteScreenState extends State<MyAdminAddRouteScreen> {
  final TextEditingController _usernameController = TextEditingController();

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
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF979797)),
        title: const Text(
          'Agregar Ruta',
          style: TextStyle(
              fontSize: 14,
              color: Color(0xFFB5B5B5),
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTextFieldWidget(
                width: MediaQuery.of(context).size.width * 0.438,
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
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTextFieldWidget(
                width: MediaQuery.of(context).size.width * 0.438,
                controllerTextField: _usernameController,
                text: 'Precio',
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
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTextFieldWidget(
                width: MediaQuery.of(context).size.width * 0.438,
                controllerTextField: _usernameController,
                text: 'Hora de Inicio',
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
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTextFieldWidget(
                width: MediaQuery.of(context).size.width * 0.438,
                controllerTextField: _usernameController,
                text: 'Hora de Termino',
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
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTextFieldWidget(
                width: MediaQuery.of(context).size.width * 0.438,
                controllerTextField: _usernameController,
                text: 'ID Bus Stop',
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
            height: 20,
          ),
          CustomButton(
              textButton: 'Agregar',
              width: MediaQuery.of(context).size.width * 0.438,
              height: 40,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF01142B),
              colorText: const Color(0xFFFFFFFF))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';
import 'package:rabbit_go/presentation/widgets/textfield_widget.dart';

class MyAdminUpdateRouteScreen extends StatefulWidget {
  const MyAdminUpdateRouteScreen({super.key});

  @override
  State<MyAdminUpdateRouteScreen> createState() =>
      _MyAdminUpdateRouteScreenState();
}

class _MyAdminUpdateRouteScreenState extends State<MyAdminUpdateRouteScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final List<String> list = <String>['One', 'Two', 'Three', 'Four'];

  late String dropdownValue = list.first;

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
          'Actualizar Ruta',
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
                width: MediaQuery.of(context).size.width * 0.9,
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
                width: MediaQuery.of(context).size.width * 0.9,
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
                width: MediaQuery.of(context).size.width * 0.9,
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
                width: MediaQuery.of(context).size.width * 0.9,
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
          DropdownMenu<String>(
            initialSelection: list.first,
            width: MediaQuery.of(context).size.width * 0.9,
            menuStyle: const MenuStyle(
              backgroundColor: MaterialStatePropertyAll(Color(0xFFEDEDED)),
            ),
            menuHeight: 150,
            textStyle: const TextStyle(
                color: Color(0xFFB8B8B8),
                fontSize: 12,
                fontWeight: FontWeight.w500),
            inputDecorationTheme: const InputDecorationTheme(
                iconColor: Color(0xFFB8B8B8),
                border: InputBorder.none,
                filled: true,
                fillColor: Color(0xFFEDEDED)),
            onSelected: (String? value) {
              setState(() {
                dropdownValue = value!;
              });
            },
            dropdownMenuEntries:
                list.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
              textButton: 'Actualizar',
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

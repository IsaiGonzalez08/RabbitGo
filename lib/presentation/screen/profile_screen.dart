import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/screen/configuration_screen.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 35)),
              Row(
                children: [
                  const Padding(padding: EdgeInsets.only(left: 20)),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const MyConfigurationScreen()),
                        );
                      },
                      child: Image.asset('assets/images/ForwardProfile.png')),
                  const SizedBox(
                    width: 105,
                  ),
                  const Text(
                    'Perfil',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFFB5B5B5),
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Image.asset('assets/images/UserProfile.png'),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Nombre',
                        style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF9A9A9A),
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 280.0,
                        height: 45.0,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 22.0, horizontal: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Nombre',
                            hintStyle: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFFB8B8B8),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFEDEDED),
                          ),
                        ),
                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Correo Electrónico',
                        style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF9A9A9A),
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 280.0,
                        height: 45.0,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 22.0, horizontal: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Correo Electrónico',
                            hintStyle: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFFB8B8B8),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFEDEDED),
                          ),
                        ),
                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Contraseña',
                        style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF9A9A9A),
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 280.0,
                        height: 45.0,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 22.0, horizontal: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Contraseña',
                            hintStyle: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFFB8B8B8),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFEDEDED),
                          ),
                        ),
                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Confirmar Contraseña',
                        style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF9A9A9A),
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 280.0,
                        height: 45.0,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 22.0, horizontal: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Confirmar Contraseña',
                            hintStyle: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFFB8B8B8),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFEDEDED),
                          ),
                        ),
                      ),
                    ]),
              ),
              Row(
                children: [
                  const Padding(padding: EdgeInsets.only(left: 10)),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                    },
                  ),
                  const Flexible(
                      child: Text(
                    'Mostrar contraseña',
                    style: TextStyle(fontSize: 11, color: Color(0xFF979797)),
                  ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomButton(textButton: 'Actualizar', width: 100, height: 50, fontSize: 12, fontWeight: FontWeight.w600)
            ],
          ),
        ),
      ),
    );
  }
}

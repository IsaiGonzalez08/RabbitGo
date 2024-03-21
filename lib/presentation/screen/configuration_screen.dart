import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/infraestructure/controllers/user_controller.dart';
import 'package:rabbit_go/presentation/screen/general_screen.dart';
import 'package:rabbit_go/presentation/screen/login_signup_screen.dart';
import 'package:rabbit_go/presentation/screen/profile_screen.dart';
import 'package:rabbit_go/presentation/screen/suscription_screen.dart';
import 'package:rabbit_go/presentation/widgets/button_configuration_widget.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';
import 'package:http/http.dart' as http;

class MyConfigurationScreen extends StatefulWidget {
  const MyConfigurationScreen({super.key});

  @override
  State<MyConfigurationScreen> createState() => _MyConfigurationScreenState();
}

class _MyConfigurationScreenState extends State<MyConfigurationScreen> {
  String? _name;
  String? _lastname;
  String? _email;
  String? userId;
  String? token;

  @override
  void initState() {
    super.initState();
    userId = Provider.of<UserData>(context, listen: false).userId;
    token = Provider.of<UserData>(context, listen: false).token;
    _getDataUser();
  }

  Future<void> _getDataUser() async {
    try {
      String url = 'http://rabbitgo.sytes.net/user/$userId';

      final response =
          await http.get(Uri.parse(url), headers: {'Authorization': token!});

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          _name = responseData['data']['name'];
          _lastname = responseData['data']['lastname'];
          _email = responseData['data']['email'];
        });
      } else {
        print('Error en el get, Código de estado: ${response.statusCode}');
      }
    } catch (error) {
      print('Error al conectar con el servidor: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Configuración',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFB5B5B5),
                        fontSize: 14),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$_name $_lastname',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF737373),
                                fontSize: 18),
                          ),
                          Text(
                            _email ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF737373),
                                fontSize: 14),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const CustomButton(
                          textButton: 'Gratis',
                          width: 68,
                          height: 30,
                          fontSize: 14,
                          fontWeight: FontWeight.w800)
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyButtonConfigurationWidget(
                    text: 'Perfil',
                    space: 100,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyProfileScreen()));
                    },
                  ),
                  MyButtonConfigurationWidget(
                    space: 55,
                    text: 'Subscripción',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const MySuscriptionScreen()));
                    },
                  ),
                  MyButtonConfigurationWidget(
                    space: 90,
                    text: 'General',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyGeneralScreen()));
                    },
                  ),
                ],
              ),
            ),
            Column(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyLoginSignPage()),
                      );
                    },
                    child: SizedBox(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Cerrar sesión',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFFFF7878),
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            width: 180,
                          ),
                          Image.asset('assets/images/Logout.png'),
                          const Padding(padding: EdgeInsets.only(right: 10))
                        ],
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

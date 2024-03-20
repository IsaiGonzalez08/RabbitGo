import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/screen/general_screen.dart';
import 'package:rabbit_go/presentation/screen/login_signup_screen.dart';
import 'package:rabbit_go/presentation/screen/profile_screen.dart';
import 'package:rabbit_go/presentation/screen/suscription_screen.dart';
import 'package:rabbit_go/presentation/widgets/button_configuration_widget.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';

class MyConfigurationScreen extends StatefulWidget {
  const MyConfigurationScreen({super.key});

  @override
  State<MyConfigurationScreen> createState() => _MyConfigurationScreenState();
}

class _MyConfigurationScreenState extends State<MyConfigurationScreen> {
  String? _name;
  String? _lastname;
  String? _userEmail;

  void getDataUser() async {
    try {
      Dio dio = Dio();
      Response response = await dio.get('http://192.168.1.74:8080/user/g5e8r2');
      if (response.statusCode == 200) {
        setState(() {
          final Map<String, dynamic> userData = response.data;
          _name = userData['name'].toString();
          _lastname = userData['lastname'].toString();
          _userEmail = userData['email'].toString();
          print(_name);
          print(_lastname);
          print(_userEmail);
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
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
                            _userEmail ?? '',
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

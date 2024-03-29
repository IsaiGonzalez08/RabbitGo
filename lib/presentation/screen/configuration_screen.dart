import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/infraestructure/controllers/user_controller.dart';
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
  String? _email;
  String? userId;
  String? token;

  @override
  void initState() {
    super.initState();
    _name = Provider.of<UserData>(context, listen: false).name;
    _lastname = Provider.of<UserData>(context, listen: false).lastname;
    _email = Provider.of<UserData>(context, listen: false).email;
  }

  void navigateLoginSignScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyLoginSignPage()),
    );
  }

  void _showConfirmDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(10.0)),
          backgroundColor: const Color(0xFFFFFFFF),
          title: const Center(
            child: Text(
              textAlign: TextAlign.center,
              "¿Estas seguro que desear cerrar\n sesión?",
              style: TextStyle(
                  color: Color(0xFF777777),
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
          ),
          content: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textAlign: TextAlign.center,
                "Al cerrar sesión tu información será guardada\npero la próxima vez que quieras entrar\nnecesitaras iniciar sesión nuevamente.",
                style: TextStyle(
                    color: Color(0xFFACACAC),
                    fontSize: 11,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  width: 105,
                  height: 30,
                  textButton: 'Cerrar Sesión',
                  onPressed: () {
                    navigateLoginSignScreen();
                  },
                ),
                CustomButton(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  width: 105,
                  height: 30,
                  textButton: 'Cancelar',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          ],
        );
      },
    );
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
                      _showConfirmDialog();
                    },
                    child: SizedBox(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Cerrar sesión',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFFFF7878),
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(),
                          Image.asset('assets/images/Logout.png'),
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

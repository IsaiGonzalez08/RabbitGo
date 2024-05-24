import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/presentation/providers/user_provider.dart';
import 'package:rabbit_go/presentation/screen/login_signup_screen.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';
import 'package:http/http.dart' as http;

class MyAlertStatusProfile extends StatefulWidget {
  const MyAlertStatusProfile({super.key});

  @override
  State<MyAlertStatusProfile> createState() => _MyAlertStatusProfileState();
}

class _MyAlertStatusProfileState extends State<MyAlertStatusProfile> {
  String? userId;
  String? token;

  @override
  void initState() {
    super.initState();
    userId = Provider.of<UserProvider>(context, listen: false).uuid;
    token = Provider.of<UserProvider>(context, listen: false).token;
  }

  void navigateSignUpScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MyLoginSignPage()),
    );
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  _deleteAccount() async {
    try {
      String url = 'https://rabbitgo.sytes.net/user/$userId';
      final response =
          await http.delete(Uri.parse(url), headers: {'Authorization': token!});
      if (response.statusCode == 200) {
        navigateSignUpScreen();
      }
    } catch (error) {
      throw ('Error al eliminar el usuario, $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(10.0)),
      backgroundColor: const Color(0xFFFFFFFF),
      title: const Center(
        child: Text(
          textAlign: TextAlign.center,
          "¿Estas seguro que quieres eliminar\ntú cuenta?",
          style: TextStyle(
              color: Color(0xFF01142B),
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
      ),
      content: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            textAlign: TextAlign.center,
            "Al eliminar tu cuenta, tu información será\nborrada completamente y no podrás acceder\nla próxima vez que quieras entrar a tu cuenta.",
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
              width: MediaQuery.of(context).size.width * 0.29,
              height: 35,
              textButton: 'Eliminar',
              color: const Color(0xFFAB0000),
              colorText: const Color(0xFFFFFFFF),
              onPressed: () {
                _deleteAccount();
              },
            ),
            const SizedBox(
              width: 10,
            ),
            CustomButton(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              width: MediaQuery.of(context).size.width * 0.29,
              height: 35,
              textButton: 'Cancelar',
              color: const Color(0xFFB6B6B6),
              colorText: const Color(0xFFFFFFFF),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        )
      ],
    );
  }
}

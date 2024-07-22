import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/domain/models/User/user.dart';
import 'package:rabbit_go/presentation/providers/user_provider.dart';
import 'package:rabbit_go/presentation/screen/login_signup_screen.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAlertStatusProfile extends StatefulWidget {
  const MyAlertStatusProfile({super.key});

  @override
  State<MyAlertStatusProfile> createState() => _MyAlertStatusProfileState();
}

class _MyAlertStatusProfileState extends State<MyAlertStatusProfile> {
  late User _user;
  late String _userId;
  late String _token;

  @override
  void initState() {
    super.initState();
    _user = Provider.of<UserProvider>(context, listen: false).userData;
    _token = _user.token;
  }

  void navigateSignUpScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MyLoginSignPage()),
    );
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void _deleteAccount(String token, String id) async {
    await Provider.of<UserProvider>(context, listen: false)
        .deleteAccount(token, id);
    navigateSignUpScreen();
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
              onPressed: () async {
                _deleteAccount(_token, _userId);
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('isLoggedIn');
                await prefs.remove('name');
                await prefs.remove('id');
                await prefs.remove('lastName');
                await prefs.remove('email');
                await prefs.remove('role');
                await prefs.remove('token');
                await prefs.remove('type');
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

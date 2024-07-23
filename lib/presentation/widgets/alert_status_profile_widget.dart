import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('id');
  }

  void _deleteAccount(String id) async {
    await Provider.of<UserProvider>(context, listen: false).deleteAccount(id);
    navigateLoginScreen();
  }

  void navigateLoginScreen() async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MyLoginSignScreen()),
      (Route<dynamic> route) => false,
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('name');
    await prefs.remove('id');
    await prefs.remove('lastName');
    await prefs.remove('email');
    await prefs.remove('role');
    await prefs.remove('token');
    await prefs.remove('type');
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
                _deleteAccount(_userId!);
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

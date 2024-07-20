import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/domain/models/User/user.dart';
import 'package:rabbit_go/presentation/providers/user_provider.dart';
import 'package:rabbit_go/presentation/screen/general_screen.dart';
import 'package:rabbit_go/presentation/screen/profile_screen.dart';
import 'package:rabbit_go/presentation/screen/suscription_screen.dart';
import 'package:rabbit_go/presentation/widgets/alert_configuration.dart';
import 'package:rabbit_go/presentation/widgets/button_configuration_widget.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyConfigurationScreen extends StatefulWidget {
  const MyConfigurationScreen({super.key});

  @override
  State<MyConfigurationScreen> createState() => _MyConfigurationScreenState();
}

class _MyConfigurationScreenState extends State<MyConfigurationScreen> {
  late User _user;
  late String _name;
  late String _lastname;
  late String _email;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _user = Provider.of<UserProvider>(context, listen: false).userData;
    _name = _user.name;
    _lastname = _user.lastname;
    _email = _user.email;
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? '';
      _lastname = prefs.getString('lastName') ?? '';
      _email = prefs.getString('email') ?? '';
    });
  }

  void _showDialogLogout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const MyAlertConfiguration();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
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
                Padding(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.07,
                      left: MediaQuery.of(context).size.width * 0.07),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            _email,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF737373),
                                fontSize: 14),
                          )
                        ],
                      ),
                      CustomButton(
                          textButton: 'Gratis',
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: 30,
                          fontSize: 12,
                          color: const Color(0xFF01142B),
                          colorText: const Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w800)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyButtonConfigurationWidget(
                  text: 'Perfil',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyProfileScreen()));
                  },
                ),
                MyButtonConfigurationWidget(
                  text: 'Subscripción',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MySuscriptionScreen()));
                  },
                ),
                MyButtonConfigurationWidget(
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            InkWell(
                onTap: () {
                  _showDialogLogout();
                },
                child: SizedBox(
                  height: 80,
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.07,
                        left: MediaQuery.of(context).size.width * 0.07),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Cerrar sesión',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFFF7878),
                              fontWeight: FontWeight.w500),
                        ),
                        Image.asset(
                          'assets/images/Logout.png',
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

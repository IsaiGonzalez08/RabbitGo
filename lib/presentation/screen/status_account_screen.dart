import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/domain/models/User/user.dart';
import 'package:rabbit_go/presentation/providers/user_provider.dart';
import 'package:rabbit_go/presentation/widgets/alert_status_profile_widget.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyStatusAccountScreen extends StatefulWidget {
  const MyStatusAccountScreen({super.key});

  @override
  State<MyStatusAccountScreen> createState() => _MyStatusAccountScreeState();
}

class _MyStatusAccountScreeState extends State<MyStatusAccountScreen> {
  late User _user;
  late String _name;
  late String _lastname;

  @override
  void initState() {
    super.initState();
    _user = Provider.of<UserProvider>(context, listen: false).userData;
    _name = _user.name;
    _lastname = _user.lastName;
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? '';
      _lastname = prefs.getString('lastname') ?? '';
    });
  }

  String getInitials(String firstName, String lastName) {
    String firstInitial = firstName.isNotEmpty ? firstName[0] : '';
    String lastInitial = lastName.isNotEmpty ? lastName[0] : '';
    return '$firstInitial$lastInitial';
  }

  void _showConfirmDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const MyAlertStatusProfile();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
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
          'Estatus Perfil',
          style: TextStyle(
              fontSize: 14,
              color: Color(0xFFB5B5B5),
              fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color(0xFF01142B),
                    child: Consumer<UserProvider>(
                      builder: (context, userData, child) {
                        String initials = getInitials(_name, _lastname);
                        return Text(initials,
                            style: const TextStyle(
                                fontSize: 36, color: Color(0xFFFFFFFF)));
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '$_name $_lastname',
                    style: const TextStyle(
                        color: Color(0xFF01142B),
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      text:
                          'Recuerda que si eliminas tu cuenta, toda la información\nserá eliminada completamente, para más información\ningresa a',
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(0XFF787878),
                          fontWeight: FontWeight.w300),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' ayuda y soporte.',
                            style: TextStyle(
                                color: Color(0xFF787878),
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomButton(
                    onPressed: () {
                      _showConfirmDialog();
                    },
                    textButton: 'Eliminar cuenta',
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 40,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFF2F2F2),
                    colorText: const Color(0xFFAB0000),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

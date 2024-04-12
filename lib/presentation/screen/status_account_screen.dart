import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/infraestructure/controllers/user_controller.dart';
import 'package:rabbit_go/presentation/widgets/alert_status_profile_widget.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';

class MyStatusAccountScreen extends StatefulWidget {
  const MyStatusAccountScreen({super.key});

  @override
  State<MyStatusAccountScreen> createState() => _MyStatusAccountScreeState();
}

class _MyStatusAccountScreeState extends State<MyStatusAccountScreen> {
  String? userId;
  String? token;
  String? name;
  String? lastname;

  @override
  void initState() {
    super.initState();
    userId = Provider.of<UserData>(context, listen: false).uuid;
    token = Provider.of<UserData>(context, listen: false).token;
    name = Provider.of<UserData>(context, listen: false).name;
    lastname = Provider.of<UserData>(context, listen: false).lastname;
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
                    child: Consumer<UserData>(
                      builder: (context, userData, child) {
                        String initials = getInitials(
                            userData.name ?? '', userData.lastname ?? '');
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
                    '$name $lastname',
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
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFF2F2F2),
                      colorText: const Color(0xFFFFFFFF),
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

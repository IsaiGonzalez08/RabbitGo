import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/domain/models/User/user.dart';
import 'package:rabbit_go/presentation/providers/user_provider.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';

class MyConfirmUpdateDataWidget extends StatefulWidget {
  final String name, lastname, email, password;

  const MyConfirmUpdateDataWidget(
      {super.key,
      required this.name,
      required this.lastname,
      required this.email,
      required this.password});

  @override
  State<MyConfirmUpdateDataWidget> createState() =>
      _MyConfirmUpdateDataWidgetState();
}

class _MyConfirmUpdateDataWidgetState extends State<MyConfirmUpdateDataWidget> {
  late User _user;
  late String _userId;
  late String _token;
  late String name;
  late String lastname;
  late String email;
  late String password;

  @override
  void initState() {
    _user = Provider.of<UserProvider>(context, listen: false).userData;
    _userId = _user.id;
    _token = _user.token;
    name = widget.name;
    lastname = widget.lastname;
    email = widget.email;
    password = widget.password;
    super.initState();
  }

  navigateConfigurationScreen() {
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void _updateUser(String userId, String name, String lastname, String email,
      String password, String token) async {
    await Provider.of<UserProvider>(context, listen: false)
        .updateUser(userId, name, lastname, email, password, token);
    navigateConfigurationScreen();
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
          "¿Estas seguro de\nactualizar tus datos?",
          style: TextStyle(
              color: Color(0xFF777777),
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
      ),
      content: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Recuerda que tus datos personales son muy\nimportantes.",
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
              width: MediaQuery.of(context).size.width * 0.27,
              height: 40,
              textButton: 'Actualizar',
              color: const Color(0xFF01142B),
              colorText: const Color(0xFFFFFFFF),
              onPressed: () {
                _updateUser(_userId, name, lastname, email, password, _token);
              },
            ),
            CustomButton(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              width: MediaQuery.of(context).size.width * 0.27,
              height: 40,
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/domain/models/User/user.dart';
import 'package:rabbit_go/presentation/providers/route_provider.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';

import '../providers/user_provider.dart';

class MyAlertDeleteRoute extends StatefulWidget {
  final String id;
  final BuildContext context;
  const MyAlertDeleteRoute(
      {super.key, required this.id, required this.context});

  @override
  State<MyAlertDeleteRoute> createState() => _MyAlertDeleteRouteState();
}

class _MyAlertDeleteRouteState extends State<MyAlertDeleteRoute> {
  late User _user;
  late String _token;
  late String _busRouteUuid;

  @override
  void initState() {
    super.initState();
    _user = Provider.of<UserProvider>(context, listen: false).userData;
    _token = _user.token;
    _busRouteUuid = widget.id;
  }

  void deleteRoute(String token, String busRouteUuid) async {
    Provider.of<RouteProvider>(context, listen: false)
        .deleteRouteByUuid(token, busRouteUuid);
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
          "¿Estas seguro que quieres eliminar\nla ruta?",
          style: TextStyle(
              color: Color(0xFF01142B),
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
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
                deleteRoute(_token, _busRouteUuid);
                Navigator.pop(context);
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/domain/use_cases/Route/use_case_route.dart';
import 'package:rabbit_go/infraestructure/repositories/route_repository_impl.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';

import '../../infraestructure/providers/user_provider.dart';

class MyAlertDeleteRoute extends StatefulWidget {
  final String id;
  const MyAlertDeleteRoute({super.key, required this.id});

  @override
  State<MyAlertDeleteRoute> createState() => _MyAlertDeleteRouteState();
}

class _MyAlertDeleteRouteState extends State<MyAlertDeleteRoute> {
  late String? token;
  late String id;

  final deleteRouteUseCase = DeleteRouteById(RouteRepositoryImpl());

  @override
  void initState() {
    super.initState();
    token = Provider.of<UserProvider>(context, listen: false).token;
    id = widget.id;
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
                if (token != null) {
                  deleteRouteUseCase.deleteRouteById(token, id);
                  Navigator.pop(context);
                }
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

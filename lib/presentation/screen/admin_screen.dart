import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/domain/models/User/user.dart';
import 'package:rabbit_go/presentation/providers/route_provider.dart';
import 'package:rabbit_go/presentation/providers/user_provider.dart';
import 'package:rabbit_go/presentation/screen/admin_update_route_screen.dart';
import 'package:rabbit_go/presentation/widgets/alert_admin_delete_route_widget.dart';
import 'package:rabbit_go/presentation/widgets/alert_configuration.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';
import 'package:rabbit_go/presentation/widgets/route_admin_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAdminScreen extends StatefulWidget {
  const MyAdminScreen({Key? key}) : super(key: key);

  @override
  State<MyAdminScreen> createState() => _MyAdminScreenState();
}

class _MyAdminScreenState extends State<MyAdminScreen> {
  late User _user;
  late String _token;
  late String _name;

  @override
  void initState() {
    super.initState();
    _user = Provider.of<UserProvider>(context, listen: false).userData;
    _token = _user.token;
    _name = _user.name;
    Provider.of<RouteProvider>(context, listen: false).getAllRoutes(_token);
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? '';
    });
  }

  void navigateUpdateScreen(String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MyAdminUpdateRouteScreen(
                id: id,
                context: context,
              )),
    );
  }

  void openDeleteAlert(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyAlertDeleteRoute(
          id: id,
          context: context,
        );
      },
    );
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
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.07),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Bienvenido',
                          style: TextStyle(
                              color: Color(0xFF707070),
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          _name,
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF131313)),
                        ),
                      ],
                    ),
                    CustomButton(
                      onPressed: () {
                        _showDialogLogout();
                      },
                      textButton: 'Cerrar Sesión',
                      width: MediaQuery.of(context).size.width * 0.26,
                      height: 40,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFAB0000),
                      colorText: const Color(0xFFF2F2F2),
                    )
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 1.0,
                  height: 20.0,
                  indent: 0,
                  endIndent: 0,
                ),
              ],
            ),
          ),
          Expanded(child: Consumer<RouteProvider>(builder: (_, controller, __) {
            if (controller.loading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                  itemCount: controller.routes.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final route = controller.routes[index];
                    return RouteCard(
                      name: route.name,
                      startTime: route.startTime,
                      endTime: route.endTime,
                      price: route.price.toString(),
                      onEdit: () {
                        final idRoute = route.uuid;
                        navigateUpdateScreen(idRoute);
                      },
                      onDelete: () {
                        final idRoute = route.uuid;
                        openDeleteAlert(idRoute);
                      },
                    );
                  });
            }
          })),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

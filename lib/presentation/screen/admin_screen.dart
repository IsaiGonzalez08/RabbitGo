import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/domain/models/Route/route.dart';
import 'package:rabbit_go/domain/use_cases/Route/use_case_route.dart';
import 'package:rabbit_go/infraestructure/providers/user_provider.dart';
import 'package:rabbit_go/infraestructure/repositories/Route/route_repository_impl.dart';
import 'package:rabbit_go/presentation/screen/admin_update_route_screen.dart';
import 'package:rabbit_go/presentation/widgets/alert_admin_delete_route_widget.dart';
import 'package:rabbit_go/presentation/widgets/route_admin_card.dart';

class MyAdminScreen extends StatefulWidget {
  final BuildContext context;
  const MyAdminScreen({Key? key, required this.context}) : super(key: key);

  @override
  State<MyAdminScreen> createState() => _MyAdminScreenState();
}

class _MyAdminScreenState extends State<MyAdminScreen> {
  late Future<List<RouteModel>> futureRoutes;
  String? _name;

  @override
  void initState() {
    super.initState();
    _name = Provider.of<UserProvider>(context, listen: false).name;
    final token = Provider.of<UserProvider>(context, listen: false).token;
    final getAllRoutesUseCase =
        GetAllRoutesUseCase(RouteRepositoryImpl(context));
    futureRoutes = getAllRoutesUseCase.execute(token);
  }

  void navigateUpdateScreen(String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MyAdminUpdateRouteScreen(
                id: id, context: context,
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
                  '$_name',
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF131313)),
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
          Expanded(
            child: FutureBuilder<List<RouteModel>>(
              future: futureRoutes,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final route = snapshot.data![index];
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
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

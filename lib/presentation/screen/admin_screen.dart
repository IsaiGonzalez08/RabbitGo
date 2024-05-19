import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/domain/models/Route/route.dart';
import 'package:rabbit_go/domain/use_cases/Route/use_case_route.dart';
import 'package:rabbit_go/infraestructure/providers/user_provider.dart';
import 'package:rabbit_go/infraestructure/repositories/route_repository_impl.dart';
import 'package:rabbit_go/presentation/widgets/card_admin_routes.dart';

class MyAdminScreen extends StatefulWidget {
  const MyAdminScreen({Key? key}) : super(key: key);

  @override
  State<MyAdminScreen> createState() => _MyAdminScreenState();
}

class _MyAdminScreenState extends State<MyAdminScreen> {
  late Future<List<RouteModel>> futureRoutes;
  String? _name;
  final getAllRoutesUseCase = GetAllRoutesUseCase(RouteRepositoryImpl());

  @override
  void initState() {
    super.initState();
    _name = Provider.of<UserProvider>(context, listen: false).name;
    final token = Provider.of<UserProvider>(context, listen: false).token;
    if (token != null) {
      futureRoutes = getAllRoutesUseCase.execute(token);
    } else {
      futureRoutes = Future.error('User token nop');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Bienvenido',
              style: TextStyle(
                  color: Color(0xFF707070),
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              '$_name',
              style: const TextStyle(
                  fontSize: 16,
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
            const SizedBox(
              height: 30,
            ),
            FutureBuilder<List<RouteModel>>(
                future: futureRoutes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: snapshot.data!.map((route) {
                        return AdminCard(
                          uuid: route.uuid,
                          name: route.name,
                        );
                      }).toList(),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return const CircularProgressIndicator();
                })
          ],
        ),
      ),
    );
  }
}

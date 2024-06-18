import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/domain/models/Route/route.dart';
import 'package:rabbit_go/domain/models/User/user.dart';
import 'package:rabbit_go/presentation/providers/route_provider.dart';
import 'package:rabbit_go/presentation/providers/user_provider.dart';
import 'package:rabbit_go/presentation/screen/admin_update_route_screen.dart';
import 'package:rabbit_go/presentation/widgets/alert_admin_delete_route_widget.dart';
import 'package:rabbit_go/presentation/widgets/route_admin_card.dart';

class MyAdminFindRouteScreen extends StatefulWidget {
  const MyAdminFindRouteScreen({super.key});

  @override
  State<MyAdminFindRouteScreen> createState() => _MyAdminFindRouteScreenState();
}

class _MyAdminFindRouteScreenState extends State<MyAdminFindRouteScreen> {
  late User _user;
  late String _token;
  List<RouteModel> _routes = [];
  List<RouteModel> _filteredRoutes = [];
  final TextEditingController _searchController = TextEditingController();

  void _filterRoutes(String query) {
    setState(() {
      _filteredRoutes = _routes
          .where(
              (route) => route.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _user = Provider.of<UserProvider>(context, listen: false).userData;
    _token = _user.token;
    Provider.of<RouteProvider>(context, listen: false).getAllRoutes(_token);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          'Buscar Ruta',
          style: TextStyle(
              fontSize: 14,
              color: Color(0xFFB5B5B5),
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 40,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 1),
                  )
                ]),
                child: TextField(
                  onChanged: _filterRoutes,
                  controller: _searchController,
                  textAlignVertical: TextAlignVertical.center,
                  cursorHeight: 25.0,
                  cursorColor: const Color(0xFF01142B),
                  style: const TextStyle(
                      color: Color(0xFF01142B), fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Buscar ruta',
                    hintStyle: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFFE0E0E0),
                        fontWeight: FontWeight.w500),
                    filled: true,
                    fillColor: const Color(0xFFFFFFFF),
                    prefixIcon: Image.asset(
                      'assets/images/Search.png',
                      width: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: Consumer<RouteProvider>(builder: (_, controller, __) {
              if (controller.loading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                _routes = controller.routes;
                _filteredRoutes =
                    _searchController.text.isEmpty ? _routes : _filteredRoutes;
                return ListView.builder(
                  itemCount: _filteredRoutes.length,
                  itemBuilder: (_, index) {
                    final route = _filteredRoutes[index];
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
              }
            }),
          )
        ],
      ),
    );
  }
}

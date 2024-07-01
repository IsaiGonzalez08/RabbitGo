import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/domain/models/Route/route.dart';
import 'package:rabbit_go/domain/models/User/user.dart';
import 'package:rabbit_go/presentation/providers/route_provider.dart';
import 'package:rabbit_go/presentation/providers/user_provider.dart';
import 'package:rabbit_go/presentation/widgets/tapbar_widget.dart';

class MyFindRouteScreen extends StatefulWidget {
  const MyFindRouteScreen({Key? key}) : super(key: key);

  @override
  State<MyFindRouteScreen> createState() => _MyFindRouteScreenState();
}

class _MyFindRouteScreenState extends State<MyFindRouteScreen> {
  late User _user;
  late String _token;
  List<RouteModel> _routes = [];
  List<RouteModel> _filteredRoutes = [];
  final TextEditingController _searchController = TextEditingController();

  void navigateHome() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MyTapBarWidget(),
      ),
    );
  }

  Future<void> _getRoutePath(String token, String busRouteId) async {
    await Provider.of<RouteProvider>(context, listen: false)
        .getRouteBusPath(token, busRouteId);
    navigateHome();
  }

  void _filterRoutes(String query) {
    setState(() {
      _filteredRoutes = _routes
          .where((route) =>
              route.name.toLowerCase().contains(query.toLowerCase()))
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Color(0xFF979797)),
        toolbarHeight: MediaQuery.of(context).size.height * 0.14,
        title: Container(
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
      ),
      body: Consumer<RouteProvider>(builder: (_, controller, __) {
        if (controller.loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          _routes = controller.routes;
          _filteredRoutes = _searchController.text.isEmpty
              ? _routes
              : _filteredRoutes;

          return ListView.builder(
            itemCount: _filteredRoutes.length,
            itemBuilder: (_, index) {
              final route = _filteredRoutes[index];
              return InkWell(
                onTap: () {
                  final busRouteId = route.uuid;
                  _getRoutePath(_token, busRouteId);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.07),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFF5F5F5),
                      width: 2,
                    ),
                  ),
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/Bus.png',
                            width: 50,
                          ),
                          const SizedBox(width: 5),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                route.name,
                                style: const TextStyle(
                                    color: Color(0xFF8D8D8D),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                '${route.startTime}-${route.endTime}',
                                style: const TextStyle(
                                    color: Color(0xFFE0E0E0),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Costo ',
                                style: TextStyle(
                                    color: Color(0xFFAEAEAE),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                '\$${route.price}',
                                style: const TextStyle(
                                    color: Color(0xFFAEAEAE),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}

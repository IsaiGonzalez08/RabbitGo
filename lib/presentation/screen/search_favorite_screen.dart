import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/domain/models/Route/route.dart';
import 'package:rabbit_go/domain/models/User/user.dart';
import 'package:rabbit_go/presentation/providers/route_provider.dart';
import 'package:rabbit_go/presentation/providers/user_provider.dart';
import 'package:rabbit_go/presentation/widgets/alert_status_response.dart';
import 'package:rabbit_go/presentation/widgets/card_search_favorite.dart';

class MySearchRouteScreen extends StatefulWidget {
  const MySearchRouteScreen({Key? key}) : super(key: key);

  @override
  State<MySearchRouteScreen> createState() => _MySearchRouteScreenState();
}

class _MySearchRouteScreenState extends State<MySearchRouteScreen> {
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
    Provider.of<RouteProvider>(context, listen: false)
        .getAllRoutes(_token)
        .then((_) {
      _routes = Provider.of<RouteProvider>(context, listen: false).routes;
    });
  }

  Future<void> _showConfirmDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const MyAlertStatusResponse();
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        centerTitle: true,
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
                'assets/images/search2.png',
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
          _filteredRoutes =
              _searchController.text.isEmpty ? _routes : _filteredRoutes;
          return ListView.builder(
            itemCount: _filteredRoutes.length,
            itemBuilder: (_, index) {
              final route = _filteredRoutes[index];
              return CardSearchFavorite(
                onTap: () async {
                  await Provider.of<UserProvider>(context, listen: false)
                      .addFavoriteById(route.id);
                  final response =
                      Provider.of<UserProvider>(context, listen: false)
                          .response;
                  if (response == true) {
                    _showConfirmDialog();
                  } else {
                    print('Error al agregar la ruta');
                  }
                },
                routeName: route.name,
                routeStartTime: route.startTime,
                routeEndTime: route.endTime,
              );
            },
          );
        }
      }),
    );
  }
}

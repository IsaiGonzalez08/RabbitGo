import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/domain/models/Route/route.dart';
import 'package:rabbit_go/domain/models/User/user.dart';
import 'package:rabbit_go/presentation/providers/route_provider.dart';
import 'package:rabbit_go/presentation/providers/user_provider.dart';
import 'package:rabbit_go/presentation/widgets/button_route_widget.dart';
import 'package:rabbit_go/presentation/widgets/tapbar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final Map<String, bool> _favoriteStatus = {};

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
        .getBusRoutePath(token, busRouteId);
    navigateHome();
  }

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
      _loadFavoriteStatus();
    });
  }

  Future<void> _loadFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      for (var route in _routes) {
        _favoriteStatus[route.id] = prefs.getBool(route.id) ?? false;
      }
    });
  }

  Future<void> _toggleFavoriteStatus(String uuid) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _favoriteStatus[uuid] = !(_favoriteStatus[uuid] ?? false);
    });
    await prefs.setBool(uuid, _favoriteStatus[uuid]!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
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
              bool isFavorite = _favoriteStatus[route.id] ?? false;
              return MyButtonRoute(
                onTap: () {
                  _getRoutePath(_token, route.id);
                },
                onTapLikeButton: () {
                  _toggleFavoriteStatus(route.id);
                },
                isFavorite: isFavorite,
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

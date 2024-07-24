import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/domain/models/Path/path.dart';
import 'package:rabbit_go/presentation/providers/route_provider.dart';
import 'package:rabbit_go/presentation/providers/user_provider.dart';
import 'package:rabbit_go/presentation/widgets/alert_bus_route.dart';
import 'package:rabbit_go/presentation/widgets/route_card_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyBusStopAlert extends StatefulWidget {
  final String stopId, district, street, postalCode;
  const MyBusStopAlert(
      {Key? key,
      required this.stopId,
      required this.district,
      required this.street,
      required this.postalCode})
      : super(key: key);

  @override
  State<MyBusStopAlert> createState() => _MyBusStopAlertState();
}

class _MyBusStopAlertState extends State<MyBusStopAlert> {
  late String stopId;
  late List<PathModel> listCordinates = [];
  late String district;
  late String street;
  late String postalCode;
  List<String>? listShuttleId;

  @override
  void initState() {
    district = widget.district;
    street = widget.street;
    postalCode = widget.postalCode;
    stopId = widget.stopId;
    _loadStopAlertData();
    super.initState();
  }

  Future<void> _loadStopAlertData() async {
    await Provider.of<RouteProvider>(context, listen: false)
        .getRouteByBusStopId(stopId);
    providerLikes();
  }

  Future<void> providerLikes() async {
    final listFavorites =
        Provider.of<UserProvider>(context, listen: false).favorites;
    final shuttleFavoritesIds =
        listFavorites.map((favorite) => favorite.shuttleId).toList();
    setListFavorites(shuttleFavoritesIds);
  }

  Future<void> setListFavorites(List<String> shuttleFavoritesIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('listShuttleFavIds', shuttleFavoritesIds);
  }

  Future<List<String>?> getListFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('listShuttleFavIds');
  }

  Future<void> _showDialogBusRoute(String routeName, String routeId, int price,
      List<dynamic> colonies, bool isFavorite) async {
    showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return MyBusRouteAlert(
          name: routeName,
          routeId: routeId,
          price: price,
          colonies: colonies,
          isFavorite: isFavorite,
        );
      },
      constraints: const BoxConstraints(
        minWidth: 0.0,
        maxWidth: double.infinity,
        minHeight: 210.0,
        maxHeight: 500,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.07),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Parada de ascenso y descenso.',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xFF3B3B3B),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '$district, $street, $postalCode.',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFF3B3B3B),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Rutas que puedes abordar aquí.',
                  style: TextStyle(
                    color: Color(0xFF01142B),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<RouteProvider>(
              builder: (_, routeProvider, __) {
                if (routeProvider.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: routeProvider.routesAlert.length,
                    itemBuilder: (context, index) {
                      final route = routeProvider.routesAlert[index];
                      return MyCardRouteWidget(
                          onTap: () async {
                            final List<String>? listFavorites =
                                await getListFavorites();
                            final bool isFavorite =
                                listFavorites?.contains(route.id) ?? false;
                            await _showDialogBusRoute(route.name, route.id,
                                route.price, route.colonies, isFavorite);
                          },
                          routeName: route.name,
                          startTime: route.startTime,
                          endTime: route.endTime,
                          price: route.price);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

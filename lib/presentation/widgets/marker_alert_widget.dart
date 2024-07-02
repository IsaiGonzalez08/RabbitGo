import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/domain/models/User/user.dart';
import 'package:rabbit_go/presentation/providers/route_provider.dart';
import 'package:rabbit_go/presentation/providers/user_provider.dart';
import 'package:rabbit_go/presentation/widgets/alert_bus_route.dart';

class MyAlertMarker extends StatefulWidget {
  final String stopId;
  const MyAlertMarker({Key? key, required this.stopId}) : super(key: key);

  @override
  State<MyAlertMarker> createState() => _MyAlertMarkerState();
}

class _MyAlertMarkerState extends State<MyAlertMarker> {
  String? selectedBusRouteId;
  List<LatLng> listCordinates = [];
  late User _user;
  late String _token;

  @override
  void initState() {
    _user = Provider.of<UserProvider>(context, listen: false).userData;
    _token = _user.token;
    Provider.of<RouteProvider>(context, listen: false)
        .getRouteByBusStopId(_token, widget.stopId);
    super.initState();
  }

  void _showDialogBusRoute(String routeName, String routeId, int price) {
    showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return MyAlertBusRoute(
          name: routeName,
          routeId: routeId,
          price: price,
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
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Parada de ascenso y descenso.',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xFF3B3B3B),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '[Dirección de la parada de ascenso y descenso].',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFF3B3B3B),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20),
                Text(
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
                      return InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          _showDialogBusRoute(
                              route.name, route.uuid, route.price);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.07,
                          ),
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: Color(0xFFEDEDED)))),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        route.name,
                                        style: const TextStyle(
                                          color: Color(0xFF01142B),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        '${route.startTime}-${route.endTime}',
                                        style: const TextStyle(
                                          color: Color(0xFF8B8B8B),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(width: 50),
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
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        '\$${route.price}',
                                        style: const TextStyle(
                                          color: Color(0xFFAEAEAE),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
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
              },
            ),
          ),
        ],
      ),
    );
  }
}

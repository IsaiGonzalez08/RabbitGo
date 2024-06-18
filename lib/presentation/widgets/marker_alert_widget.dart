import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/domain/models/User/user.dart';
import 'package:rabbit_go/presentation/providers/route_provider.dart';
import 'package:rabbit_go/presentation/providers/user_provider.dart';
import 'package:rabbit_go/presentation/widgets/tapbar_widget.dart';

class MyAlertMarker extends StatefulWidget {
  final String markerId;
  const MyAlertMarker({Key? key, required this.markerId}) : super(key: key);

  @override
  State<MyAlertMarker> createState() => _MyAlertMarkerState();
}

class _MyAlertMarkerState extends State<MyAlertMarker> {
  String? selectedBusRouteId;
  List<LatLng> listCordinates = [];
  late String markerId;
  late User _user;
  late String _token;
  late String busRouteId;

  @override
  void initState() {
    markerId = widget.markerId;
    _user = Provider.of<UserProvider>(context, listen: false).userData;
    _token = _user.token;
    Provider.of<RouteProvider>(context, listen: false)
        .getRouteByBusStopId(_token, markerId);
    super.initState();
  }

  void navigateMap() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MyTapBarWidget()),
    );
  }

  void _selectRoute(String routeId) {
    setState(() {
      if (selectedBusRouteId == routeId) {
        selectedBusRouteId =
            null; // Deselecciona la ruta si ya está seleccionada
      } else {
        selectedBusRouteId = routeId; // Selecciona la nueva ruta
      }
    });
  }

  Future<void> _getRoutePath(String token, String busRouteId) async {
    await Provider.of<RouteProvider>(context, listen: false)
        .getRouteBusPath(token, busRouteId);
    navigateMap();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.06,
                  vertical: MediaQuery.of(context).size.height * 0.04),
              child: const Row(
                children: [
                  Text(
                    'Rutas cercanas',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color(0xFF3B3B3B),
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            Consumer<RouteProvider>(
              builder: (_, routeProvider, __) {
                if (routeProvider.loading) {
                  return const CircularProgressIndicator();
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: routeProvider.routesAlert.length,
                    itemBuilder: (context, index) {
                      final route = routeProvider.routesAlert[index];
                      final isSelected = route.uuid == selectedBusRouteId;
                      return InkWell(
                        onTap: () => _selectRoute(route.uuid),
                        child: Container(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.07,
                              left: MediaQuery.of(context).size.width * 0.07),
                          decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFE0E0E0)
                                  : const Color(0xFF),
                              border: Border.all(
                                color: const Color(0xFFE0E0E0),
                                width: 1,
                              )),
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
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            color: Color(0xFFAEAEAE),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 50,
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
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } 
              },
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.width * 0.05),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 40,
            decoration: BoxDecoration(
              color: selectedBusRouteId != null
                  ? const Color(0xFF01142B)
                  : const Color(0xFFB6B6B6),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextButton(
                onPressed: selectedBusRouteId != null
                    ? () {
                        _getRoutePath(_token, selectedBusRouteId!);
                      }
                    : null,
                child: const Text('Comenzar',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFFFFFF)))),
          ),
        ),
      ],
    );
  }
}

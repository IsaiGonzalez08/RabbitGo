import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/domain/models/User/user.dart';
import 'package:rabbit_go/presentation/providers/route_provider.dart';
import 'package:rabbit_go/presentation/providers/user_provider.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';
import 'package:rabbit_go/presentation/widgets/tapbar_widget.dart';

class MyAlertBusRoute extends StatefulWidget {
  final String name, routeId;
  final int price;
  const MyAlertBusRoute(
      {Key? key,
      required this.name,
      required this.routeId,
      required this.price})
      : super(key: key);

  @override
  State<MyAlertBusRoute> createState() => _MyAlertBusRouteState();
}

class _MyAlertBusRouteState extends State<MyAlertBusRoute> {
  List<LatLng> listCordinates = [];
  late User _user;
  late String routeName;
  late String _token;
  late String busRouteId;
  late int price;

  @override
  void initState() {
    routeName = widget.name;
    busRouteId = widget.routeId;
    price = widget.price;
    _user = Provider.of<UserProvider>(context, listen: false).userData;
    _token = _user.token;
    super.initState();
  }

  void navigateMap() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MyTapBarWidget()),
    );
  }

  Future<void> _getRoutePath(String token, String busRouteId) async {
    await Provider.of<RouteProvider>(context, listen: false)
        .getRouteBusPath(token, busRouteId);
    navigateMap();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.09),
      child: SingleChildScrollView(
        // Envolver en SingleChildScrollView
        child: Column(
          children: [
            Container(
              height: 80,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Color(0xFFEDEDED), width: 2))),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/Bus.png',
                    width: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(routeName,
                          style: const TextStyle(
                              color: Color(0xFF01142B),
                              fontSize: 22,
                              fontWeight: FontWeight.w600)),
                      const Text('[Dirección de la ruta].')
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Image.asset(
                  'assets/images/upward.png',
                  width: 32,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text('Esta ruta va de ida.',
                    style: TextStyle(
                        color: Color(0xFF01142B),
                        fontSize: 14,
                        fontWeight: FontWeight.w600))
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 2,
                ),
                Image.asset(
                  'assets/images/paid.png',
                  width: 26,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text('Costo de transporte \$$price.',
                    style: const TextStyle(
                        color: Color(0xFF01142B),
                        fontSize: 14,
                        fontWeight: FontWeight.w600))
              ],
            ),
            InkWell(
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/arrow_right.png',
                    width: 32,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  const Text('Ver más',
                      style: TextStyle(
                          color: Color(0xFF01142B),
                          fontSize: 14,
                          fontWeight: FontWeight.w600))
                ],
              ),
            ),
            CustomButton(
                onPressed: () {
                  _getRoutePath(_token, busRouteId);
                },
                textButton: 'Trazar ruta',
                width: MediaQuery.of(context).size.width * 0.9,
                height: 30,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF01142B),
                colorText: const Color(0xFFFFFFFF))
          ],
        ),
      ),
    );
  }
}

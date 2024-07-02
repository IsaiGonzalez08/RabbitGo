import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/domain/models/User/user.dart';
import 'package:rabbit_go/presentation/providers/route_provider.dart';
import 'package:rabbit_go/presentation/providers/user_provider.dart';
import 'package:rabbit_go/presentation/widgets/alert_report.dart';
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
  late User _user;
  late String _token;
  bool _isExpanded = false;
  bool _iconToggled = false;
  bool _buttonVisible = false;

  final List<String> stringList = [
    'Elemento 1',
    'Elemento 2',
    'Elemento 3',
    'Elemento 4'
  ];

  @override
  void initState() {
    super.initState();
    _user = Provider.of<UserProvider>(context, listen: false).userData;
    _token = _user.token;
  }

  void _toggleSizeAndIcon() {
    setState(() {
      _isExpanded = !_isExpanded;
      _iconToggled = !_iconToggled;
      _buttonVisible = !_buttonVisible;
    });
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

  void _showDialogReportBusRoute(String routeName) {
    showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return MyAlertReportBusRoute(name: routeName);
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
    String combinedText = stringList.join('\n');
    return Container(
      decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30))),
      constraints: BoxConstraints(
        minHeight: 210.0,
        maxHeight: _isExpanded ? 420 : 210.0,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05),
        child: Column(
          children: [
            Container(
              height: 80,
              decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xFFEDEDED), width: 2)),
              ),
              child: Row(
                children: [
                  Image.asset('assets/images/Bus.png', width: 50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                          color: Color(0xFF01142B),
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text('[Dirección de la ruta].'),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Image.asset('assets/images/upward.png', width: 26),
                const Text(
                  'Esta ruta va de ida.',
                  style: TextStyle(
                    color: Color(0xFF01142B),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Image.asset('assets/images/paid.png', width: 22),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  'Costo de transporte \$${widget.price}.',
                  style: const TextStyle(
                    color: Color(0xFF01142B),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: _toggleSizeAndIcon,
              child: Row(
                children: [
                  Image.asset(
                      _iconToggled
                          ? 'assets/images/arrow_down.png'
                          : 'assets/images/arrow_right.png',
                      width: 26),
                  const Text(
                    'Ver más',
                    style: TextStyle(
                      color: Color(0xFF01142B),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            if (_buttonVisible) ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Image.asset(
                      'assets/images/fork_right.png',
                      width: 14,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      'Colonias por donde pasa esta ruta.',
                      style: TextStyle(
                          color: Color(0xFF01142B),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    )
                  ]),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.07),
                    child: Text(combinedText),
                  ),
                ],
              ),
              Row(children: [
                Image.asset(
                  'assets/images/acute.png',
                  width: 20,
                ),
                const SizedBox(
                  width: 4,
                ),
                const Text(
                  'Tiempo aproximado de llegada [Tiempo].',
                  style: TextStyle(
                      color: Color(0xFF01142B),
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                )
              ]),
              Row(children: [
                Image.asset(
                  'assets/images/traffic_jam.png',
                  width: 20,
                ),
                const SizedBox(
                  width: 4,
                ),
                const Text(
                  'Estado del trafico [Estado].',
                  style: TextStyle(
                      color: Color(0xFF01142B),
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                )
              ]),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.width * 0.04,
                ),
                child: CustomButton(
                  onPressed: () {
                    _showDialogReportBusRoute(widget.name);
                  },
                  textButton: 'Reporte de queja',
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 30,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF990404),
                  colorText: const Color(0xFFFFFFFF),
                ),
              ),
            ],
            CustomButton(
              onPressed: () {
                _getRoutePath(_token, widget.routeId);
              },
              textButton: 'Trazar ruta',
              width: MediaQuery.of(context).size.width * 0.9,
              height: 30,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF01142B),
              colorText: const Color(0xFFFFFFFF),
            ),
          ],
        ),
      ),
    );
  }
}

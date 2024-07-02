import 'package:flutter/material.dart';
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
  late User _user;
  late String _token;
  late int price;
  late String busRouteId;
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
    price = widget.price;
    busRouteId = widget.routeId;
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

  @override
  Widget build(BuildContext context) {
    String combinedText = stringList.join('\n');
    return Container(
      constraints: BoxConstraints(
        minHeight: 210.0,
        maxHeight: _isExpanded ? 420 : 210.0,
      ),
      child: Column(
        children: [
          Padding(
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
                    Image.asset('assets/images/upward.png', width: 32),
                    const SizedBox(width: 5),
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
                    const SizedBox(width: 2),
                    Image.asset('assets/images/paid.png', width: 26),
                    const SizedBox(width: 8),
                    Text(
                      'Costo de transporte \$$price.',
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
                          width: 32),
                      const SizedBox(width: 3),
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
              ],
            ),
          ),
          if (_buttonVisible) ...[
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.08),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Image.asset(
                          'assets/images/fork_right.png',
                          width: 18,
                        ),
                        const SizedBox(
                          width: 7,
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
                            horizontal:
                                MediaQuery.of(context).size.width * 0.07),
                        child: Text(combinedText),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.06),
                  child: Row(children: [
                    Image.asset(
                      'assets/images/acute.png',
                      width: 24,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      'Tiempo aproximado de llegada [Tiempo].',
                      style: TextStyle(
                          color: Color(0xFF01142B),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    )
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.07),
                  child: Row(children: [
                    Image.asset(
                      'assets/images/traffic_jam.png',
                      width: 24,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    const Text(
                      'Estado del trafico [Estado].',
                      style: TextStyle(
                          color: Color(0xFF01142B),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    )
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.05,
                      bottom: MediaQuery.of(context).size.width * 0.03),
                  child: CustomButton(
                    onPressed: () {
                      _getRoutePath(_token, busRouteId);
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
            ),
          ],
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
            colorText: const Color(0xFFFFFFFF),
          ),
        ],
      ),
    );
  }
}

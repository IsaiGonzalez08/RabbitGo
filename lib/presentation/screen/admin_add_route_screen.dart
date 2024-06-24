import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/domain/models/Stop/stop.dart';
import 'package:rabbit_go/domain/models/User/user.dart';
import 'package:rabbit_go/presentation/providers/bus_stops_provider.dart';
import 'package:rabbit_go/presentation/providers/route_provider.dart';
import 'package:rabbit_go/presentation/providers/user_provider.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';
import 'package:rabbit_go/presentation/widgets/tapbar_admin.dart';
import 'package:rabbit_go/presentation/widgets/textfield_widget.dart';

class MyAdminAddRouteScreen extends StatefulWidget {
  const MyAdminAddRouteScreen({super.key});

  @override
  State<MyAdminAddRouteScreen> createState() => _MyAdminAddRouteScreenState();
}

class _MyAdminAddRouteScreenState extends State<MyAdminAddRouteScreen> {
  final TextEditingController _routeNameController = TextEditingController();
  final TextEditingController _routePriceController = TextEditingController();
  late User _user;
  late String _token;
  List<Stop> stops = [];
  Stop? selectedStop;
  bool _isLoading = true;
  String? startTimeValue;
  String? endTimeValue;

  List<String> hoursAM = <String>[
    '6:00',
    '7:00',
    '8:00',
    '9:00',
    '10:00',
    '11:00',
    '12:00'
  ];
  List<String> hoursPM = <String>[
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
    '18:00',
    '19:00',
    '20:00',
    '21:00',
    '22:00',
    '23:00'
  ];

  @override
  void initState() {
    super.initState();
    _user = Provider.of<UserProvider>(context, listen: false).userData;
    _token = _user.token;
    startTimeValue = hoursAM.first;
    endTimeValue = hoursPM.first;
    _fetchBusStops(_token);
  }

  Future<void> _fetchBusStops(String token) async {
    try {
      await Provider.of<BusStopProvider>(context, listen: false)
          .getAllBusStops(token);
      List<Stop> fetchedStops =
          // ignore: use_build_context_synchronously
          Provider.of<BusStopProvider>(context, listen: false).stops;
      setState(() {
        stops = fetchedStops;
        if (stops.isNotEmpty) {
          selectedStop = stops.first;
        }
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching bus stops: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void navigateTapBarScreen() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const MyTapBarAdminWidget()));
  }

  Future<void> _createBusRoute() async {
    try {
      final routeName = _routeNameController.text;
      final routePrice = _routePriceController.text;
      final routeStartTime = startTimeValue;
      final routeEndTime = endTimeValue;
      final routeBusStopUuid = selectedStop?.id ?? '';
      await Provider.of<RouteProvider>(context, listen: false).createBusRoute(
          routeName,
          routePrice,
          routeStartTime,
          routeEndTime,
          routeBusStopUuid,
          _token);
      _routeNameController.clear();
      _routePriceController.clear();
      navigateTapBarScreen();
    } catch (e) {
      print('Error creating bus route: $e');
    }
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
          'Agregar Ruta',
          style: TextStyle(
              fontSize: 14,
              color: Color(0xFFB5B5B5),
              fontWeight: FontWeight.w600),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyTextFieldWidget(
                        width: MediaQuery.of(context).size.width * 0.9,
                        controllerTextField: _routeNameController,
                        text: 'Nombre(s)',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa un nombre de usuario';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyTextFieldWidget(
                        width: MediaQuery.of(context).size.width * 0.9,
                        controllerTextField: _routePriceController,
                        text: 'Precio',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa un precio';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xFFEDEDED),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButton<String>(
                            menuMaxHeight: 200,
                            iconEnabledColor: const Color(0xFFB8B8B8),
                            iconSize: 20,
                            style: const TextStyle(
                                color: Color(0xFFB8B8B8),
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                            underline: Container(),
                            value: startTimeValue,
                            onChanged: (String? value) {
                              setState(() {
                                startTimeValue = value!;
                              });
                            },
                            items: hoursAM
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 135),
                                  child: Text(value),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xFFEDEDED),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButton<String>(
                            menuMaxHeight: 200,
                            iconEnabledColor: const Color(0xFFB8B8B8),
                            iconSize: 20,
                            style: const TextStyle(
                                color: Color(0xFFB8B8B8),
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                            underline: Container(),
                            value: endTimeValue,
                            onChanged: (String? value) {
                              setState(() {
                                endTimeValue = value!;
                              });
                            },
                            items: hoursPM
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 135),
                                  child: Text(value),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color(0xFFEDEDED)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButton<Stop>(
                        menuMaxHeight: 200,
                        iconEnabledColor: const Color(0xFFB8B8B8),
                        iconSize: 20,
                        style: const TextStyle(
                            color: Color(0xFFB8B8B8),
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                        underline: Container(),
                        value: selectedStop,
                        onChanged: (Stop? newValue) {
                          setState(() {
                            selectedStop = newValue!;
                          });
                        },
                        items: stops.map<DropdownMenuItem<Stop>>((Stop stop) {
                          return DropdownMenuItem<Stop>(
                            value: stop,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 255),
                              child: Text(stop.name),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    textButton: 'Agregar',
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 40,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF01142B),
                    colorText: const Color(0xFFFFFFFF),
                    onPressed: () {
                      _createBusRoute();
                    },
                  )
                ],
              ),
            ),
    );
  }
}

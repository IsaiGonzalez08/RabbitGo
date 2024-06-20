import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/domain/models/Stop/stop.dart';
import 'package:rabbit_go/domain/models/User/user.dart';
import 'package:rabbit_go/domain/use_cases/Stop/use_case_stop.dart';
import 'package:rabbit_go/infraestructure/repositories/Stop/stop_repository_impl.dart';
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
  final getAllBusStops = GetAllBusStopsUseCase(StopRepositoryImpl());

  final TextEditingController _routeNameController = TextEditingController();
  final TextEditingController _routePriceController = TextEditingController();
  final TextEditingController _routeStartTimeController =
      TextEditingController();
  final TextEditingController _routeEndTimeController = TextEditingController();
  late User _user;
  late String _token;

  List<Stop> stops = [];
  Stop? selectedStop;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _user = Provider.of<UserProvider>(context, listen: false).userData;
    _token = _user.token;
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
      final routeStartTime = _routeStartTimeController.text;
      final routeEndTime = _routeEndTimeController.text;
      final routeBusStopUuid = selectedStop?.id ?? '';
      await Provider.of<RouteProvider>(context, listen: false).createBusRoute(
          routeName,
          routePrice,
          routeStartTime,
          routeEndTime,
          routeBusStopUuid,
          _token);
      _routeNameController.clear();
      _routeEndTimeController.clear();
      _routeStartTimeController.clear();
      _routeEndTimeController.clear();
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
                        controllerTextField: _routeStartTimeController,
                        text: 'Hora de Inicio',
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
                        controllerTextField: _routeEndTimeController,
                        text: 'Hora de Termino',
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
                  if (stops.isNotEmpty)
                    DropdownButton<Stop>(
                      value: selectedStop,
                      onChanged: (Stop? newValue) {
                        setState(() {
                          selectedStop = newValue!;
                        });
                      },
                      items: stops.map<DropdownMenuItem<Stop>>((Stop stop) {
                        return DropdownMenuItem<Stop>(
                          value: stop,
                          child: Text(stop.name), // Solo muestra el nombre
                        );
                      }).toList(),
                    )
                  else
                    const CircularProgressIndicator(),
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

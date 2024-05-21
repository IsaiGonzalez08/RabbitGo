import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/domain/use_cases/Route/use_case_route.dart';
import 'package:rabbit_go/domain/use_cases/Stop/use_case_stop.dart';
import 'package:rabbit_go/infraestructure/repositories/route_repository_impl.dart';
import 'package:rabbit_go/infraestructure/repositories/stop_repository_impl.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';
import 'package:rabbit_go/presentation/widgets/textfield_widget.dart';

import '../../domain/models/Stop/stop.dart';
import '../../infraestructure/providers/user_provider.dart';

class MyAdminUpdateRouteScreen extends StatefulWidget {
  final String id;
  const MyAdminUpdateRouteScreen({super.key, required this.id});

  @override
  State<MyAdminUpdateRouteScreen> createState() =>
      _MyAdminUpdateRouteScreenState();
}

class _MyAdminUpdateRouteScreenState extends State<MyAdminUpdateRouteScreen> {
  final getAllBusStops = GetAllBusStopsUseCase(StopRepositoryImpl());
  final updateBusRoute = UpdateBusRouteUseCase(RouteRepositoryImpl());
  final TextEditingController _routeNameController = TextEditingController();
  final TextEditingController _routePriceController = TextEditingController();
  final TextEditingController _routeStartTimeController =
      TextEditingController();
  final TextEditingController _routeEndTimeController = TextEditingController();
  final TextEditingController _routeBusStopController = TextEditingController();
  List<String> list = [];
  String? dropdownValue;
  late String id;

  @override
  void initState() {
    super.initState();
    final token = Provider.of<UserProvider>(context, listen: false).token;
    if (token != null) {
      _fetchBusStops(token);
    }
  }

  Future<void> _fetchBusStops(String token) async {
    try {
      List<Stop> stops = await getAllBusStops.getAllBusStops(token);
      setState(() {
        list = stops.map((stop) => stop.id).toList();
        if (list.isNotEmpty) {
          dropdownValue = list.first;
        }
      });
    } catch (e) {
      print('Error fetching bus stops: $e');
    }
  }

  Future<void> _updateBusRoute() async {
    try {
      setState(() {
        id = widget.id;
      });
      final token = Provider.of<UserProvider>(context, listen: false).token;
      if (token != null) {
        final routeName = _routeNameController.text;
        final routePrice = _routePriceController.text;
        final routeStartTime = _routeStartTimeController.text;
        final routeEndTime = _routeEndTimeController.text;
        final routeBusStop = _routeBusStopController.text;
        updateBusRoute.updateBusStop(routeName, routePrice, routeStartTime,
            routeEndTime, routeBusStop, token, id);
      }
    } catch (e) {
      print('Error fetching bus stops: $e');
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
          'Actualizar Ruta',
          style: TextStyle(
              fontSize: 14,
              color: Color(0xFFB5B5B5),
              fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
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
            const SizedBox(
              height: 10,
            ),
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
            const SizedBox(
              height: 10,
            ),
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
            const SizedBox(
              height: 10,
            ),
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
            const SizedBox(
              height: 10,
            ),
            if (list.isNotEmpty)
              DropdownMenu<String>(
                initialSelection: dropdownValue ?? '',
                controller: _routeBusStopController,
                width: MediaQuery.of(context).size.width * 0.9,
                menuStyle: const MenuStyle(
                  backgroundColor: MaterialStatePropertyAll(Color(0xFFEDEDED)),
                ),
                menuHeight: 150,
                textStyle: const TextStyle(
                    color: Color(0xFFB8B8B8),
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
                inputDecorationTheme: const InputDecorationTheme(
                    iconColor: Color(0xFFB8B8B8),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Color(0xFFEDEDED)),
                onSelected: (String? value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                dropdownMenuEntries:
                    list.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              )
            else
              const CircularProgressIndicator(),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              textButton: 'Actualizar',
              width: MediaQuery.of(context).size.width * 0.438,
              height: 40,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF01142B),
              colorText: const Color(0xFFFFFFFF),
              onPressed: () {
                _updateBusRoute();
              },
            )
          ],
        ),
      ),
    );
  }
}

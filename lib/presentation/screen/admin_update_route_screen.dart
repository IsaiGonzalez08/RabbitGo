import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/horizontal_scrollbar.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/presentation/providers/bus_stops_provider.dart';
import 'package:rabbit_go/presentation/providers/route_provider.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';
import 'package:rabbit_go/presentation/widgets/tapbar_admin.dart';
import 'package:rabbit_go/presentation/widgets/textfield_widget.dart';

import '../../domain/models/Stop/stop.dart';

class MyAdminUpdateRouteScreen extends StatefulWidget {
  final String id;
  final BuildContext context;
  const MyAdminUpdateRouteScreen(
      {super.key, required this.id, required this.context});

  @override
  State<MyAdminUpdateRouteScreen> createState() =>
      _MyAdminUpdateRouteScreenState();
}

class _MyAdminUpdateRouteScreenState extends State<MyAdminUpdateRouteScreen> {
  final TextEditingController _routeNameController = TextEditingController();
  final TextEditingController _routePriceController = TextEditingController();
  late String id;
  List<Stop> stops = [];
  List<Stop> selectedStops = [];
  List<String> colonies = [];
  List<String> selectedColonies = [];
  Stop? selectedStop;
  bool _isLoading = true;
  String? startTimeValue;
  String? endTimeValue;
  final TextEditingController _coloniesController = TextEditingController();

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
    startTimeValue = hoursAM.first;
    endTimeValue = hoursPM.first;
    _fetchBusStops();
    _loadColonies();
  }

  void _loadColonies() {
    final coloniasString = dotenv.env['COLONIAS'] ?? '';
    setState(() {
      colonies = coloniasString.split(',').map((e) => e.trim()).toList();
    });
  }

  Future<void> _fetchBusStops() async {
    try {
      await Provider.of<BusStopProvider>(context, listen: false)
          .getAllBusStops();
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

  void navigateHomeAdmin() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const MyTapBarAdminWidget()));
  }

  Future<void> _updateBusRoute() async {
    try {
      setState(() {
        id = widget.id;
      });
      final routeUuid = id;
      final routeName = _routeNameController.text[0].toUpperCase() +
          _routeNameController.text.substring(1);
      final routePrice = int.parse(_routePriceController.text);
      final routeStartTime = startTimeValue;
      final routeEndTime = endTimeValue;
      final listColonies = _coloniesController.text
          .split(',')
          .map((colony) => colony.trim())
          .toList();
      final routeBusStopUuids = selectedStops.map((stop) => stop.id).toList();
      await Provider.of<RouteProvider>(context, listen: false).updateBusRoute(
        routeUuid,
        routeName,
        routePrice,
        routeStartTime,
        routeEndTime,
        listColonies,
        routeBusStopUuids
      );
      navigateHomeAdmin();
    } catch (e) {
      print('Error updating bus route: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFFFFF),
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
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
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
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d*')),
                          ],
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
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
                              items: hoursAM.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.252),
                                    child: Text(value),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
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
                              items: hoursPM.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.252),
                                    child: Text(value),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: selectedColonies.isNotEmpty ? 110 : 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xFFEDEDED)),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 5, left: 5, right: 5),
                        child: MultiSelectDialogField(
                          buttonIcon: const Icon(
                            Icons.arrow_drop_down,
                            size: 20,
                            color: Color(0xFFB8B8B8),
                          ),
                          items: colonies
                              .map((colony) =>
                                  MultiSelectItem<String>(colony, colony))
                              .toList(),
                          title: const Text("Seleccionar Colonias"),
                          decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide.none)),
                          selectedColor: const Color(0xFF01142B),
                          buttonText: const Text(
                            "Seleccionar Colonias",
                            style: TextStyle(
                                color: Color(0xFFB8B8B8),
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                          onConfirm: (results) {
                            setState(() {
                              selectedColonies = results.cast<String>();
                              _coloniesController.text = selectedColonies.join(
                                  ', '); // Actualiza el TextEditingController
                            });
                          },
                          chipDisplay: MultiSelectChipDisplay(
                            scroll: true,
                            scrollBar: HorizontalScrollBar(isAlwaysShown: true),
                            onTap: (item) {
                              setState(() {
                                selectedColonies.remove(item as String);
                                _coloniesController.text =
                                    selectedColonies.join(', ');
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: selectedStops.isNotEmpty ? 110 : 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xFFEDEDED)),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 5, left: 5, right: 5),
                        child: MultiSelectDialogField(
                          buttonIcon: const Icon(
                            Icons.arrow_drop_down,
                            size: 20,
                            color: Color(0xFFB8B8B8),
                          ),
                          items: stops
                              .map((stop) =>
                                  MultiSelectItem<Stop>(stop, stop.name))
                              .toList(),
                          title: const Text("Seleccionar Paradas"),
                          decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide.none)),
                          selectedColor: const Color(0xFF01142B),
                          buttonText: const Text(
                            "Seleccionar Paradas",
                            style: TextStyle(
                                color: Color(0xFFB8B8B8),
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                          onConfirm: (results) {
                            setState(() {
                              selectedStops = results.cast<Stop>();
                            });
                          },
                          chipDisplay: MultiSelectChipDisplay(
                            scroll: true,
                            scrollBar: HorizontalScrollBar(isAlwaysShown: true),
                            onTap: (item) {
                              setState(() {
                                selectedStops.remove(item);
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      textButton: 'Actualizar',
                      width: MediaQuery.of(context).size.width * 0.9,
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
      ),
    );
  }
}

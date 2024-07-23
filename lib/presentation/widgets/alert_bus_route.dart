import 'package:flexible_polyline_dart/flutter_flexible_polyline.dart';
import 'package:flexible_polyline_dart/latlngz.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/domain/models/Path/path.dart';
import 'package:rabbit_go/presentation/providers/results_provider.dart';
import 'package:rabbit_go/presentation/providers/path_provider.dart';
import 'package:rabbit_go/presentation/widgets/alert_report.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';
import 'package:rabbit_go/presentation/widgets/tapbar_widget.dart';

class MyBusRouteAlert extends StatefulWidget {
  final String name, routeId;
  final int price;
  final List<dynamic> colonies;
  const MyBusRouteAlert(
      {Key? key,
      required this.name,
      required this.routeId,
      required this.price,
      required this.colonies})
      : super(key: key);

  @override
  State<MyBusRouteAlert> createState() => _MyBusRouteAlertState();
}

class _MyBusRouteAlertState extends State<MyBusRouteAlert> {
  bool _isExpanded = false;
  bool _iconToggled = false;
  bool _buttonVisible = false;
  bool isFavorite = false;
  late List<PathModel> paths;
  late List<dynamic> stringList;
  late String routeId;
  String estimatedTripTime = '';
  String description = '';
  double jamFactor = 0.0;

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
      MaterialPageRoute(builder: (context) => const MyTapBarWidget(index: 0,)),
    );
  }

  void _showDialogReportBusRoute(
      String routeName, String routeId, int price, List<dynamic> colonies) {
    showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return MyAlertReportBusRoute(
          name: routeName,
          routeId: routeId,
          price: price,
          colonies: colonies,
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
  void initState() {
    super.initState();
    routeId = widget.routeId;
    stringList = widget.colonies;
    _getRoutePath(routeId);
  }

  Future<void> _getRoutePath(String busRouteId) async {
    await Provider.of<PathProvider>(context, listen: false)
        .getRoutePaths(busRouteId);
    print('ya hice el la petición para obtener path por id');
    getCoordinates();
  }

  Future<void> getCoordinates() async {
    paths = Provider.of<PathProvider>(context, listen: false).paths;
    for (var path in paths) {
      estimatedTripTime = path.estimatedTripTime;
      print(path.routeCoordinates);
    }
    if (paths.isNotEmpty) {
      List<LatLng> firstPathCoordinates = paths.first.routeCoordinates;
      List<LatLng> lastPathCoordinates = paths.last.routeCoordinates;
      List<LatLng> allCoordinates = firstPathCoordinates + lastPathCoordinates;
      for (var coordinate in allCoordinates) {
        print('cordenadas unidas: $coordinate');
      }
      const int maxChunkSize = 200;
      for (int i = 0; i < allCoordinates.length; i += maxChunkSize) {
        List<LatLng> chunk = allCoordinates.sublist(
            i,
            i + maxChunkSize > allCoordinates.length
                ? allCoordinates.length
                : i + maxChunkSize);
        encodeCoordinates(chunk);
      }
    } else {
      print('La lista de paths esta vacia');
    }
  }

  Future<void> encodeCoordinates(List<LatLng> coordinates) async {
    final newCoordinates = convertToLatLngZ(coordinates);
    String coordinatesEncoded =
        FlexiblePolyline.encode(newCoordinates, 5, ThirdDimension.ABSENT, 0);
    print('El script es $coordinatesEncoded');
    await getTraficFlow(coordinatesEncoded);
  }

  Future<void> getTraficFlow(String coordinatesEncoded) async {
    await Provider.of<ResultsProvider>(context, listen: false)
        .getTrafficResults(coordinatesEncoded);
    providerResults();
  }

  Future<void> providerResults() async {
    final results =
        Provider.of<ResultsProvider>(context, listen: false).results;
    double totalJamFactor = 0.0;
    for (var result in results) {
      totalJamFactor += result.flowModel.jamFactor;
      setState(() {
        description = result.locationModel.description;
      });
    }
    setState(() {
      jamFactor = totalJamFactor;
    });
  }

  List<LatLngZ> convertToLatLngZ(List<LatLng> coordinates) {
    return coordinates
        .map((coordinate) =>
            LatLngZ(coordinate.latitude, coordinate.longitude, 0))
        .toList();
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
        maxHeight: _isExpanded ? 430 : 210.0,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/Bus.png', width: 50),
                      const SizedBox(
                        width: 20,
                      ),
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
                          description.isEmpty
                              ? const Center(child: CircularProgressIndicator())
                              : SizedBox(
                                  width: 200,
                                  child: Text(
                                    description,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ))
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, bottom: 15),
                    child: InkWell(
                      onTap: () {
                        if (isFavorite) {
                          setState(() {
                            isFavorite =
                                false; //AQUI SE HARA EL POST PARA MANDARLO A LISTA DE FAVORITOS
                          });
                        } else {
                          setState(() {
                            isFavorite =
                                true; //AQUI SE HARA EL METODO REMOVE PARA QUITAR DE FAVORITOS
                          });
                        }
                      },
                      child: Image.asset(
                        isFavorite
                            ? 'assets/images/favorite.png'
                            : 'assets/images/active_favorite.png',
                        width: 25,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 5,
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
            const SizedBox(
              height: 5,
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
                  const SizedBox(
                    height: 5,
                  ),
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
                    child: SizedBox(
                        width: double.infinity,
                        height: 105,
                        child: Text(combinedText)),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(children: [
                Image.asset(
                  'assets/images/acute.png',
                  width: 20,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  'Tiempo aproximado de llegada: $estimatedTripTime.',
                  style: const TextStyle(
                      color: Color(0xFF01142B),
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                )
              ]),
              const SizedBox(
                height: 5,
              ),
              Row(children: [
                Image.asset(
                  'assets/images/traffic_jam.png',
                  width: 20,
                ),
                const SizedBox(
                  width: 4,
                ),
                if (jamFactor == 0.0)
                  const Center(child: CircularProgressIndicator())
                else
                  Text(
                    'Estado del trafico $jamFactor.',
                    style: const TextStyle(
                        color: Color(0xFF01142B),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  )
              ]),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.width * 0.02,
                ),
                child: CustomButton(
                  onPressed: () {
                    _showDialogReportBusRoute(widget.name, widget.routeId,
                        widget.price, widget.colonies);
                  },
                  textButton: 'Reporte de queja',
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 32,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF990404),
                  colorText: const Color(0xFFFFFFFF),
                ),
              ),
            ],
            CustomButton(
              onPressed: () async {
                await Provider.of<PathProvider>(context, listen: false)
                    .getRoutePaths(routeId);
                navigateMap();
              },
              textButton: 'Trazar ruta',
              width: MediaQuery.of(context).size.width * 0.9,
              height: 32,
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

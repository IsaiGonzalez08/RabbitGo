import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/domain/models/Route/route.dart';
import 'package:rabbit_go/presentation/providers/route_coordinates_provider.dart';
import 'package:rabbit_go/presentation/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:rabbit_go/presentation/widgets/tapbar_widget.dart';

class MyAlertMarker extends StatefulWidget {
  final String? markerId;
  const MyAlertMarker({Key? key, required this.markerId}) : super(key: key);

  @override
  State<MyAlertMarker> createState() => _MyAlertMarkerState();
}

class _MyAlertMarkerState extends State<MyAlertMarker> {
  late String? markerId;
  String? token;
  late Future<List<RouteModel>> futureRoutes;
  bool isButtonEnabled = false;
  late String? routeId;
  List<LatLng>? listCordinates = [];

  void providerCoordinates(List<LatLng>? coordinates) {
    Provider.of<RouteCoordinatesProvider>(context, listen: false)
        .setDataCoordinates(coordinates);
  }

  void navigateMap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyTapBarWidget()),
    );
  }

  Future<List<RouteModel>> _getBusRoute(String? markerId) async {
    try {
      String url = ('https://rabbitgo.sytes.net/bus/route/at/$markerId');

      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': token!, 'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);

        if (jsonResponse.containsKey('data')) {
          List<dynamic> routeJson = jsonResponse['data'];
          List<RouteModel> routes =
              routeJson.map((route) => RouteModel.fromJson(route)).toList();
          for (var dataRoute in routes) {
            routeId = dataRoute.uuid;
          }
          return routes;
        } else {
          throw Exception('Response does not contain "data"');
        }
      } else {
        throw ('error en la petición: ${response.statusCode}');
      }
    } catch (error) {
      throw ('Error al conectar con el servidor: $error');
    }
  }

  _getRoutePath() async {
    try {
      listCordinates?.clear();

      String url = ('https://rabbitgo.sytes.net/path/route/$routeId');

      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': token!, 'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        if (responseData != null && responseData['data'] != null) {
          final List<dynamic> data = responseData['data'];
          listCordinates = data.expand((element) {
            final path = element['path'] as List<dynamic>;
            return path.map((coord) => LatLng(coord[0], coord[1]));
          }).toList();
          providerCoordinates(listCordinates!);
          navigateMap();
        } else {
          throw ('Los datos recibidos de la API no son válidos.');
        }
      }
    } catch (error) {
      throw ('Error al conectar con el servidor: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    markerId = widget.markerId;
    token = Provider.of<UserProvider>(context, listen: false).token;
    futureRoutes = _getBusRoute(markerId);
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
            FutureBuilder<List<RouteModel>>(
              future: futureRoutes,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data!.map((route) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            if (isButtonEnabled) {
                              isButtonEnabled = false;
                            } else {
                              isButtonEnabled = true;
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.07,
                              left: MediaQuery.of(context).size.width * 0.07),
                          decoration: BoxDecoration(
                              color: isButtonEnabled
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
                    }).toList(),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
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
              color: isButtonEnabled
                  ? const Color(0xFF01142B)
                  : const Color(0xFFB6B6B6),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextButton(
                onPressed: isButtonEnabled
                    ? () {
                        _getRoutePath();
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

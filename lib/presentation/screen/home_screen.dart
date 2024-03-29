import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rabbit_go/infraestructure/controllers/home_controller.dart';
import 'package:rabbit_go/infraestructure/controllers/user_controller.dart';
import 'package:rabbit_go/infraestructure/controllers/wait_controller.dart';
import 'package:rabbit_go/infraestructure/helpers/asset_to_bytes.dart';
import 'package:rabbit_go/presentation/widgets/alert_widget.dart';
import 'package:http/http.dart' as http;

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  late WaitController _waitController;
  late HomeController _homeController;
  String? token;
  Iterable markers = [];
  LatLng? userLocation;

  Future<void> _checkAndShowAlert() async {
    bool isLocationPermissionGranted = await _waitController.checkPermission();

    if (!isLocationPermissionGranted) {
      Future.delayed(const Duration(seconds: 3), () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return const MyAlertWidget();
          },
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _waitController = WaitController(Permission.location);
    _homeController = HomeController();
    _checkAndShowAlert();
    token = Provider.of<UserData>(context, listen: false).token;
    getMarkers(token);
  }

  getMarkers(String? token) async {
    try {
      String url = 'http://rabbitgo.sytes.net/bus/stop/';

      final icon = BitmapDescriptor.fromBytes(
          await assetToBytes('assets/images/MapMarker.png'));

      final response =
          await http.get(Uri.parse(url), headers: {'Authorization': token!});

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['data'];

        Iterable generatedMarkers = data.map((item) {
          String markerId = item['uuid'];
          double latitude = item["latitude"];
          double longitude = item["longitude"];
          LatLng latLngMarker = LatLng(latitude, longitude);
          return Marker(
              markerId: MarkerId(markerId), position: latLngMarker, icon: icon);
        });

        setState(() {
          markers = generatedMarkers;
        });
      } else {}
    } catch (error) {
      print('Error con el servidor: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              mapToolbarEnabled: false,
              onMapCreated: (GoogleMapController controller) async {
                _homeController.onMapCreated(controller);
                LatLng? location = await _homeController.getUserLocation();
                if (location != null) {
                  if (mounted) {
                    setState(() {
                      userLocation = location;
                    });
                    controller.animateCamera(
                        CameraUpdate.newLatLngZoom(location, 14));
                  }
                  controller
                      .animateCamera(CameraUpdate.newLatLngZoom(location, 14));
                }
              },
              markers: Set.from(
                markers,
              ),
              compassEnabled: false,
              initialCameraPosition: const CameraPosition(
                target: LatLng(16.75973, -93.11308),
                zoom: 14,
              ),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              padding: const EdgeInsets.only(
                top: 100.0,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.06,
                    top: MediaQuery.of(context).size.height * 0.06),
                child: Container(
                  width: 320,
                  height: 40,
                  decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        )
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.03)),
                      Image.asset('assets/images/search.png'),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        'Buscar dirección',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFE0E0E0),
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rabbit_go/domain/models/User/user.dart';
import 'package:rabbit_go/domain/use_cases/Place/use_case_place.dart';
import 'package:rabbit_go/presentation/providers/place_provider.dart';
import 'package:rabbit_go/presentation/providers/route_coordinates_provider.dart';
import 'package:rabbit_go/presentation/providers/home_controller.dart';
import 'package:rabbit_go/presentation/providers/user_provider.dart';
import 'package:rabbit_go/presentation/providers/wait_provider.dart';
import 'package:rabbit_go/infraestructure/helpers/asset_to_bytes.dart';
import 'package:rabbit_go/infraestructure/helpers/gradient_polyline.dart';
import 'package:rabbit_go/infraestructure/repositories/Place/place_repository_impl.dart';
import 'package:rabbit_go/presentation/widgets/alert_widget.dart';
import 'package:http/http.dart' as http;
import 'package:rabbit_go/presentation/widgets/marker_alert_widget.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen>
    with TickerProviderStateMixin {
  late Polyline polyline;
  late Polyline polylineFromAlert;
  late WaitProvider _waitProvider;
  late HomeController _homeController;
  Iterable markers = [];
  List<Marker> hereMarkers = [];
  LatLng? userLocation;
  late User _user;
  late String _token;
  final onResults = GetPlaceUseCase(PlaceRepositoryImpl());

  List<Color> gradientColors = [
    const Color(0xFF01142B),
  ];

  _showDialogBusStops(String markerId) {
    showBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return MyAlertMarker(markerId: markerId);
        },
        constraints: const BoxConstraints(
            minWidth: 0.0,
            maxWidth: double.infinity,
            minHeight: 0.0,
            maxHeight: 500));
  }

  getBusStops(String? token) async {
    try {
      if (token == null) {
        throw Exception('El token es nulo');
      }
      final icon = BitmapDescriptor.fromBytes(
          await assetToBytes('assets/images/MapMarker.png'));
      final response = await http.get(
          Uri.parse('https://rabbitgo.sytes.net/bus/stop/'),
          headers: {'Authorization': token});
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['data'];
        Iterable generatedMarkers = data.map((item) {
          String markerId = item['uuid'];
          double latitude = item["latitude"];
          double longitude = item["longitude"];
          LatLng latLngMarker = LatLng(latitude, longitude);
          return Marker(
              onTap: () {
                _showDialogBusStops(markerId);
              },
              markerId: MarkerId(markerId),
              position: latLngMarker,
              icon: icon);
        });
        setState(() {
          markers = generatedMarkers;
        });
      }
    } catch (error) {
      throw Exception('Error con el servidor: $error');
    }
  }

  Future<void> _showAlertPermissionsLocation() async {
    bool isLocationPermissionGranted = await _waitProvider.checkPermission();
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
    _waitProvider = WaitProvider(Permission.location);
    _homeController = HomeController();
    _showAlertPermissionsLocation();
    _user = Provider.of<UserProvider>(context, listen: false).userData;
    _token = _user.token;
    getBusStops(_token);
    List<LatLng>? coordinates =
        Provider.of<RouteCoordinatesProvider>(context, listen: false)
            .coordinates;
    polyline = GradientPolyline(
      polylineId: const PolylineId('route'),
      points: coordinates!,
      gradientColors: gradientColors,
      width: 3,
    );
  }

  Future<void> _getPlace(String query) async {
    try {
      await Provider.of<PlaceProvider>(context, listen: false)
          .handleSubmitted(query);
    } catch (e) {
      throw ('el error es $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Consumer<PlaceProvider>(builder: (context, placeProvider, child) {
          return GoogleMap(
            onMapCreated: (GoogleMapController controller) async {
              _homeController.onMapCreated(controller);
              LatLng? location = await _homeController.getUserLocation();
              if (location != null) {
                if (mounted) {
                  setState(() {
                    userLocation = location;
                  });
                  controller
                      .animateCamera(CameraUpdate.newLatLngZoom(location, 14));
                }
                controller
                    .animateCamera(CameraUpdate.newLatLngZoom(location, 14));
              }
            },
            polylines: {polyline},
            markers: Set.from({...markers, ...placeProvider.hereMarkers}),
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
          );
        }),
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.height * 0.08),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 40,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 1),
                )
              ]),
              child: Builder(builder: (context) {
                return TextField(
                  onSubmitted: (value) => _getPlace(value),
                  textAlignVertical: TextAlignVertical.center,
                  cursorHeight: 25.0,
                  cursorColor: const Color(0xFF01142B),
                  style: const TextStyle(
                      color: Color(0xFF01142B), fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Buscar un lugar',
                    hintStyle: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFFE0E0E0),
                        fontWeight: FontWeight.w500),
                    filled: true,
                    fillColor: const Color(0xFFFFFFFF),
                    prefixIcon: Image.asset(
                      'assets/images/Search.png',
                      width: 10,
                    ), // Icono dentro del campo de texto
                  ),
                );
              }),
            )),
      ],
    );
  }
}

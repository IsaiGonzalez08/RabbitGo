import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rabbit_go/data/repositories_impl/search_place_repository_impl.dart';
import 'package:rabbit_go/domain/api/search_place_api.dart';
import 'package:rabbit_go/domain/models/route_coordinates_model.dart';
import 'package:rabbit_go/domain/models/place.dart';
import 'package:rabbit_go/infraestructure/controllers/home_controller.dart';
import 'package:rabbit_go/infraestructure/controllers/search_place_controller.dart';
import 'package:rabbit_go/infraestructure/controllers/user_controller.dart';
import 'package:rabbit_go/infraestructure/controllers/wait_controller.dart';
import 'package:rabbit_go/infraestructure/helpers/asset_to_bytes.dart';
import 'package:rabbit_go/infraestructure/helpers/gradient_polyline.dart';
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
  final TextEditingController _searchController = TextEditingController();
  late WaitController _waitController;
  late HomeController _homeController;
  String? token;
  Iterable markers = [];
  List<Marker> hereMarkers = [];
  LatLng? userLocation;
  CancelToken? _cancelToken;

  List<Color> gradientColors = [
    const Color(0xFFA3CCFD),
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

  getPlacesFromHereAPI(String query) async {
    Dio dio = Dio();
    try {
      _cancelToken = CancelToken();
      final response = await dio.get(
        'https://discover.search.hereapi.com/v1/discover',
        queryParameters: {
          "apiKey": 'gKmQKAgOGGi4sP8OgC1vc5WK2z_ZLv7KLLqQqNFfhE0',
          "q": query,
          "in": "bbox:-93.226372,16.719187,-93.050247,16.804001"
        },
        cancelToken: _cancelToken,
      );
      final results = (response.data['items'] as List)
          .map(
            (e) => Place.fromJson(e),
          )
          .toList();
      hereMarkers.clear();
      for (var place in results) {
        final id = place.id;
        LatLng position = place.position;
        hereMarkers.add(Marker(
            markerId: MarkerId(id),
            position: position,
            infoWindow:
                InfoWindow(title: place.title, snippet: place.address)));
      }
      setState(() {
        hereMarkers = hereMarkers;
      });
      _cancelToken = null;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {}
    }
  }

  Future<void> _showAlertPermissionsLocation() async {
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
    _showAlertPermissionsLocation();
    token = Provider.of<UserData>(context, listen: false).token;
    getBusStops(token);
    List<LatLng>? coordinates =
        Provider.of<RouteCoordinatesModel>(context, listen: false).coordinates;
    polyline = GradientPolyline(
      polylineId: const PolylineId('route'),
      points: coordinates!,
      gradientColors: gradientColors,
      width: 3,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchPlaceController(SearchRepositoryImpl(
        SearchAPI(Dio()),
      )),
      child: Stack(
        children: [
          GoogleMap(
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
            markers: Set.from({...markers, ...hereMarkers}),
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
                    controller: _searchController,
                    onSubmitted: (value) => getPlacesFromHereAPI(value),
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
      ),
    );
  }
}

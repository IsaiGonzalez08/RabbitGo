import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rabbit_go/domain/models/Stop/stop.dart';
import 'package:rabbit_go/domain/models/User/user.dart';
import 'package:rabbit_go/presentation/providers/address_provider.dart';
import 'package:rabbit_go/presentation/providers/bus_stops_provider.dart';
import 'package:rabbit_go/presentation/providers/place_provider.dart';
import 'package:rabbit_go/presentation/providers/route_provider.dart';
import 'package:rabbit_go/presentation/providers/user_provider.dart';
import 'package:rabbit_go/presentation/providers/wait_provider.dart';
import 'package:rabbit_go/infraestructure/helpers/asset_to_bytes.dart';
import 'package:rabbit_go/presentation/widgets/alert_widget.dart';
import 'package:rabbit_go/presentation/widgets/marker_alert_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen>
    with TickerProviderStateMixin {
  late Polyline polyline;
  late WaitProvider _waitProvider;
  List<Stop> _busStopMarkers = [];
  List<Marker> _hereMarkers = [];
  Set<Marker> _markers = {};
  LatLng? userLocation;
  late User _user;
  late String? _token;
  List<LatLng> myList = [];

  final TextEditingController _searchPlaceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _waitProvider = WaitProvider(Permission.location);
    _user = Provider.of<UserProvider>(context, listen: false).userData;
    _token = _user.token;
    polyline = const Polyline(
      polylineId: PolylineId('route'),
      points: [],
      width: 3,
    );
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _loadUserData();
    await _loadBusStops();
    await _showAlertPermissionsLocation();
    _loadRouteCoordinates();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token') ?? '';
    });
  }

  Future<void> _loadBusStops() async {
    await Provider.of<BusStopProvider>(context, listen: false)
        .getAllBusStops(_token);
    getBusStops();
  }

  Future<void> getBusStops() async {
    _busStopMarkers =
        Provider.of<BusStopProvider>(context, listen: false).stops;
    final icon = BitmapDescriptor.fromBytes(
        await assetToBytes('assets/images/MapMarker.png'));
    Set<Marker> newMarkers = _busStopMarkers.map((stop) {
      return Marker(
        onTap: () {
          _loadBusStopButtomSheet(
              stop.id, stop.latitude.toString(), stop.longitude.toString());
        },
        markerId: MarkerId(stop.id),
        position: LatLng(stop.latitude, stop.longitude),
        icon: icon,
      );
    }).toSet();
    setState(() {
      _markers = newMarkers;
    });
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

  void _loadRouteCoordinates() {
    setState(() {
      myList = Provider.of<RouteProvider>(context, listen: false).routePath;
      polyline = Polyline(
        polylineId: const PolylineId('route'),
        points: myList,
        width: 3,
      );
    });
  }

  Future<void> _getPlace(String query) async {
    try {
      await Provider.of<PlaceProvider>(context, listen: false)
          .handleSubmitted(query);
      setState(() {
        _hereMarkers =
            Provider.of<PlaceProvider>(context, listen: false).hereMarkers;
        _searchPlaceController.clear();
      });
    } catch (e) {
      throw ('el error es $e');
    }
  }

  Future<LatLng?> getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Consumer<PlaceProvider>(builder: (context, placeProvider, child) {
          _hereMarkers = placeProvider.hereMarkers;
          return GoogleMap(
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) async {
              LatLng? location = await getUserLocation();
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
            markers: Set.from({..._markers, ..._hereMarkers}),
            compassEnabled: false,
            initialCameraPosition: const CameraPosition(
              target: LatLng(16.75973, -93.11308),
              zoom: 14,
            ),
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            padding: const EdgeInsets.only(top: 100.0, right: 6),
          );
        }),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.08,
          ),
          child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 40,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: TextField(
                onSubmitted: (value) {
                  _getPlace(value);
                },
                controller: _searchPlaceController,
                cursorColor: const Color(0xFF01142B),
                style: const TextStyle(
                  color: Color(0xFF01142B),
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Buscar un lugar',
                  hintStyle: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFE0E0E0),
                    fontWeight: FontWeight.w500,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFFFFFFF),
                  prefixIcon: Image.asset(
                    'assets/images/Search.png',
                    width: 10,
                  ),
                ),
              )),
        ),
        _hereMarkers.isEmpty
            ? Container()
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 75),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _hereMarkers.clear();
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color(0xFFAB0000),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/close.png',
                                width: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        myList.isEmpty
            ? Container()
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              myList.clear();
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color(0xFF01142B),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/close.png',
                                width: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
      ],
    );
  }

  Future<void> _loadBusStopButtomSheet(
      String stopId, String latitude, String longitude) async {
    await Provider.of<AddressProvider>(context, listen: false)
        .getAddress(latitude, longitude);
    providerAddress(stopId);
  }

  Future<void> providerAddress(String stopId) async {
    final address =
        Provider.of<AddressProvider>(context, listen: false).address;
    final district = address.district;
    final street = address.street;
    final postalCode = address.postalCode;
    showDialogBusStops(stopId, district, street, postalCode);
  }

  Future<void> showDialogBusStops(
      String stopId, String district, String street, String postalCode) async {
    showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return MyAlertMarker(
          stopId: stopId,
          district: district,
          street: street,
          postalCode: postalCode,
        );
      },
      constraints: const BoxConstraints(
        minWidth: 0.0,
        maxWidth: double.infinity,
        minHeight: 0.0,
        maxHeight: 500,
      ),
    );
  }
}

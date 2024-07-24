import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rabbit_go/domain/models/Favorites/favorite.dart';
import 'package:rabbit_go/domain/models/Path/path.dart';
import 'package:rabbit_go/domain/models/Stop/stop.dart';
import 'package:rabbit_go/presentation/providers/address_provider.dart';
import 'package:rabbit_go/presentation/providers/bus_stops_provider.dart';
import 'package:rabbit_go/presentation/providers/path_provider.dart';
import 'package:rabbit_go/presentation/providers/place_provider.dart';
import 'package:rabbit_go/presentation/providers/user_provider.dart';
import 'package:rabbit_go/presentation/providers/wait_provider.dart';
import 'package:rabbit_go/infraestructure/helpers/asset_to_bytes.dart';
import 'package:rabbit_go/presentation/widgets/alert_widget.dart';
import 'package:rabbit_go/presentation/widgets/alert_bus_stop_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rabbit_go/presentation/widgets/clear_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen>
    with TickerProviderStateMixin {
  Set<Polyline> _polylines = {};
  late WaitProvider _waitProvider;
  List<Marker> _hereMarkers = [];
  Set<Marker> _markers = {};
  LatLng? userLocation;
  List<PathModel> paths = [];
  late List<Stop> busStopMarkers;
  late List<FavoriteModel> listFavorites = [];
  late String userId;
  final TextEditingController _searchPlaceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _waitProvider = WaitProvider(Permission.location);
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _showAlertPermissionsLocation();
    await _loadBusStops();
    _loadRouteCoordinates();
    await _loadUserData();
    getRouteLikesById(userId);
  }

  Future<void> _loadBusStops() async {
    await Provider.of<BusStopProvider>(context, listen: false).getAllBusStops();
    await getBusStops();
    createBusStopMarkers();
  }

  Future<void> getBusStops() async {
    busStopMarkers = Provider.of<BusStopProvider>(context, listen: false).stops;
  }

  Future<void> createBusStopMarkers() async {
    final icon = BitmapDescriptor.fromBytes(
        await assetToBytes('assets/images/MapMarker.png'));
    Set<Marker> newMarkers = busStopMarkers.map((stop) {
      return Marker(
        onTap: () {
          _showDialogBusStop(
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

  Future<void> _loadRouteCoordinates() async {
    paths = Provider.of<PathProvider>(context, listen: false).paths;
    Set<Polyline> polylines = {};
    List<Color> colors = [const Color(0xFF01142B), Colors.red];
    for (var i = 0; i < paths.length; i++) {
      var path = paths[i];
      List<LatLng> routeCoordinates = path.routeCoordinates;
      Polyline polyline = Polyline(
        polylineId: PolylineId(path.pathId),
        points: routeCoordinates,
        width: 2,
        color: colors[i % colors.length],
      );
      polylines.add(polyline);
    }
    setState(() {
      _polylines = polylines;
    });
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('id') ?? '';
    });
  }

  Future<void> getRouteLikesById(String id) async {
    await Provider.of<UserProvider>(context, listen: false)
        .getFavoritesById(id);
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
    bool hasBluePolyline =
        _polylines.any((polyline) => polyline.color == const Color(0xFF01142B));
    bool hasRedPolyline =
        _polylines.any((polyline) => polyline.color == Colors.red);
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
            polylines: _polylines,
            markers: Set.from({..._markers, ..._hereMarkers}),
            compassEnabled: false,
            initialCameraPosition: const CameraPosition(
              target: LatLng(16.75973, -93.11308),
              zoom: 13,
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
                    'assets/images/search2.png',
                    width: 10,
                  ),
                ),
              )),
        ),
        _hereMarkers.isEmpty
            ? Container()
            : ClearButton(
                onTap: () {
                  setState(() {
                    _hereMarkers.clear();
                  });
                },
                buttonColor: const Color(0xFFAB0000),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 140)),
        if (hasBluePolyline)
          ClearButton(
              onTap: () {
                setState(() {
                  _polylines.removeWhere(
                      (polyline) => polyline.color == const Color(0xFF01142B));
                });
              },
              buttonColor: const Color(0xFF01142B),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 80)),
        if (hasRedPolyline)
          ClearButton(
              onTap: () {
                setState(() {
                  _polylines
                      .removeWhere((polyline) => polyline.color == Colors.red);
                });
              },
              buttonColor: Colors.red,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 20)),
      ],
    );
  }

  Future<void> _showDialogBusStop(
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
    dialogBusStops(stopId, district, street, postalCode);
  }

  Future<void> dialogBusStops(
      String stopId, String district, String street, String postalCode) async {
    showBottomSheet(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 300,
      showDragHandle: true,
      backgroundColor: const Color(0xFFFFFFFF),
      context: context,
      builder: (BuildContext context) {
        return MyBusStopAlert(
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

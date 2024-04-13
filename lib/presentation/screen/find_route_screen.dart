import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/data/repositories_impl/find_route_repository_impl.dart';
import 'package:rabbit_go/domain/api/find_route_api.dart';
import 'package:rabbit_go/domain/models/route_coordinates_model.dart';
import 'package:rabbit_go/infraestructure/controllers/find_route_controller.dart';
import 'package:rabbit_go/infraestructure/controllers/user_controller.dart';
import 'package:http/http.dart' as http;
import 'package:rabbit_go/presentation/widgets/tapbar_widget.dart';

class MyFindRouteScreen extends StatefulWidget {
  const MyFindRouteScreen({Key? key}) : super(key: key);

  @override
  State<MyFindRouteScreen> createState() => _MyFindRouteScreenState();
}

class _MyFindRouteScreenState extends State<MyFindRouteScreen> {
  String? token;
  List<LatLng>? listCordinates;

  void providerRouteCoordinates(List<LatLng>? coordinates) {
    Provider.of<RouteCoordinatesModel>(context, listen: false)
        .setDataCoordinates(coordinates);
  }

  navigateHome() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const MyTapBarWidget(),
    ));
  }

  getRouteCoordinates(String id) async {
    try {
      String url = 'https://rabbitgo.sytes.net/path/route/$id';

      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Authorization': token!,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        if (responseData != null && responseData['data'] != null) {
          final List<dynamic> data = responseData['data'];
          listCordinates = data.expand((element) {
            final path = element['path'] as List<dynamic>;
            return path.map((coord) => LatLng(coord[0], coord[1]));
          }).toList();
          providerRouteCoordinates(listCordinates!);
          navigateHome();
        } else {
          throw ('Los datos recibidos de la API no son válidos.');
        }
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {}
    }
  }

  @override
  void initState() {
    super.initState();
    token = Provider.of<UserData>(context, listen: false).token;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => FindRouteController(FindRouteRepositoryImpl(
              FindRouteAPI(
                  Dio(), Provider.of<UserData>(context, listen: false)),
            )),
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              iconTheme: const IconThemeData(color: Color(0xFF979797)),
              toolbarHeight: MediaQuery.of(context).size.height * 0.14,
              title: Container(
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
                    onChanged: context.read<FindRouteController>().queryChanged,
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
                      hintText: 'Buscar ruta',
                      hintStyle: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFE0E0E0),
                          fontWeight: FontWeight.w500),
                      filled: true,
                      fillColor: const Color(0xFFFFFFFF),
                      prefixIcon: Image.asset(
                        'assets/images/Search.png', width: 20,
                      ),
                    ),
                  );
                }),
              ),
            ),
            body: Consumer<FindRouteController>(builder: (_, controller, __) {
              final routes = controller.routes;
              if (routes == null) {
              } else if (routes.isEmpty && controller.query.length >= 3) {}
              return ListView.builder(
                itemBuilder: (_, index) {
                  final route = routes[index];
                  return InkWell(
                    onTap: () {
                      final id = route.uuid;
                      getRouteCoordinates(id);
                      listCordinates?.clear();
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.07,
                          left: MediaQuery.of(context).size.width * 0.07),
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: const Color(0xFFF5F5F5),
                        width: 2,
                      )),
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                        color: Color(0xFFE0E0E0),
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
                },
                itemCount: routes!.length,
              );
            })));
  }
}

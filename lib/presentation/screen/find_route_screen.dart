import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/data/repositories_impl/find_route_repository_impl.dart';
import 'package:rabbit_go/domain/api/find_route_api.dart';
import 'package:rabbit_go/infraestructure/controllers/find_route_controller.dart';
import 'package:rabbit_go/infraestructure/controllers/user_controller.dart';

class MyFindRouteScreen extends StatelessWidget {
  const MyFindRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FindRouteController(FindRouteRepositoryImpl(
        FindRouteAPI(Dio(), Provider.of<UserData>(context, listen: false)),
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
                      'assets/images/search.png',
                    ), // Icono dentro del campo de texto
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
                return Container(
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
                          Image.asset('assets/images/Bus.png'),
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
                );
              },
              itemCount: routes!.length,
            );
          })),
    );
  }
}

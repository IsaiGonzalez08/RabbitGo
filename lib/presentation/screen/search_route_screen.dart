import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/infraestructure/controllers/search_route_controller.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';

class MySearchRouteScreen extends StatelessWidget {
  const MySearchRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchRouteController(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: Color(0xFF979797)),
          toolbarHeight: MediaQuery.of(context).size.height * 0.12,
          title: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              )
            ]),
            child: Builder(builder: (context) {
              return CupertinoTextField(
                  onChanged:
                      context.read<SearchRouteController>().onQueryChanged,
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.015,
                      horizontal: MediaQuery.of(context).size.width * 0.01),
                  prefix: Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.03)),
                      Image.asset('assets/images/search.png'),
                    ],
                  ),
                  placeholder: 'Buscar ruta',
                  placeholderStyle: const TextStyle(
                      color: Color(
                        0xFFE0E0E0,
                      ),
                      fontSize: 12));
            }),
          ),
          actions: [
            Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.03))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomButton(
                    textButton: 'Comenzar',
                    width: 320,
                    height: 40,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.1))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

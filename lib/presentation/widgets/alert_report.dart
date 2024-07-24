import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/domain/models/User/user.dart';
import 'package:rabbit_go/presentation/providers/report_provider.dart';
import 'package:rabbit_go/presentation/providers/user_provider.dart';
import 'package:rabbit_go/presentation/widgets/alert_bus_route.dart';
import 'package:rabbit_go/presentation/widgets/alert_create_report.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAlertReportBusRoute extends StatefulWidget {
  final String name, routeId;
  final int price;
  final List<dynamic> colonies;
  final bool isFavorite;
  final String description;
  const MyAlertReportBusRoute(
      {Key? key,
      required this.name,
      required this.routeId,
      required this.price,
      required this.colonies,
      required this.isFavorite,
      required this.description})
      : super(key: key);

  @override
  State<MyAlertReportBusRoute> createState() => _MyAlertReportBusRouteState();
}

class _MyAlertReportBusRouteState extends State<MyAlertReportBusRoute> {
  late User user;
  late String userId;
  late bool isFavorite;
  late String description;
  final TextEditingController _textReportController = TextEditingController();

  Future<void> _createReport() async {
    final text = _textReportController.text;
    await Provider.of<ReportProvider>(context, listen: false)
        .analizeTextReport(text);
    loadResponseTextAnalize(text);
  }

  Future<void> loadResponseTextAnalize(String text) async {
    final report = Provider.of<ReportProvider>(context, listen: false).report;
    final classifications = report.classifications;
    final score = report.score;
    final stars = report.stars;
    await createComplaint(userId, text, score, stars, classifications);
  }

  Future<void> createComplaint(String userId, String complaint, double score,
      int stars, List categories) async {
    final status = await Provider.of<ReportProvider>(context, listen: false)
        .createComplaint(userId, complaint, score, stars, categories);
    if (status == true) {
      await _showConfirmDialog();
    }
  }

  Future<void> _showConfirmDialog() async {
    final status = Provider.of<ReportProvider>(context, listen: false).status;
    if (status == true) {
      _textReportController.clear();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyAlertCreateReport(
            name: widget.name,
            routeId: widget.routeId,
            price: widget.price,
            colonies: widget.colonies,
            isFavorite: widget.isFavorite,
          );
        },
      );
    }
  }

  Future<void> navigateAlertRoute() async {
    Navigator.pop(context);
    Future.delayed(const Duration(milliseconds: 100), () {
      showBottomSheet(
        context: context,
        builder: (context) => MyBusRouteAlert(
          name: widget.name,
          routeId: widget.routeId,
          price: widget.price,
          colonies: widget.colonies,
          isFavorite: widget.isFavorite,
        ),
      );
    });
  }

  @override
  void initState() {
    user = Provider.of<UserProvider>(context, listen: false).userData;
    isFavorite = widget.isFavorite;
    description = widget.description;
    _loadUserData();
    super.initState();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('id') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(30),
            topEnd: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 80,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFEDEDED), width: 2),
                    ),
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
                              SizedBox(
                                  width: 200,
                                  child: Text(
                                    description,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  )),
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
                                ? 'assets/images/active_favorite.png'
                                : 'assets/images/favorite.png',
                            width: 25,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE8E8E8)),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: TextField(
                    controller: _textReportController,
                    maxLines: null,
                    expands: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                      hintText:
                          'Escribe de manera clara los motivos de tu \ninconformidad.',
                      hintStyle: TextStyle(
                        color: Color(0xFF949494),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  onPressed: () {
                    _createReport();
                  },
                  textButton: 'Realizar reporte',
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 32,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF990404),
                  colorText: const Color(0xFFFFFFFF),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  onPressed: () {
                    navigateAlertRoute();
                  },
                  textButton: 'Regresar',
                  width: MediaQuery.of(context).size.width * 0.9,
                  border: Border.all(color: const Color(0xFFE8E8E8)),
                  height: 34,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFFFFFFF),
                  colorText: const Color(0xFF01142B),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

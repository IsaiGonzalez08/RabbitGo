import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/screen/add_list_favorite_screen.dart';
import 'package:rabbit_go/presentation/screen/list_favorite_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyFavoriteRoutesScreen extends StatefulWidget {
  const MyFavoriteRoutesScreen({super.key});

  @override
  State<MyFavoriteRoutesScreen> createState() => _MyFavoriteRoutesScreenState();
}

class _MyFavoriteRoutesScreenState extends State<MyFavoriteRoutesScreen> {
  late String? id;

  @override
  void initState() {
    _loadUserData();
    super.initState();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id');
  }

  void getFavoritesById() {
    
  }

  Future<void> navigateListFavotite() async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const MyListFavotiteScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.08,
              vertical: MediaQuery.of(context).size.width * 0.08),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tus rutas favoritas.',
                    style: TextStyle(
                        color: Color(0xFF01142B),
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const MyAddListFavoriteScreen()));
                    },
                    child: Image.asset(
                      'assets/images/add_blue.png',
                      width: 20,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Crea una lista con tus favoritas rutas para tener diferentes opciones para llegar a tu destino a tiempo.',
                style: TextStyle(
                    color: Color(0xFF979797),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 2,
                color: Color(0xFFF0EEEE),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {

                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: const Color(0xFF01142B))),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Image.asset(
                          'assets/images/active_favorite.png',
                          width: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tus rutas marcadas',
                          style: TextStyle(
                              color: Color(0xFF01142B),
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '[Numero] rutas marcadas.',
                          style: TextStyle(
                              color: Color(0xFF949494),
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

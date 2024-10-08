import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/presentation/providers/user_provider.dart';
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

  Future<void> navigateListFavotite(int favoriteLength) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MyListFavoriteScreen(favoritesLength: favoriteLength)));
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tus rutas favoritas.',
                    style: TextStyle(
                        color: Color(0xFF01142B),
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
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
              Expanded(
                child: Consumer<UserProvider>(builder: (_, controller, __) {
                  if (controller.isLoadingFavorites) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    final favorites = controller.favorites;
                    return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (_, index) {
                        return InkWell(
                          onTap: () {
                            navigateListFavotite(favorites.length);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    border: Border.all(
                                        color: const Color(0xFF01142B))),
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Tus rutas marcadas',
                                    style: TextStyle(
                                        color: Color(0xFF01142B),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    '${favorites.length} rutas marcadas.',
                                    style: const TextStyle(
                                        color: Color(0xFF949494),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

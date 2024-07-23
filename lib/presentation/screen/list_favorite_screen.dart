import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbit_go/presentation/providers/user_provider.dart';
import 'package:rabbit_go/presentation/widgets/card_favorite_route.dart';


class MyListFavotiteScreen extends StatefulWidget {
  final int favoritesLength;
  const MyListFavotiteScreen({super.key, required this.favoritesLength});

  @override
  State<MyListFavotiteScreen> createState() => _MyListFavotiteScreenState();
}

class _MyListFavotiteScreenState extends State<MyListFavotiteScreen> {
  final Map<String, bool> _favoriteStatus = {};
  late int favoritesLength;


  @override
  Widget build(BuildContext context) {
    favoritesLength = widget.favoritesLength;
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.07),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          '$favoritesLength rutas.',
                          style: const TextStyle(
                              color: Color(0xFF979797),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: Color(0xFFF0EEEE),
            height: 2,
          ),
          Expanded(
            child: Consumer<UserProvider>(builder: (_, controller, __) {
              if (controller.isLoadingFavorites) {
                return const Center(child: CircularProgressIndicator());
              } else {
                final favorites = controller.favorites;
                return ListView.builder(
                  itemCount: favorites.length,
                  itemBuilder: (_, index) {
                    final favorite = favorites[index];
                    bool isFavorite = _favoriteStatus[favorite.id] ?? false;
                    return CardFavoriteRoute(
                      onTap: () {},
                      onTapLikeButton: () {

                      },
                      isFavorite: isFavorite,
                      routeName: favorite.routeModel.name,
                      routeStartTime: favorite.routeModel.startTime,
                      routeEndTime: favorite.routeModel.endTime,
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}

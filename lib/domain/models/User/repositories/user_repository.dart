import 'package:rabbit_go/domain/models/Favorites/favorite.dart';
import 'package:rabbit_go/domain/models/User/user.dart';
import 'package:rabbit_go/domain/models/User/user_update.dart';

abstract class UserRepository {
  Future<void> createUser(
      String name, String lastname, String email, String password);
  Future<User> userLogin(String email, String password);
  Future<UpdateUser> updateUser(String userId, String name, String lastname,
      String email, String password);
  Future<void> deleteAccount(String id);
  Future<List<FavoriteModel>> getFavoritesById(String id);
  Future<void> removeFavoriteById(String id);
  Future<bool> addFavoriteById(String id);
}

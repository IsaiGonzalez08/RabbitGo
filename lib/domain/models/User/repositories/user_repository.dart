import 'package:rabbit_go/domain/models/User/user.dart';

abstract class UserRepository {
  Future<void> createUser(
      String name, String lastname, String email, String password);
  Future<User> userLogin(String email, String password);
  Future<User> updateUser(String userId, String name, String lastname,
      String email, String password, String token);
  Future<void> deleteAccount(String token, String id);
  Future<void> getFavoritesById(String id);
}

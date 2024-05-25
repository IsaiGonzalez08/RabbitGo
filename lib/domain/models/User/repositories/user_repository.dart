import 'package:rabbit_go/domain/models/User/user.dart';

abstract class UserRepository {
  Future<void> createUser(
      String name, String lastName, String email, String password);
  Future<User> userLogin(String email, String password);
}

import 'package:flutter/material.dart';
import 'package:rabbit_go/domain/models/User/repositories/user_repository.dart';
import 'package:rabbit_go/infraestructure/repositories/User/user_repository_impl.dart';

import '../../domain/models/User/user.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _userRepository = UserRepositoryImpl();
  late User _user =
      User(uuid: '', name: '', lastName: '', email: '', role: '', token: '');
  User get userData => _user;

  Future<void> loginUser(String email, String password) async {
    User userData = await _userRepository.userLogin(email, password);
    _user = userData;
    notifyListeners();
  }

  Future<void> updateUser(String userId, String name, String lastname, String email,
      String password, String token) async {
    User userData = await _userRepository.updateUser(
        userId, name, lastname, email, password, token);
    _user = userData;
    notifyListeners();
  }
}

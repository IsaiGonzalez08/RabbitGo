import 'package:flutter/material.dart';
import 'package:rabbit_go/domain/models/Favorites/favorite.dart';
import 'package:rabbit_go/domain/models/User/credentials.dart';
import 'package:rabbit_go/domain/models/User/repositories/user_repository.dart';
import 'package:rabbit_go/domain/models/User/user_update.dart';
import 'package:rabbit_go/infraestructure/repositories/User/user_repository_impl.dart';

import '../../domain/models/User/user.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _userRepository = UserRepositoryImpl();

  late UpdateUser _userUpdate = UpdateUser(
      id: '',
      name: '',
      lastname: '',
      credentials: Credentials(email: '', password: ''),
      type: '');
  UpdateUser get userDataUpdate => _userUpdate;

  late User _user = User(id: '', name: '', lastname: '', email: '', type: '');
  User get userData => _user;

  List<FavoriteModel> _favorites = [];
  List<FavoriteModel> get favorites => _favorites;

  bool _isLoadingFavorites = false;
  bool get isLoadingFavorites => _isLoadingFavorites;

  bool _response = false;
  bool get response => _response;

  Future<void> createUser(
      String name, String lastname, String email, String password) async {
    await _userRepository.createUser(name, lastname, email, password);
  }

  Future<void> loginUser(String email, String password) async {
    User userData = await _userRepository.userLogin(email, password);
    _user = userData;
    notifyListeners();
  }

  Future<void> updateUser(String userId, String name, String lastname,
      String email, String password) async {
    UpdateUser userDataUpdate = await _userRepository.updateUser(
        userId, name, lastname, email, password);
    _userUpdate = userDataUpdate;
    notifyListeners();
  }

  Future<void> deleteAccount(String id) async {
    await _userRepository.deleteAccount(id);
  }

  Future<void> getFavoritesById() async {
    _isLoadingFavorites = true;
    List<FavoriteModel> favorites = await _userRepository.getFavoritesById();
    _favorites = favorites;
    _isLoadingFavorites = false;
    notifyListeners();
  }

  Future<void> addFavoriteById(String id) async {
    final response = await _userRepository.addFavoriteById(id);
    _response = response;
    notifyListeners();
  }
}

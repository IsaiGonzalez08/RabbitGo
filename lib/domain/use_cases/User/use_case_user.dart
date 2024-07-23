import 'package:rabbit_go/domain/models/Favorites/favorite.dart';
import 'package:rabbit_go/domain/models/User/repositories/user_repository.dart';
import 'package:rabbit_go/domain/models/User/user.dart';
import 'package:rabbit_go/domain/models/User/user_update.dart';

class CreateUserUseCase {
  final UserRepository _userRepository;
  CreateUserUseCase(this._userRepository);
  Future<void> createUser(
      String name, String lastname, String email, String password) async {
    await _userRepository.createUser(name, lastname, email, password);
  }

  Future<User> userLogin(String email, String password) async {
    return await _userRepository.userLogin(email, password);
  }
}

class LoginUserUseCase {
  final UserRepository _userRepository;
  LoginUserUseCase(this._userRepository);

  Future<User> userLogin(String email, String password) async {
    return await _userRepository.userLogin(email, password);
  }
}

class UpdateUserUseCase {
  final UserRepository _userRepository;
  UpdateUserUseCase(this._userRepository);
  Future<UpdateUser> updateUser(String userId, String name, String lastName,
      String email, String password) async {
    return _userRepository.updateUser(userId, name, lastName, email, password);
  }
}

class DeleteAccount {
  final UserRepository _userRepository;
  DeleteAccount(this._userRepository);
  Future<void> deletAccount(String id) async {
    _userRepository.deleteAccount(id);
  }
}

class GetFavoritesById {
  final UserRepository _userRepository;
  GetFavoritesById(this._userRepository);
  Future<List<FavoriteModel>> getFavoritesById(String id) async {
    return _userRepository.getFavoritesById(id);
  }
}

class RemoveFavoritesById {
  final UserRepository _userRepository;
  RemoveFavoritesById(this._userRepository);
  Future<void> removeFavoriteById(String id) async {
    return _userRepository.removeFavoriteById(id);
  }
}

class AddFavoritesById {
  final UserRepository _userRepository;
  AddFavoritesById(this._userRepository);
  Future<bool> addFavoriteById(String id) async {
    return _userRepository.addFavoriteById(id);
  }
}

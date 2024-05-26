import 'package:rabbit_go/domain/models/User/repositories/user_repository.dart';
import 'package:rabbit_go/domain/models/User/user.dart';

class CreateUserUseCase {
  final UserRepository _userRepository;
  CreateUserUseCase(this._userRepository);
  Future<void> createUser(
      String name, String lastName, String email, String password) async {
    await _userRepository.createUser(name, lastName, email, password);
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
  Future<User> updateUser(
      String userId, String name, String lastName, String email, String password, String token) async {
    return _userRepository.updateUser(userId, name, lastName, email, password, token);
  }
}

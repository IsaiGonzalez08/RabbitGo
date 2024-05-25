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

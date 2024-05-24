import 'package:rabbit_go/domain/models/User/repositories/user_repository.dart';

class CreateUserUseCase {
  final UserRepository _userRepository;
  CreateUserUseCase(this._userRepository);
  Future<void> createUser(
      String name, String lastName, String email, String password) async {
    await _userRepository.createUser(name, lastName, email, password);
  }
}

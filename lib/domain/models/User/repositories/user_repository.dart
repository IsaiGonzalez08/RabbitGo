abstract class UserRepository {
  Future<void> createUser(
      String name, String lastName, String email, String password);
}

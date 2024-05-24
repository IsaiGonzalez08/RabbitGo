import 'dart:convert';

import 'package:rabbit_go/domain/models/User/repositories/user_repository.dart';
import 'package:http/http.dart' as http;

class UserRepositoryImpl implements UserRepository {
  @override
  Future<void> createUser(String name, String lastName, String email,
      String password) async {
    try {
      String url = ('https://rabbitgo.sytes.net/user');
      final userData = {
        'name': name,
        'lastname': lastName,
        'email': email,
        'password': password,
      };
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userData),
      );
      if (response.statusCode == 201) {
        print('Usuario creado correctamente');
      } else {
        print('Error al crear el usuario');
      }
    } catch (error) {
      throw ('Error al conectar con el servidor: $error');
    }

    return;
  }
}

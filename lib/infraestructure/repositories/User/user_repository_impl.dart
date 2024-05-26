import 'dart:convert';

import 'package:rabbit_go/domain/models/User/repositories/user_repository.dart';
import 'package:http/http.dart' as http;
import 'package:rabbit_go/domain/models/User/user.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<void> createUser(
      String name, String lastName, String email, String password) async {
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
      if (response.statusCode == 400) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] == 'error') {
          throw Exception('Failed to login: ${jsonResponse['message']}');
        }
      }
    } catch (error) {
      throw ('Error al conectar con el servidor: $error');
    }

    return;
  }

  @override
  Future<User> userLogin(String email, String password) async {
    try {
      String url = 'https://rabbitgo.sytes.net/user/login';
      final userData = {
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
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] == 'success' &&
            jsonResponse['data'] != null) {
          return User.fromJson(jsonResponse['data']);
        } else {
          throw Exception('Failed to login: ${jsonResponse['message']}');
        }
      } else {
        throw Exception(
            'Failed to login with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw ('Error con el servidor, el error es: $e');
    }
  }

  @override
  Future<User> updateUser(String userId, String name, String lastname,
      String email, String password, String token) async {
    try {
      String url = ('https://rabbitgo.sytes.net/user/$userId');

      final userData = {
        'name': name,
        'lastname': lastname,
        'email': email,
        'password': password,
      };

      final response = await http.put(Uri.parse(url),
          headers: {'Authorization': token, 'Content-Type': 'application/json'},
          body: jsonEncode(userData));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] == 'success' &&
            jsonResponse['data'] != null) {
          return User.fromJson(jsonResponse['data']);
        } else {
          throw Exception('Failed to login: ${jsonResponse['message']}');
        }
      } else {
        throw Exception(
            'Failed to login with status code: ${response.statusCode}');
      }
    } catch (error) {
      throw ('Error al conectar con el servidor: $error');
    }
  }
}

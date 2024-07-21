import 'dart:convert';

import 'package:rabbit_go/domain/models/User/repositories/user_repository.dart';
import 'package:http/http.dart' as http;
import 'package:rabbit_go/domain/models/User/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepositoryImpl implements UserRepository {
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  Future<void> createUser(
      String name, String lastname, String email, String password) async {
    try {
      String url = ('https://rabbit-go.sytes.net/user_mcs/user/sign-up');
      final userData = {
        'name': name,
        'lastname': lastname,
        'credencials': {
          'email': email,
          'password': password,
        }
      };
      await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userData),
      );
    } catch (error) {
      throw ('Error al conectar con el servidor: $error');
    }
    return;
  }

  @override
  Future<User> userLogin(String email, String password) async {
    try {
      String url = 'https://rabbit-go.sytes.net/user_mcs/user/sign-in';
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
        if (jsonResponse['status'] == 'Success') {
          final userData = jsonResponse['data'];
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          for (var key in ['token', 'id', 'name', 'lastName', 'email', 'role', 'type']) {
            await prefs.setString(key, userData[key]);
          }
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
    String? token = await getToken();
    try {
      String url = ('https://rabbitgo.sytes.net/user/$userId');
      final userData = {
        'name': name,
        'lastname': lastname,
        'email': email,
        'password': password,
      };
      final response = await http.put(Uri.parse(url),
          headers: {
            'Authorization': token!,
            'Content-Type': 'application/json'
          },
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

  @override
  Future<void> deleteAccount(String token, String id) async {
    String? token = await getToken();
    try {
      String url = 'https://rabbitgo.sytes.net/user/$id';
      await http.delete(Uri.parse(url), headers: {'Authorization': token!});
    } catch (error) {
      throw ('Error al eliminar el usuario, $error');
    }
  }
}

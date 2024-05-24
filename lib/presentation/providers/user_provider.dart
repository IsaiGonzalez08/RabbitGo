import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? uuid;
  String token = '';
  String? name;
  String? lastname;
  String? email;

  void setDataUser(
    String? userUuid,
    String usertoken,
    String? username,
    String? userLastname,
    String? userEmail,
  ) {
    uuid = userUuid;
    token = usertoken;
    name = username;
    lastname = userLastname;
    email = userEmail;
    notifyListeners();
  }
}

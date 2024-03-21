import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  String? userId;
  String? token;

  void setUserId(String? id, String? userToken) {
    userId = id;
    token = userToken;
    notifyListeners();
  }
}

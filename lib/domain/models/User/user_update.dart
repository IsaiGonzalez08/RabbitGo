import 'package:rabbit_go/domain/models/User/credentials.dart';

class UpdateUser {
  final String id;
  final String name;
  final String lastname;
  final Credentials credentials;
  final String type;

  UpdateUser({
    required this.id,
    required this.name,
    required this.lastname,
    required this.credentials,
    required this.type,
  });

  factory UpdateUser.fromJson(Map<String, dynamic> json) {
    return UpdateUser(
      id: json['id'],
      name: json['name'],
      lastname: json['lastname'],
      credentials: Credentials.fromJson(json['credentials']),
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastname': lastname,
      'credentials': credentials.toJson(),
      'type': type,
    };
  }
}
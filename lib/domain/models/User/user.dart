class User {
  final String uuid;
  final String name;
  final String lastname;
  final String email;
  final String role;
  final String token;
  final String type;

  User(
      {required this.uuid,
      required this.name,
      required this.lastname,
      required this.email,
      this.role = '',
      this.token = '',
      required this.type});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uuid: json['uuid'],
      name: json['name'],
      lastname: json['lastname'],
      email: json['email'],
      role: json['rol'] ?? '',
      token: json['token'] ?? '',
      type: json['type']
    );
  }
}

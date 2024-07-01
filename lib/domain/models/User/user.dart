class User {
  final String uuid;
  final String name;
  final String lastName;
  final String email;
  final String role;
  final String token;

  User({
    required this.uuid,
    required this.name,
    required this.lastName,
    required this.email,
    this.role = '',
    this.token = ''
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uuid: json['uuid'],
      name: json['name'],
      lastName: json['lastname'],
      email: json['email'],
      role: json['rol'] ?? '',
      token: json['token'] ?? '',
    );
  }
}

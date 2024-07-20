class User {
  final String token;
  final String id;
  final String name;
  final String lastname;
  final String email;
  final String role;
  final String type;

  User(
      {
      this.token = '',
      required this.id,
      required this.name,
      required this.lastname,
      required this.email,
      this.role = '',
      required this.type});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      token: json['token'] ?? '',
      id: json['id'],
      name: json['name'],
      lastname: json['lastName'],
      email: json['email'],
      role: json['role'] ?? '',
      type: json['type']
    );
  }
}

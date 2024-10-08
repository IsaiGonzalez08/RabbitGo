class User {
  final String id;
  final String token;
  final String name;
  final String lastname;
  final String email;
  final String role;
  final String type;

  User(
      {
      required this.id,
      this.token = '',
      required this.name,
      required this.lastname,
      required this.email,
      this.role = '',
      required this.type});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        token: json['token'] ?? '',
        name: json['name'],
        lastname: json['lastName'],
        email: json['email'],
        role: json['role'] ?? '',
        type: json['type']);
  }
}

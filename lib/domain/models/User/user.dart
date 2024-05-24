class User {
  final String name, lastName, email, password;
  User(
      {required this.name,
      required this.lastName,
      required this.email,
      required this.password});
  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
        name: json['name'],
        lastName: json['lastName'],
        email: json['email'],
        password: json['password']);
  }
}

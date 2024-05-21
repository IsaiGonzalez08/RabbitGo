class Stop {
  final String name;

  Stop({
    required this.name,
  });

  factory Stop.fromJson(Map<dynamic, dynamic> json) {
    return Stop(
      name: json['name'],
    );
  }
}

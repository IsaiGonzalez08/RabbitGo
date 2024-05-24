class Stop {
  final String id;

  Stop({
    required this.id,
  });

  factory Stop.fromJson(Map<dynamic, dynamic> json) {
    return Stop(
      id: json['uuid'],
    );
  }
}

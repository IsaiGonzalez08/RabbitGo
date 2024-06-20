class Stop {
  final String id, name;
  final double latitude;
  final double longitude;

  Stop({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory Stop.fromJson(Map<dynamic, dynamic> json) {
    return Stop(
      id: json['uuid'],
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude']
    );
  }
}

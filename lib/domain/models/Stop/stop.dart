class Stop {
  final String id;
  final double latitude;
  final double longitude;

  Stop({
    required this.id,
    required this.latitude,
    required this.longitude,
  });

  factory Stop.fromJson(Map<dynamic, dynamic> json) {
    return Stop(
      id: json['uuid'],
      latitude: json['latitude'],
      longitude: json['longitude']
    );
  }
}

class Stop {
  final String name, id;
  final double latitude;
  final double longitude;

  Stop(
      {
      required this.id,
      required this.name,
      required this.latitude,
      required this.longitude,
      });

  factory Stop.fromJson(Map<String, dynamic> json) {
    return Stop(
        id: json['data']['uuid'],
        name: json['data']['name'],
        latitude: json['data']['latitude'],
        longitude: json['data']['longitud']);
  }
}

class Stop {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  bool? deletedAt;

  Stop({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.deletedAt,
  });

  factory Stop.fromJson(Map<String, dynamic> json) {
    return Stop(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      deletedAt: json['deletedAt'] as bool?,
    );
  }
}
class LocationModel {
  final String description;
  final double length;

  LocationModel({
    required this.description,
    required this.length,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      description: json['description'],
      length: json['length'],
    );
  }
}

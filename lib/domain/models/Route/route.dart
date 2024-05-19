class RouteModel {
  final String uuid, name, startTime, endTime;
  final int price;

  RouteModel({
    required this.uuid,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.price,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      uuid: json['uuid'],
      name: json['name'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      price: json['price'],
    );
  }
}

class Route {
  final String uuid, name, startTime, endTime;
  final int price;

  Route(
      {required this.uuid,
      required this.name,
      required this.startTime,
      required this.endTime,
      required this.price});

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
        uuid: json['uuid'],
        name: json['name'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        price: json['price']);
  }
}

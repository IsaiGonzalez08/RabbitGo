class Routes {
  final String uuid, name, startTime, endTime;
  final int price;

  Routes(
      {required this.uuid,
      required this.name,
      required this.startTime,
      required this.endTime,
      required this.price});

  factory Routes.fromJson(Map<String, dynamic> json) {
    return Routes(
        uuid: json['uuid'],
        name: json['name'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        price: json['price']);
  }
}

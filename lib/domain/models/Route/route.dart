class RouteModel {
  final String uuid, name, startTime, endTime, busStopId;
  final int price;

  RouteModel(
      {required this.uuid,
      required this.name,
      required this.startTime,
      required this.endTime,
      required this.price,
      required this.busStopId});

  Map<String, dynamic> toJson() => {
    'uuid': uuid,
    'name': name,
    'startTime': startTime,
    'endTime': endTime,
    'busStopId': busStopId
  };

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
        uuid: json['uuid'],
        name: json['name'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        price: json['price'],
        busStopId: json['busStopId']);
  }
}

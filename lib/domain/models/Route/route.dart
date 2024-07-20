class RouteModel {
  final String id, name, startTime, endTime;
  final int price;
  final List<dynamic> colonies;

  RouteModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.startTime,
      required this.endTime,
      required this.colonies,});

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'startTime': startTime,
    'endTime': endTime,
    'colonies': colonies,
  };

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        colonies: json['colonies'],);
  }
}

import 'package:rabbit_go/domain/models/Route/route.dart';

class FavoriteModel {
  final String id, userId, shuttleId;
  final RouteModel routeModel;

  FavoriteModel({
    required this.id,
    required this.userId,
    required this.shuttleId,
    required this.routeModel
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'shuttleId': shuttleId,
        'routeDetails': routeModel.toJson(),
      };

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'],
      userId: json['userId'],
      shuttleId: json['shuttleId'],
      routeModel: RouteModel.fromJson(json['routeDetails']),
    );
  }
}

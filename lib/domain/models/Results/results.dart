import 'package:rabbit_go/domain/models/Flow/flow.dart';
import 'package:rabbit_go/domain/models/Location/location.dart';

class ResultsModel {
  final LocationModel locationModel;
  final FlowModel flowModel;

  ResultsModel({
    required this.locationModel,
    required this.flowModel,
  });

  factory ResultsModel.fromJson(Map<String, dynamic> json) {
    return ResultsModel(
      locationModel: LocationModel.fromJson(json['location']),
      flowModel: FlowModel.fromJson(json['currentFlow']),
    );
  }
}

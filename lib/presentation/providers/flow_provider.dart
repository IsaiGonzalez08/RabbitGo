import 'package:flutter/material.dart';
import 'package:rabbit_go/domain/models/Flow/flow.dart';
import 'package:rabbit_go/domain/models/Flow/repository/flow_repository.dart';
import 'package:rabbit_go/infraestructure/repositories/Flow/flow_repository_impl.dart';

class FlowProvider extends ChangeNotifier {
  final FlowRepository _flowRepository = FlowRepositoryImpl();

  List<FlowModel> _flows = [];
  List<FlowModel> get flows => _flows;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> getTrafficFlow(String coordinatesEncoded) async {
    _loading = true;
    notifyListeners();
    List<FlowModel> flows = await _flowRepository.getTrafficFlow(coordinatesEncoded);
    _flows = flows;
    _loading = false;
    notifyListeners();
  }
}

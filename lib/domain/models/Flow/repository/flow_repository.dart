import 'package:rabbit_go/domain/models/Flow/flow.dart';

abstract class FlowRepository {
  Future<List<FlowModel>> getTrafficFlow(String coordinatesEncoded);
}
import 'package:rabbit_go/domain/models/Flow/flow.dart';
import 'package:rabbit_go/domain/models/Flow/repository/flow_repository.dart';

class GetTrafficFlowUseCase {
  final FlowRepository _flowRepository;
  GetTrafficFlowUseCase(this._flowRepository);

  Future<List<FlowModel>> getTrafficFlow(String coordinatesEncoded) async {
     return await _flowRepository.getTrafficFlow(coordinatesEncoded);
  } 
  
}

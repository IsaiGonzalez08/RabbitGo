import 'package:rabbit_go/domain/models/Results/repository/results_repository.dart';
import 'package:rabbit_go/domain/models/Results/results.dart';

class GetTrafficResultsUseCase {
  final ResultsRepository _resultsRepository;
  GetTrafficResultsUseCase(this._resultsRepository);

  Future<List<ResultsModel>> getTrafficResults(String coordinatesEncoded) async {
     return await _resultsRepository.getTrafficResults(coordinatesEncoded);
  } 
  
}

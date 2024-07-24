
import 'package:rabbit_go/domain/models/Results/results.dart';

abstract class ResultsRepository {
  Future<List<ResultsModel>> getTrafficResults(String coordinatesEncoded);
}
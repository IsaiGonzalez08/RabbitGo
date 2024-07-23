import 'package:flutter/material.dart';
import 'package:rabbit_go/domain/models/Results/repository/results_repository.dart';
import 'package:rabbit_go/domain/models/Results/results.dart';
import 'package:rabbit_go/infraestructure/repositories/Results/results_repository_impl.dart';

class ResultsProvider extends ChangeNotifier {
  final ResultsRepository _resultsRepository = ResultsRepositoryImpl();

  List<ResultsModel> _results = [];
  List<ResultsModel> get results => _results;

  bool _loading = false;
  bool get loading => _loading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> getTrafficResults(String coordinatesEncoded) async {
    _loading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      List<ResultsModel> results = await _resultsRepository.getTrafficResults(coordinatesEncoded);
      _results = results;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}

import 'dart:async';
import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:rabbit_go/domain/models/Report/report.dart';
import 'package:rabbit_go/domain/models/Report/repository/report_repository.dart';
import 'package:rabbit_go/infraestructure/repositories/Report/report_repository_impl.dart';

class ReportProvider extends ChangeNotifier {
  final ReportRepository _reportRepository = ReportRepositoryImpl();

  ReportModel _report = ReportModel(classifications: [], score: 0.0, stars: 0);
  ReportModel get report => _report;

  bool _status = false;
  bool get status => _status;

  Future<void> analizeTextReport(String text) async {
    final report = await _reportRepository.analizeTextReport(text);
    _report = report;
    notifyListeners();
  }

  Future<bool> createComplaint(String userId, String complaint, double score,
      int stars, List categories) async {
    final status = await _reportRepository.createComplaint(
        userId, complaint, score, stars, categories);
    _status = status;
    notifyListeners();
    return _status;
  }
}

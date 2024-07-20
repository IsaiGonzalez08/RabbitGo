import 'package:rabbit_go/domain/models/Report/report.dart';
import 'package:rabbit_go/domain/models/Report/repository/report_repository.dart';

class AnalizeTextReportUseCase {
  final ReportRepository _reportRepository;
  AnalizeTextReportUseCase(this._reportRepository);

  Future<ReportModel> analizeTextReport(String text) async {
    return await _reportRepository.analizeTextReport(text);
  }
}

class CreateComplaintUseCase {
  final ReportRepository _reportRepository;
  CreateComplaintUseCase(this._reportRepository);

  Future<bool> createComplaint(String userId, String complaint, double score,
      int stars, List<dynamic> categories) async {
    return await _reportRepository.createComplaint(
        userId, complaint, score, stars, categories);
  }
}

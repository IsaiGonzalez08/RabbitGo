import 'package:rabbit_go/domain/models/Report/report.dart';

abstract class ReportRepository {
  Future<ReportModel> analizeTextReport(String text);
  Future<bool> createComplaint(String userId, String complaint, double score,
      int stars, List<dynamic> categories);
}

import 'package:rabbit_go/domain/models/Path/path.dart';

abstract class PathRepository {
  Future<List<PathModel>> getRoutePaths(String token, String busStopId);
}

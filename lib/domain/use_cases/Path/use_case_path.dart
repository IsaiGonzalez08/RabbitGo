import 'package:rabbit_go/domain/models/Path/path.dart';
import 'package:rabbit_go/domain/models/Path/repository/path_repository.dart';

class GetRoutePathsUseCase {
  final PathRepository _pathRepository;
  GetRoutePathsUseCase(this._pathRepository);

  Future<List<PathModel>> getRoutePaths(String token, String busStopId) async {
    return await _pathRepository.getRoutePaths(token, busStopId);
  }
}

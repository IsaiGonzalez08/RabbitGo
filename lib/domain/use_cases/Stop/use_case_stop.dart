import 'package:rabbit_go/domain/models/Stop/repositories/stop_repository.dart';
import 'package:rabbit_go/domain/models/Stop/stop.dart';

class GetAllBusStopsUseCase {
  final StopRepository _stopRepository;
  GetAllBusStopsUseCase(this._stopRepository);

  Future<List<Stop>> execute(String token) async {
   return await _stopRepository.getAllBusStops(token);
  }
}
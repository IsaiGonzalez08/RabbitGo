import 'dart:async';

import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:rabbit_go/domain/models/Path/path.dart';

import 'package:rabbit_go/domain/models/Path/repository/path_repository.dart';
import 'package:rabbit_go/infraestructure/repositories/Path/path_repository_impl.dart';

class PathProvider extends ChangeNotifier {
  final PathRepository _pathRepository = PathRepositoryImpl();

  List<PathModel> _paths = [];
  List<PathModel> get paths => _paths;

  Future<void> getRoutePaths(String busStopId) async {
    List<PathModel> paths = await _pathRepository.getRoutePaths(busStopId);
    _paths = paths;
    notifyListeners();
  }
}

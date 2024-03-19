import 'package:flutter/widgets.dart';
import 'package:rabbit_go/main.dart';
import 'package:rabbit_go/presentation/widgets/tapbar_widget.dart';
import 'package:rabbit_go/routes/routes.dart';


Map<String, Widget Function(BuildContext)> appRoutes() {
  return {
    Routes.SPLASH: (_) => const SplashScreen(),
    Routes.TAPBAR: (_) => const MyTapBarWidget()
  };
}
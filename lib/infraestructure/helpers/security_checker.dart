import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class SecurityChecker {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> isDeviceSecure() async {
    try {
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      bool isDeviceSupported = await auth.isDeviceSupported();

      if (canCheckBiometrics || isDeviceSupported) {
        bool isAuthenticated = await auth.authenticate(
          localizedReason: 'Please authenticate to access the app',
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
          ),
        );
        return isAuthenticated;
      } else {
        return false;
      }
    } on PlatformException catch (e) {
      print("Failed to check device security: '${e.message}'.");
      return false;
    }
  }
}

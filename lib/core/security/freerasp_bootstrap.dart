// lib/core/security/freerasp_bootstrap.dart
import 'package:flutter/widgets.dart';
import 'package:freerasp/freerasp.dart';

class FreeRaspBootstrap {
  static Future<void> start({
    required String watcherMail,
    required String androidPackageName,
    required List<String> androidSigningCertHashesBase64, // release hashes
    required List<String> androidSupportedStores,
    required List<String> iosBundleIds,
    required String iosTeamId,
    required ThreatCallback callback,
    bool isProd = true,
  }) async {
    WidgetsFlutterBinding.ensureInitialized(); // required

    final config = TalsecConfig(
      androidConfig: AndroidConfig(
        packageName: androidPackageName,
        signingCertHashes: androidSigningCertHashesBase64,
        supportedStores: androidSupportedStores,
      ),
      iosConfig: IOSConfig(bundleIds: iosBundleIds, teamId: iosTeamId),
      watcherMail: watcherMail,
      isProd: isProd, // set false for debug builds
    );

    // Attach callbacks & start
    Talsec.instance.attachListener(callback);
    await Talsec.instance.start(config);
  }
}

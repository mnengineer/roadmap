import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/core/config/firebase_options.dart';
import 'package:roadmap/presentation/routes/app.dart';

Future<void> main() async {
  const app = App();
  const scope = ProviderScope(child: app);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: currentPlatform);

  // Set screen orientation to portrait mode
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Use DevicePreview for web previews
  Widget window = scope;
  if (kIsWeb) {
    window = DevicePreview(builder: (context) => scope);
  }
  runApp(window);
}

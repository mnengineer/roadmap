import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/application/config/flavor.dart';
import 'package:roadmap/application/interfaces/firebase.dart';
import 'package:roadmap/application/interfaces/logger.dart';
import 'package:roadmap/application/types/flavor.dart';
// DI は特別に外レイヤーをimportする
import 'package:roadmap/infrastructure/firebase/fake_firebase.dart';
import 'package:roadmap/infrastructure/firebase/firebase.dart';
import 'package:roadmap/infrastructure/log/fake_logger.dart';
import 'package:roadmap/infrastructure/log/logger.dart';

/// Firebase
final firebaseProvider = Provider<FirebaseService>(
  (ref) {
    switch (flavor) {
      case Flavor.dev:
        return FakeFirebaseService();
      case Flavor.stg:
        return FakeFirebaseService();
      case Flavor.prd:
        return DefaultFirebaseService();
    }
  },
);

/// Logger
final loggerProvider = Provider<Logger>(
  (ref) {
    switch (flavor) {
      case Flavor.dev:
        return FakeLogger();
      case Flavor.stg:
        return FakeLogger();
      case Flavor.prd:
        return DefaultLogger();
    }
  },
);

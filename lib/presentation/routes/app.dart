import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:roadmap/core/utils/theme/theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationService = ref.watch(navigationServiceProvider);

    return MaterialApp.router(
      builder: DevicePreview.appBuilder,
      routerDelegate: navigationService.router.routerDelegate,
      routeInformationParser: navigationService.router.routeInformationParser,
      routeInformationProvider:
          navigationService.router.routeInformationProvider,
      theme: TAppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:salesysx/core/theme/app_theme.dart';
import 'package:salesysx/routes/app_router.dart';

import 'core/locale/locale_controller.dart';
import 'core/network/firebase_client.dart';
import 'core/push/push_notification_service.dart';
import 'core/push/push_open_listener.dart';
import 'core/network/connectivity_banner.dart';
import 'core/observers/riverpod_logging_observer.dart';
import 'core/storage/local_cache_service.dart';
import 'core/storage/secure_storage_service.dart';
import 'core/theme/theme_controller.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'routes/app_initialization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Local development against the Firebase emulators:
  //   flutter run --dart-define=USE_EMULATORS=true --dart-define=EMULATOR_HOST=10.0.2.2
  if (const bool.fromEnvironment('USE_EMULATORS')) {
    const host = String.fromEnvironment('EMULATOR_HOST', defaultValue: 'localhost');
    FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
    await FirebaseAuth.instance.useAuthEmulator(host, 9099);
  }

  AppInitialization.init();

  final secureStorage = SecureStorageService();

  final localCache = LocalCacheService(
    secureStorage,
  );

  await localCache.init();

  final firebaseClient = FirebaseClient();
  final pushService = PushNotificationService(firebaseClient);
  try {
    await pushService.init();
  } catch (e) {
    debugPrint('Push notifications unavailable: $e');
  }

  runApp(
    ProviderScope(
      overrides: [
        secureStorageServiceProvider.overrideWithValue(
          secureStorage,
        ),
        localCacheServiceProvider.overrideWithValue(
          localCache,
        ),
        firebaseClientProvider.overrideWithValue(firebaseClient),
        pushNotificationServiceProvider.overrideWithValue(pushService),
      ],
      observers: [
        RiverpodLoggingObserver(),
      ],
      child: const PosApp(),
    ),
  );
}

class PosApp extends ConsumerWidget {
  const PosApp({super.key});

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final router = ref.watch(routerProvider);

    final themeMode = ref.watch(
      themeControllerProvider,
    );

    final locale = ref.watch(localeControllerProvider);

    return MaterialApp.router(
      title: 'SalesysX',

      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,

      darkTheme: AppTheme.darkTheme,

      themeMode: themeMode,

      locale: locale,
      supportedLocales: supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      routerConfig: router,

      builder: (context, child) {
        return PushOpenListener(
          child: Stack(
            children: [
              child ?? const SizedBox.shrink(),
              const ConnectivityBanner(),
            ],
          ),
        );
      },
    );
  }
}
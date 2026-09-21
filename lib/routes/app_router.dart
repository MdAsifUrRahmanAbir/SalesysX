import 'package:salesysx/features/team_overview/presentation/screens/team_overview_screen.dart';
import 'package:salesysx/features/profile/presentation/screens/profile_screen.dart';
import 'package:salesysx/features/target_performance/presentation/screens/target_performance_screen.dart';
import 'package:salesysx/features/new_sale_entry/presentation/screens/new_sale_entry_screen.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:salesysx/features/terms_privacy/presentation/screens/terms_privacy_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:salesysx/routes/route_names.dart';
import 'package:salesysx/features/main_shell/presentation/screens/main_shell_screen.dart';
import 'package:salesysx/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:salesysx/features/system/presentation/screens/not_found_screen.dart';
import 'package:salesysx/features/system/presentation/screens/error_screen.dart';
import 'package:salesysx/features/system/presentation/screens/no_internet_screen.dart';
import 'package:salesysx/features/system/presentation/screens/maintenance_screen.dart';
import 'package:salesysx/features/help_support/presentation/screens/help_support_screen.dart';

import '../core/network/connectivity_provider.dart';
import '../core/observers/logging_observer.dart';
import '../features/outlets_customers/presentation/screens/outlets_customers_screen.dart';
import '../features/salesman_home/presentation/screens/salesman_home_screen.dart';

final hasCompletedInitialNavigationProvider = StateProvider<bool>(
  (ref) => false,
);

final routerProvider = Provider<GoRouter>((ref) {
  final connectivityService = ref.watch(connectivityServiceProvider);

  return GoRouter(
    initialLocation: RouteNames.mainShell,
    errorBuilder: (context, state) => const NotFoundScreen(),
    observers: [LoggingObserver()],
    refreshListenable: GoRouterRefreshStream(
      connectivityService.onStatusChange,
    ),

    redirect: (context, state) {
      if (state.matchedLocation == RouteNames.splash) return null;

      if (!ref.read(hasCompletedInitialNavigationProvider)) {
        ref.read(hasCompletedInitialNavigationProvider.notifier).state = true;
        return null;
      }

      final isConnected = ref.read(connectivityServiceProvider).isConnected;
      final offlineModeEnabled = ref.read(offlineModeProvider);
      final onNoInternetRoute = state.matchedLocation == RouteNames.noInternet;

      if (!isConnected && !offlineModeEnabled) {
        return onNoInternetRoute ? null : RouteNames.noInternet;
      }

      if (isConnected && offlineModeEnabled) {
        ref.read(offlineModeProvider.notifier).disable();
      }

      return null;
    },

    routes: [
      GoRoute(
        path: RouteNames.mainShell,
        builder: (_, _) => const MainShellScreen(),
      ),
      GoRoute(
        path: RouteNames.notifications,
        builder: (_, _) => const NotificationsScreen(),
      ),
      GoRoute(
        path: RouteNames.notFound,
        builder: (_, _) => const NotFoundScreen(),
      ),
      GoRoute(path: RouteNames.error, builder: (_, _) => const ErrorScreen()),
      GoRoute(
        path: RouteNames.noInternet,
        builder: (_, _) => const NoInternetScreen(),
      ),
      GoRoute(
        path: RouteNames.maintenance,
        builder: (_, _) => const MaintenanceScreen(),
      ),
      GoRoute(
        path: RouteNames.helpSupport,
        builder: (_, _) => const HelpSupportScreen(),
      ),
      GoRoute(
        path: RouteNames.termsPrivacy,
        builder: (context, state) => const TermsPrivacyScreen(),
      ),
      GoRoute(
        path: RouteNames.salesman_home,
        builder: (context, state) => const SalesmanHomeScreen(),
      ),
      GoRoute(
        path: RouteNames.new_sale_entry,
        builder: (context, state) => const NewSaleEntryScreen(),
      ),
      GoRoute(path: RouteNames.outlets_customers, builder: (context, state) => const OutletsCustomersScreen()),
    GoRoute(path: RouteNames.target_performance, builder: (context, state) => const TargetPerformanceScreen()),
    GoRoute(path: RouteNames.profile, builder: (context, state) => const ProfileScreen()),
    GoRoute(path: RouteNames.team_overview, builder: (context, state) => const TeamOverviewScreen()),
  ],
  );
});

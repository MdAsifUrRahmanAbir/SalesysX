import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'package:salesysx/features/change_password/presentation/screens/change_password_screen.dart';
import 'package:salesysx/features/edit_profile/presentation/screens/edit_profile_screen.dart';
import 'package:salesysx/features/help_support/presentation/screens/help_support_screen.dart';
import 'package:salesysx/features/login/presentation/screens/login_screen.dart';
import 'package:salesysx/features/main_shell/presentation/screens/main_shell_screen.dart';
import 'package:salesysx/features/new_sale_entry/presentation/screens/new_sale_entry_screen.dart';
import 'package:salesysx/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:salesysx/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:salesysx/features/onboarding/presentation/screens/splash_screen.dart';
import 'package:salesysx/features/onboarding/presentation/screens/welcome_screen.dart';
import 'package:salesysx/features/outlets_customers/presentation/screens/outlets_customers_screen.dart';
import 'package:salesysx/features/profile/presentation/screens/profile_screen.dart';
import 'package:salesysx/features/salesman_home/presentation/screens/salesman_home_screen.dart';
import 'package:salesysx/features/settings/presentation/screens/settings_screen.dart';
import 'package:salesysx/features/system/presentation/screens/error_screen.dart';
import 'package:salesysx/features/system/presentation/screens/maintenance_screen.dart';
import 'package:salesysx/features/system/presentation/screens/no_internet_screen.dart';
import 'package:salesysx/features/system/presentation/screens/not_found_screen.dart';
import 'package:salesysx/features/target_performance/presentation/screens/target_performance_screen.dart';
import 'package:salesysx/features/team_member/presentation/screens/team_member_screen.dart';
import 'package:salesysx/features/team_overview/presentation/screens/team_overview_screen.dart';
import 'package:salesysx/features/terms_privacy/presentation/screens/terms_privacy_screen.dart';

import 'package:salesysx/routes/route_names.dart';

import '../core/network/connectivity_provider.dart';
import '../core/observers/logging_observer.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final connectivityService = ref.watch(connectivityServiceProvider);

  return GoRouter(
    initialLocation: RouteNames.splash,

    errorBuilder: (context, state) {
      return const NotFoundScreen();
    },

    observers: [
      LoggingObserver(),
    ],

    refreshListenable: GoRouterRefreshStream(
      connectivityService.onStatusChange,
    ),

    redirect: (context, state) {
      final location = state.matchedLocation;

      // Splash route doesn't need connectivity redirect.
      if (location == RouteNames.splash) {
        return null;
      }

      final isConnected =
          ref.read(connectivityServiceProvider).isConnected;

      final offlineModeEnabled = ref.read(offlineModeProvider);

      final onNoInternetRoute =
          location == RouteNames.noInternet;

      // No internet + offline mode disabled
      if (!isConnected && !offlineModeEnabled) {
        if (onNoInternetRoute) {
          return null;
        }

        return RouteNames.noInternet;
      }

      // IMPORTANT:
      // Do NOT modify any Riverpod provider here.
      //
      // Previously:
      // ref.read(offlineModeProvider.notifier).disable();
      //
      // That causes:
      // "Tried to modify a provider while the widget tree was building."

      return null;
    },

    routes: [
      // ------------------------------------------------------------
      // ONBOARDING / AUTH
      // ------------------------------------------------------------

      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) {
          return const SplashScreen();
        },
      ),

      GoRoute(
        path: RouteNames.onboarding,
        builder: (context, state) {
          return const OnboardingScreen();
        },
      ),

      GoRoute(
        path: RouteNames.welcome,
        builder: (context, state) {
          return const WelcomeScreen();
        },
      ),

      GoRoute(
        path: RouteNames.login,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),

      // ------------------------------------------------------------
      // MAIN
      // ------------------------------------------------------------

      GoRoute(
        path: RouteNames.mainShell,
        builder: (context, state) {
          return const MainShellScreen();
        },
      ),

      GoRoute(
        path: RouteNames.salesman_home,
        builder: (context, state) {
          return const SalesmanHomeScreen();
        },
      ),

      GoRoute(
        path: RouteNames.new_sale_entry,
        builder: (context, state) {
          return const NewSaleEntryScreen();
        },
      ),

      // ------------------------------------------------------------
      // CUSTOMER / OUTLET
      // ------------------------------------------------------------

      GoRoute(
        path: RouteNames.outlets_customers,
        builder: (context, state) {
          return const OutletsCustomersScreen();
        },
      ),

      // ------------------------------------------------------------
      // TARGET / TEAM
      // ------------------------------------------------------------

      GoRoute(
        path: RouteNames.target_performance,
        builder: (context, state) {
          return const TargetPerformanceScreen();
        },
      ),

      GoRoute(
        path: RouteNames.team_overview,
        builder: (context, state) {
          return const TeamOverviewScreen();
        },
      ),

      GoRoute(
        path: RouteNames.team_member,
        builder: (context, state) {
          return const TeamMemberScreen();
        },
      ),

      // ------------------------------------------------------------
      // PROFILE
      // ------------------------------------------------------------

      GoRoute(
        path: RouteNames.profile,
        builder: (context, state) {
          return const ProfileScreen();
        },
      ),

      GoRoute(
        path: RouteNames.editProfile,
        builder: (context, state) {
          return const EditProfileScreen();
        },
      ),

      GoRoute(
        path: RouteNames.changePassword,
        builder: (context, state) {
          return const ChangePasswordScreen();
        },
      ),

      // ------------------------------------------------------------
      // SETTINGS
      // ------------------------------------------------------------

      GoRoute(
        path: RouteNames.settings,
        builder: (context, state) {
          return const SettingsScreen();
        },
      ),

      // ------------------------------------------------------------
      // NOTIFICATIONS
      // ------------------------------------------------------------

      GoRoute(
        path: RouteNames.notifications,
        builder: (context, state) {
          return const NotificationsScreen();
        },
      ),

      // ------------------------------------------------------------
      // SYSTEM
      // ------------------------------------------------------------

      GoRoute(
        path: RouteNames.noInternet,
        builder: (context, state) {
          return const NoInternetScreen();
        },
      ),

      GoRoute(
        path: RouteNames.maintenance,
        builder: (context, state) {
          return const MaintenanceScreen();
        },
      ),

      GoRoute(
        path: RouteNames.error,
        builder: (context, state) {
          return const ErrorScreen();
        },
      ),

      GoRoute(
        path: RouteNames.notFound,
        builder: (context, state) {
          return const NotFoundScreen();
        },
      ),

      // ------------------------------------------------------------
      // HELP / LEGAL
      // ------------------------------------------------------------

      GoRoute(
        path: RouteNames.helpSupport,
        builder: (context, state) {
          return const HelpSupportScreen();
        },
      ),

      GoRoute(
        path: RouteNames.termsPrivacy,
        builder: (context, state) {
          return const TermsPrivacyScreen();
        },
      ),
    ],
  );
});
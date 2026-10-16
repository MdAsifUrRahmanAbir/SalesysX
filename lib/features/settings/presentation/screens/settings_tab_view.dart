import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/locale/locale_controller.dart';
import '../../../../core/session/auth_session_controller.dart';
import '../../../../core/widgets/common/app_header_bar.dart';
import '../../../../core/widgets/common/radio_option.dart';
import '../../../../core/widgets/utility/custom_alert_dialog.dart';
import '../../../../core/widgets/utility/custom_bottom_sheet.dart';
import '../../../../core/widgets/utility/custom_snackbar.dart';
import '../../../../routes/route_names.dart';
import '../controllers/settings_controller.dart';
import '../widgets/settings_toggles_section.dart';
import '../widgets/settings_security_general_section.dart';
import '../widgets/settings_developer_section.dart';
import '../widgets/settings_legal_section.dart';
import '../widgets/settings_footer_actions.dart';
import 'package:salesysx/core/locale/app_localizations_x.dart';

/// Same content as [SettingsMobileView], centered in a fixed-width
/// column for wider (tablet/web) viewports.
class SettingsTabView extends ConsumerWidget {
  const SettingsTabView({super.key});

  Future<void> _openLanguagePicker(BuildContext context, WidgetRef ref) {
    final localeController = ref.read(localeControllerProvider.notifier);
    final current = ref.read(localeControllerProvider);

    return CustomBottomSheet.show<void>(
      context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.language,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppSizes.sm),
          for (final locale in supportedLocales)
            RadioOption<Locale>(
              value: locale,
              groupValue: current,
              title: localeDisplayName(locale),
              onChanged: (v) {
                localeController.setLocale(v!);
                Navigator.of(context).pop();
              },
            ),
        ],
      ),
    );
  }

  Future<void> _confirmDeleteAccount(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final confirmed = await CustomAlertDialog.confirm(
      context,
      title: context.l10n.deleteAccount,
      message: 'This action is permanent and cannot be undone. Are you sure?',
      confirmText: context.l10n.deleteAccount,
      destructive: true,
    );

    if (confirmed == true) {
      await ref.read(settingsControllerProvider.notifier).deleteAccount();
    }
  }

  Future<void> _confirmResetDemoData(BuildContext context, WidgetRef ref) async {
    final confirmed = await CustomAlertDialog.confirm(
      context,
      title: context.l10n.resetDemoDataTitle,
      message: context.l10n.resetDemoDataConfirmMessage,
      confirmText: context.l10n.resetDemoDataTitle,
      destructive: true,
    );
    if (confirmed != true) return;

    final success = await ref.read(settingsControllerProvider.notifier).resetDemoData();
    if (!context.mounted) return;

    if (success) {
      await ref.read(authSessionControllerProvider.notifier).logout();
      if (!context.mounted) return;
      CustomSnackBar.show(context, context.l10n.resetDemoDataSuccess);
      context.go(RouteNames.login);
    } else {
      CustomSnackBar.show(context, 'Failed to reset demo data.', error: true);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(settingsControllerProvider.notifier);

    final state = ref.watch(settingsControllerProvider);
    final locale = ref.watch(localeControllerProvider);

    return Column(
      children: [
        AppHeaderBar(
          backStyle: HeaderBackStyle.chevron,
          title: context.l10n.settingsTitle,
        ),

        Expanded(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSizes.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SettingsTogglesSection(
                      darkMode: state.darkMode,
                      onDarkModeChanged: controller.setDarkMode,

                      onAppThemeTap: () {
                        // TODO: open app-theme picker
                      },

                      pushNotifications: state.pushNotifications,
                      onPushNotificationsChanged:
                          controller.setPushNotifications,

                      emailNotifications: state.emailNotifications,
                      onEmailNotificationsChanged:
                          controller.setEmailNotifications,

                      smsAlerts: state.smsAlerts,
                      onSmsAlertsChanged: controller.setSmsAlerts,
                    ),

                    const SizedBox(height: AppSizes.xl),

                    SettingsSecurityGeneralSection(
                      biometricAuth: state.biometricAuth,
                      onBiometricAuthChanged: controller.setBiometricAuth,

                      onTwoFactorAuthTap: () {
                        // TODO: navigate to 2FA setup
                      },

                      onActiveSessionsTap: () {
                        // TODO: navigate to active sessions
                      },

                      languageValue: localeDisplayName(locale),
                      onLanguageTap: () => _openLanguagePicker(context, ref),

                      onRegionTap: () {
                        // TODO: open region picker
                      },
                    ),

                    const SizedBox(height: AppSizes.xl),

                    SettingsDeveloperSection(
                      onResetDemoDataTap: () => _confirmResetDemoData(context, ref),
                    ),

                    const SizedBox(height: AppSizes.xl),

                    SettingsLegalSection(
                      onTermsTap: () {
                        // TODO: open Terms of Service
                      },

                      onPrivacyTap: () {
                        // TODO: open Privacy Policy
                      },

                      onLicensesTap: () {
                        // TODO: navigate to licenses
                      },
                    ),

                    const SizedBox(height: AppSizes.xl),

                    SettingsFooterActions(
                      versionLabel: 'v2.4.1 (Build 2026)',

                      onLogOutTap: () {
                        // TODO: call authControllerProvider.logout()
                      },

                      onDeleteAccountTap: () {
                        _confirmDeleteAccount(context, ref);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

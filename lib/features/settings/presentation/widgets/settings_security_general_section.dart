import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/common/settings_group.dart';
import '../../../../core/widgets/common/settings_tile.dart';
import 'package:salesysx/core/locale/app_localizations_x.dart';

/// Security and General groups — a toggle plus several
/// navigate-to-detail rows.
class SettingsSecurityGeneralSection extends StatelessWidget {
  final bool biometricAuth;
  final ValueChanged<bool>? onBiometricAuthChanged;
  final VoidCallback? onTwoFactorAuthTap;
  final VoidCallback? onActiveSessionsTap;
  final String languageValue;
  final VoidCallback? onLanguageTap;
  final String regionValue;
  final VoidCallback? onRegionTap;
  final VoidCallback? onChangePssword;

  const SettingsSecurityGeneralSection({
    super.key,
    this.biometricAuth = false,
    this.onBiometricAuthChanged,
    this.onTwoFactorAuthTap,
    this.onActiveSessionsTap,
    this.languageValue = 'English',
    this.onLanguageTap,
    this.regionValue = 'United States',
    this.onRegionTap,
    this.onChangePssword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsGroup(
          label: context.l10n.securitySection,
          children: [
            SettingsTile(
              title: context.l10n.biometricAuth,
              switchValue: biometricAuth,
              onSwitchChanged: onBiometricAuthChanged,
            ),
            SettingsTile(
              title: context.l10n.twoFactorAuth,
              onTap: onTwoFactorAuthTap,
            ),
            SettingsTile(
              title: context.l10n.activeSessions,
              onTap: onActiveSessionsTap,
            ),
          ],
        ),
        const SizedBox(height: AppSizes.lg),
        SettingsGroup(
          label: context.l10n.generalSection,
          children: [
            SettingsTile(
              title: context.l10n.language,
              value: languageValue,
              onTap: onLanguageTap,
            ),
            SettingsTile(
              title: context.l10n.region,
              value: regionValue,
              onTap: onRegionTap,
            ),
            SettingsTile(
              title: context.l10n.changePasswordTitle,
              // value: regionValue,
              onTap: onChangePssword,
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/widgets/common/settings_group.dart';
import '../../../../core/widgets/common/settings_tile.dart';
import 'package:salesysx/core/locale/app_localizations_x.dart';

/// Legal group — Terms and Privacy open external links; Licenses
/// navigates to a detail screen.
class SettingsLegalSection extends StatelessWidget {
  final VoidCallback? onTermsTap;
  final VoidCallback? onPrivacyTap;
  final VoidCallback? onLicensesTap;

  const SettingsLegalSection({
    super.key,
    this.onTermsTap,
    this.onPrivacyTap,
    this.onLicensesTap,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsGroup(
      label: context.l10n.legalSection,
      children: [
        SettingsTile(
          title: context.l10n.termsOfService,
          trailing: SettingsTileTrailing.externalLink,
          onTap: onTermsTap,
        ),
        SettingsTile(
          title: context.l10n.privacyTitle,
          trailing: SettingsTileTrailing.externalLink,
          onTap: onPrivacyTap,
        ),
        SettingsTile(
          title: context.l10n.openSourceLicenses,
          onTap: onLicensesTap,
        ),
      ],
    );
  }
}

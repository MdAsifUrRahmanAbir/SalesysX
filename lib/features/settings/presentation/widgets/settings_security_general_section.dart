import 'package:flutter/material.dart';
import '../../../../core/widgets/common/settings_group.dart';
import '../../../../core/widgets/common/settings_tile.dart';
import 'package:salesysx/core/locale/app_localizations_x.dart';

/// General group — profile, language, password and help.
class SettingsSecurityGeneralSection extends StatelessWidget {
  final String languageValue;
  final VoidCallback? onLanguageTap;
  final VoidCallback? onChangePssword;
  final VoidCallback? onEditProfileTap;
  final VoidCallback? onHelpTap;

  const SettingsSecurityGeneralSection({
    super.key,
    this.onEditProfileTap,
    this.onHelpTap,
    this.languageValue = 'English',
    this.onLanguageTap,
    this.onChangePssword,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsGroup(
      label: context.l10n.generalSection,
      children: [
        SettingsTile(
          title: context.l10n.editProfileTitle,
          onTap: onEditProfileTap,
        ),
        SettingsTile(
          title: context.l10n.language,
          value: languageValue,
          onTap: onLanguageTap,
        ),
        SettingsTile(
          title: context.l10n.changePasswordTitle,
          onTap: onChangePssword,
        ),
        SettingsTile(
          title: context.l10n.helpSupportTitle,
          onTap: onHelpTap,
        ),
      ],
    );
  }
}

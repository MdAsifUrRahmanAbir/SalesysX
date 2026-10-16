import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/common/settings_group.dart';
import '../../../../core/widgets/common/settings_tile.dart';
import 'package:salesysx/core/locale/app_localizations_x.dart';

/// Appearance and Notifications groups — toggles and a picker row.
/// Purely presentational: reports changes up via the callbacks, does
/// not persist anything itself.
class SettingsTogglesSection extends StatelessWidget {
  final bool darkMode;
  final ValueChanged<bool>? onDarkModeChanged;
  final String appThemeValue;
  final VoidCallback? onAppThemeTap;
  final bool pushNotifications;
  final ValueChanged<bool>? onPushNotificationsChanged;

  const SettingsTogglesSection({
    super.key,
    this.darkMode = false,
    this.onDarkModeChanged,
    this.appThemeValue = 'System Default',
    this.onAppThemeTap,
    this.pushNotifications = false,
    this.onPushNotificationsChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsGroup(
          label: context.l10n.appearanceSection,
          children: [
            SettingsTile(
              title: context.l10n.darkMode,
              switchValue: darkMode,
              onSwitchChanged: onDarkModeChanged,
            ),
            SettingsTile(
              title: context.l10n.appTheme,
              value: appThemeValue,
              onTap: onAppThemeTap,
            ),
          ],
        ),
        const SizedBox(height: AppSizes.lg),
        SettingsGroup(
          label: context.l10n.notificationsSection,
          children: [
            SettingsTile(
              title: context.l10n.pushNotifications,
              switchValue: pushNotifications,
              onSwitchChanged: onPushNotificationsChanged,
            ),
          ],
        ),
      ],
    );
  }
}

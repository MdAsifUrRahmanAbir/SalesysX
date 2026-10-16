import 'package:flutter/material.dart';
import '../../../../core/widgets/common/settings_group.dart';
import '../../../../core/widgets/common/settings_tile.dart';
import 'package:salesysx/core/locale/app_localizations_x.dart';

/// Dev-only group for refreshing the seeded Firestore demo data —
/// kept here since `DemoDataSeeder` itself is documented as a
/// development-only utility, not production provisioning.
class SettingsDeveloperSection extends StatelessWidget {
  const SettingsDeveloperSection({super.key, this.onResetDemoDataTap});

  final VoidCallback? onResetDemoDataTap;

  @override
  Widget build(BuildContext context) {
    return SettingsGroup(
      label: context.l10n.developerSection,
      children: [
        SettingsTile(
          icon: Icons.refresh_rounded,
          title: context.l10n.resetDemoDataTitle,
          subtitle: 'Wipe and reseed Firestore with fresh dated demo data',
          trailing: SettingsTileTrailing.none,
          onTap: onResetDemoDataTap,
        ),
      ],
    );
  }
}

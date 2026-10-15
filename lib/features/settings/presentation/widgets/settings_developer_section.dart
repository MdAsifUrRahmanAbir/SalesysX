import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/common/settings_group.dart';
import '../../../../core/widgets/common/settings_tile.dart';

/// Dev-only group for refreshing the seeded Firestore demo data —
/// kept here since `DemoDataSeeder` itself is documented as a
/// development-only utility, not production provisioning.
class SettingsDeveloperSection extends StatelessWidget {
  const SettingsDeveloperSection({super.key, this.onResetDemoDataTap});

  final VoidCallback? onResetDemoDataTap;

  @override
  Widget build(BuildContext context) {
    return SettingsGroup(
      label: AppStrings.developerSection,
      children: [
        SettingsTile(
          icon: Icons.refresh_rounded,
          title: AppStrings.resetDemoDataTitle,
          subtitle: 'Wipe and reseed Firestore with fresh dated demo data',
          trailing: SettingsTileTrailing.none,
          onTap: onResetDemoDataTap,
        ),
      ],
    );
  }
}

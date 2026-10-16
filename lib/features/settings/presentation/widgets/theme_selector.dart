import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme_controller.dart';
import '../../../../core/widgets/common/settings_tile.dart';
import 'package:salesysx/core/locale/app_localizations_x.dart';

/// Cycles System → Light → Dark on tap, shown as a SettingsTile with the
/// current mode as its trailing value.
class ThemeSelector extends ConsumerWidget {
  const ThemeSelector({super.key});

  String _label(BuildContext context, ThemeMode mode) => switch (mode) {
    ThemeMode.system => context.l10n.themeSystem,
    ThemeMode.light => context.l10n.themeLight,
    ThemeMode.dark => context.l10n.themeDark,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeControllerProvider);
    final controller = ref.read(themeControllerProvider.notifier);

    return SettingsTile(
      icon: Icons.dark_mode_outlined,
      title: context.l10n.appearance,
      value: _label(context, mode),
      trailing: SettingsTileTrailing.chevron,
      onTap: () {
        final next = switch (mode) {
          ThemeMode.system => ThemeMode.light,
          ThemeMode.light => ThemeMode.dark,
          ThemeMode.dark => ThemeMode.system,
        };
        controller.setThemeMode(next);
      },
    );
  }
}

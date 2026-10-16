import 'package:flutter/material.dart';

import 'settings_mobile_view.dart';

/// Tablet layout: the same settings list, kept to a readable width.
class SettingsTabView extends StatelessWidget {
  const SettingsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: const SettingsMobileView(),
      ),
    );
  }
}

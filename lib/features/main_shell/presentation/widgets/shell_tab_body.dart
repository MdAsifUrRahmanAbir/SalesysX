import 'package:flutter/material.dart';
import 'package:salesysx/features/help_support/presentation/screens/help_support_screen.dart';
import 'package:salesysx/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:salesysx/features/terms_privacy/presentation/screens/terms_privacy_screen.dart';

/// Hosts all five bottom-nav destination screens in an [IndexedStack]
/// so switching tabs preserves each screen's scroll position and
/// state instead of rebuilding it from scratch every time.
class ShellTabBody extends StatelessWidget {
  final int selectedIndex;

  const ShellTabBody({super.key, required this.selectedIndex});

  static const _screens = [
    HelpSupportScreen(),
    NotificationsScreen(),
    TermsPrivacyScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return IndexedStack(index: selectedIndex, children: _screens);
  }
}
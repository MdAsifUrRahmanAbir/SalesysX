import 'package:flutter/material.dart';

import 'help_support_mobile_view.dart';

/// Tablet layout: the same help content, kept to a readable width.
class HelpSupportTabView extends StatelessWidget {
  const HelpSupportTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: const HelpSupportMobileView(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/widgets/common/link_button.dart';
import 'package:salesysx/core/locale/app_localizations_x.dart';

/// Top-left "Skip" action shown above the onboarding carousel.
class OnboardingTopBar extends StatelessWidget {
  final VoidCallback? onSkip;

  const OnboardingTopBar({super.key, this.onSkip});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: LinkButton(label: context.l10n.skip, onPressed: onSkip),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/common/primary_button.dart';
import '../../../../core/widgets/common/secondary_button.dart';
import 'package:salesysx/core/locale/app_localizations_x.dart';

/// Login (primary) + Register (secondary/outline) buttons at the
/// bottom of the welcome screen.
class WelcomeActions extends StatelessWidget {
  final VoidCallback? onLoginTap;
  final VoidCallback? onRegisterTap;

  const WelcomeActions({super.key, this.onLoginTap, this.onRegisterTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryButton(label: context.l10n.login, onPressed: onLoginTap),
        const SizedBox(height: AppSizes.md),
        SecondaryButton(label: context.l10n.register, onPressed: onRegisterTap),
      ],
    );
  }
}

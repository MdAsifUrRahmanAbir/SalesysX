import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_color_scheme.dart';
import '../../../../core/widgets/common/link_button.dart';
import 'package:salesysx/core/locale/app_localizations_x.dart';

/// "Don't have an account? Register" row shown at the bottom of the
/// sign-in screen.
class RegisterPrompt extends StatelessWidget {
  final VoidCallback? onRegisterTap;

  const RegisterPrompt({super.key, this.onRegisterTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.l10n.dontHaveAccount,
          style: TextStyle(
            fontSize: AppSizes.fontSm,
            color: context.appColors.textSecondary,
          ),
        ),
        LinkButton(
          label: context.l10n.register,
          fontSize: AppSizes.fontSm,
          onPressed: onRegisterTap,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_color_scheme.dart';
import 'package:salesysx/core/locale/app_localizations_x.dart';

/// "Welcome Back" heading shown at the top of the sign-in card.
class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      context.l10n.welcomeBack,
      style: TextStyle(
        fontSize: AppSizes.fontXl,
        fontWeight: FontWeight.w700,
        color: context.appColors.textPrimary,
      ),
    );
  }
}

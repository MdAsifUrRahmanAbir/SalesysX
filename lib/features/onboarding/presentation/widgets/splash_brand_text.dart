import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_color_scheme.dart';
import 'package:salesysx/core/locale/app_localizations_x.dart';

/// App name + tagline shown below the [SplashLogo].
class SplashBrandText extends StatelessWidget {
  const SplashBrandText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.l10n.appName,
          style: TextStyle(
            fontSize: AppSizes.fontDisplay,
            fontWeight: FontWeight.w700,
            color: context.appColors.textPrimary,
          ),
        ),
        SizedBox(height: AppSizes.xs),
        Text(
          context.l10n.appTagline,
          style: TextStyle(
            fontSize: AppSizes.fontMd,
            color: context.appColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

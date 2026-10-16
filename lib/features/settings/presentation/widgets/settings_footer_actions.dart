import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_color_scheme.dart';
import 'package:salesysx/core/locale/app_localizations_x.dart';

/// App version label and the Log Out action at the bottom of the
/// settings list.
class SettingsFooterActions extends StatelessWidget {
  final String versionLabel;
  final VoidCallback? onLogOutTap;

  const SettingsFooterActions({
    super.key,
    required this.versionLabel,
    this.onLogOutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          versionLabel,
          style: TextStyle(
            fontSize: AppSizes.fontSm,
            color: context.appColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSizes.sm + AppSizes.xs),
        SizedBox(
          width: double.infinity,
          height: AppSizes.xl + AppSizes.md,
          child: TextButton(
            onPressed: onLogOutTap,
            style: TextButton.styleFrom(
              backgroundColor: AppColors.error.withValues(alpha: 0.08),
              foregroundColor: AppColors.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
              ),
            ),
            child: Text(
              context.l10n.logOut,
              style: TextStyle(
                fontSize: AppSizes.fontMd,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

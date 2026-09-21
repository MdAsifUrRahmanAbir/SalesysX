import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';

/// Bottom action row — outlined Call / Message actions plus a filled
/// "Full Report" primary action, in the accent (teal) color this
/// screen uses instead of the app's default purple primary.
class TeamMemberActionBar extends StatelessWidget {
  final VoidCallback? onCallTap;
  final VoidCallback? onMessageTap;
  final VoidCallback? onFullReportTap;

  const TeamMemberActionBar({
    super.key,
    this.onCallTap,
    this.onMessageTap,
    this.onFullReportTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _OutlinedAction(icon: Icons.call_outlined, label: AppStrings.call, onTap: onCallTap)),
        const SizedBox(width: AppSizes.sm),
        Expanded(child: _OutlinedAction(icon: Icons.chat_bubble_outline_rounded, label: AppStrings.message, onTap: onMessageTap)),
        const SizedBox(width: AppSizes.sm),
        Expanded(
          child: SizedBox(
            height: AppSizes.xl + AppSizes.md,
            child: ElevatedButton(
              onPressed: onFullReportTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: AppColors.textWhite,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusSm)),
                textStyle: const TextStyle(fontSize: AppSizes.fontSm, fontWeight: FontWeight.w700),
              ),
              child: Text(AppStrings.fullReport),
            ),
          ),
        ),
      ],
    );
  }
}

class _OutlinedAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _OutlinedAction({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.xl + AppSizes.md,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: AppSizes.iconSm, color: AppColors.accent),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.accent,
          backgroundColor: AppColors.accentLight,
          side: const BorderSide(color: AppColors.accent),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusSm)),
          textStyle: const TextStyle(fontSize: AppSizes.fontSm, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_color_scheme.dart';
import '../../../../core/widgets/common/custom_card.dart';

/// Compact identity row at the top of the detail body — a bordered,
/// tinted initials circle plus name / role & employee id / email.
class TeamMemberProfileCard extends StatelessWidget {
  final String name;
  final String initials;
  final String roleLabel;
  final String email;

  const TeamMemberProfileCard({
    super.key,
    required this.name,
    required this.initials,
    required this.roleLabel,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: AppSizes.xxl + AppSizes.md,
            height: AppSizes.xxl + AppSizes.md,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accentLight,
              border: Border.all(color: AppColors.accent, width: 2),
            ),
            child: Text(
              initials,
              style: TextStyle(fontSize: AppSizes.fontXxl - AppSizes.xs / 2, fontWeight: FontWeight.w700, color: AppColors.accent),
            ),
          ),
          const SizedBox(width: AppSizes.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: AppSizes.fontLg, fontWeight: FontWeight.w700, color: context.appColors.textPrimary),
                ),
                const SizedBox(height: AppSizes.xs / 2),
                Text(
                  roleLabel,
                  style: TextStyle(fontSize: AppSizes.fontSm, color: context.appColors.textSecondary),
                ),
                const SizedBox(height: AppSizes.xs / 2),
                Text(
                  email,
                  style: TextStyle(fontSize: AppSizes.fontXs, color: context.appColors.textHint),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
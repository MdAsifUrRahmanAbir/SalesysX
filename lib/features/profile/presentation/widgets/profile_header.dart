import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/core_widgets.dart';

/// Profile page header: large avatar, name, role badge + employee ID,
/// and team/division line.
///
/// NOTE: avatar built as a plain `CircleAvatar`, not the core `AppAvatar`
/// — its real constructor is still unconfirmed (see prior screens' notes).
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.name,
    required this.avatarInitials,
    required this.employeeId,
    required this.team,
    required this.division,
  });

  final String name;
  final String avatarInitials;
  final String employeeId;
  final String team;
  final String division;

  static const double _avatarSize = 80;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.surface,
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.md,
        vertical: AppSizes.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: _avatarSize,
            height: _avatarSize,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 2),
            ),
            alignment: Alignment.center,
            child: Text(
              avatarInitials,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: AppSizes.fontXxl,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: AppSizes.sm),
          Text(
            name,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: AppSizes.fontXl,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: AppSizes.xs),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              StatusBadge(
                text: AppStrings.profileRoleSalesman,
                type: StatusBadgeType.primary,
                shape: StatusBadgeShape.square,
                compact: true,
              ),
              SizedBox(width: AppSizes.xs),
              Text(
                '${AppStrings.employeeIdPrefix} $employeeId',
                style: TextStyle(
                  color: AppColors.textHint,
                  fontSize: AppSizes.fontSm,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.xs),
          Text(
            AppStrings.teamAndDivision(team, division),
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: AppSizes.fontSm,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
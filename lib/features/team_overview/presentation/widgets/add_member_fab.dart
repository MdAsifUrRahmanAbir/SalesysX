import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';

/// Floating "Add Member" pill, positioned absolutely within the view's
/// own Stack (not `Scaffold.floatingActionButton`) — see assumptions
/// note re: keeping `_screen.dart` an untouched thin wrapper.
class AddMemberFab extends StatelessWidget {
  const AddMemberFab({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.radiusFull),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.md,
            vertical: AppSizes.sm + AppSizes.xs,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(AppSizes.radiusFull),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.person_add_alt_1_rounded,
                  size: AppSizes.iconSm, color: AppColors.textWhite),
              SizedBox(width: AppSizes.xs),
              Text(
                AppStrings.addMember,
                style: TextStyle(
                  color: AppColors.textWhite,
                  fontSize: AppSizes.fontSm,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
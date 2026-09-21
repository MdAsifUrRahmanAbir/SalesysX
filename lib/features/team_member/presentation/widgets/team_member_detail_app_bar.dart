import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_color_scheme.dart';
import '../../../../core/widgets/common/status_badge.dart';

/// Top bar for the team-member detail screen — a plain back chevron,
/// the member's name as the title, and a compact risk-status badge
/// (e.g. "AT RISK") pinned to the trailing edge.
///
/// Distinct from [AppHeaderBar]/[CustomAppBar] because the trailing
/// slot here must hold a [StatusBadge] widget, not just an icon/label.
class TeamMemberDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String memberName;
  final String riskLabel;
  final StatusBadgeType riskType;
  final VoidCallback? onBackTap;

  const TeamMemberDetailAppBar({
    super.key,
    required this.memberName,
    this.riskLabel = AppStrings.atRiskLabel,
    this.riskType = StatusBadgeType.error,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        border: Border(bottom: BorderSide(color: context.appColors.border)),
      ),
      child: Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(AppSizes.radiusFull),
            onTap: onBackTap ?? () => Navigator.of(context).maybePop(),
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.xs),
              child: Icon(Icons.arrow_back_rounded, size: AppSizes.iconMd, color: context.appColors.textPrimary),
            ),
          ),
          const SizedBox(width: AppSizes.sm + AppSizes.xs),
          Expanded(
            child: Text(
              memberName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: AppSizes.fontXl, fontWeight: FontWeight.w700, color: context.appColors.textPrimary),
            ),
          ),
          const SizedBox(width: AppSizes.sm),
          StatusBadge(text: riskLabel, type: riskType, shape: StatusBadgeShape.square, compact: true),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppSizes.appBarHeight);
}
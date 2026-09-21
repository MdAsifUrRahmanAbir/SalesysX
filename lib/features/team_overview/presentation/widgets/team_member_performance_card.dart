import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_color_scheme.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/core_widgets.dart';
import '../states/team_overview_state.dart';

/// One team member's performance card: avatar + name/online-dot/role,
/// an achieved-percent badge, a target/achieved/today's-sale row, and a
/// thin progress bar. Avatar styling follows [TeamMemberPerformance.isOnline];
/// badge/bar color follow [TeamMemberPerformance.status].
class TeamMemberPerformanceCard extends StatelessWidget {
  const TeamMemberPerformanceCard({super.key, required this.member, this.onTap});

  final TeamMemberPerformance member;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isGood = member.status == PerformanceStatus.good;
    final statusColor = isGood ? AppColors.success : AppColors.warning;
    final barColor = isGood ? AppColors.primary : AppColors.warning;
    final avatarColor =
    member.isOnline ? AppColors.primary : context.appColors.textHint;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      child: CustomCard(
        padding: EdgeInsets.all(AppSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: AppSizes.xxl,
                        height: AppSizes.xxl,
                        decoration: BoxDecoration(
                          color: context.appColors.background,
                          shape: BoxShape.circle,
                          border: Border.all(color: avatarColor),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          member.initials,
                          style: TextStyle(
                            color: avatarColor,
                            fontSize: AppSizes.fontSm,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(width: AppSizes.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    member.name,
                                    style: TextStyle(
                                      color: context.appColors.textPrimary,
                                      fontSize: AppSizes.fontMd,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: AppSizes.xs),
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: member.isOnline
                                        ? AppColors.success
                                        : context.appColors.textHint,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              member.role,
                              style: TextStyle(
                                color: context.appColors.textSecondary,
                                fontSize: AppSizes.fontXs,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                StatusBadge(
                  text: '${member.achievedPercent}%',
                  type: isGood ? StatusBadgeType.success : StatusBadgeType.warning,
                  shape: StatusBadgeShape.square,
                  compact: true,
                ),
              ],
            ),
            SizedBox(height: AppSizes.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _FigureColumn(
                  label: AppStrings.targetCapsLabel,
                  value: CurrencyFormatter.format(member.target),
                  valueColor: context.appColors.textPrimary,
                  alignEnd: false,
                ),
                _FigureColumn(
                  label: AppStrings.achievedLabel,
                  value: CurrencyFormatter.format(member.achieved),
                  valueColor: AppColors.primaryDark,
                  alignEnd: false,
                ),
                _FigureColumn(
                  label: AppStrings.todaysSaleCapsLabel,
                  value: CurrencyFormatter.format(member.todaySale),
                  valueColor: context.appColors.textPrimary,
                  alignEnd: true,
                ),
              ],
            ),
            SizedBox(height: AppSizes.xs),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.xs),
              child: LinearProgressIndicator(
                value: member.achievedPercent / 100,
                minHeight: 6,
                backgroundColor: context.appColors.border,
                valueColor: AlwaysStoppedAnimation(barColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FigureColumn extends StatelessWidget {
  const _FigureColumn({
    required this.label,
    required this.value,
    required this.valueColor,
    required this.alignEnd,
  });

  final String label;
  final String value;
  final Color valueColor;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            color: context.appColors.textHint,
            fontSize: AppSizes.fontXs - 1,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: AppSizes.fontSm,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
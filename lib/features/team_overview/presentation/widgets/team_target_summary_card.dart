import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_color_scheme.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/core_widgets.dart';
import 'package:salesysx/core/locale/app_localizations_x.dart';

/// Team target & performance summary card: title + "X% Reached" badge,
/// total target / achieved figures, a linear progress bar, and a
/// two-column stat row (total members / active today) separated by a
/// vertical divider.
class TeamTargetSummaryCard extends StatelessWidget {
  const TeamTargetSummaryCard({
    super.key,
    required this.totalTarget,
    required this.totalAchieved,
    required this.achievedPercent,
    required this.totalMembers,
    required this.onlineCount,
  });

  final double totalTarget;
  final double totalAchieved;
  final double achievedPercent; // 0..1
  final int totalMembers;
  final int onlineCount;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.all(AppSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.teamTargetAndPerformance,
                style: TextStyle(
                  color: context.appColors.textHint,
                  fontSize: AppSizes.fontXs,
                  fontWeight: FontWeight.w700,
                ),
              ),
              StatusBadge(
                text: context.l10n.percentReached((achievedPercent * 100).round()),
                type: StatusBadgeType.primary,
                shape: StatusBadgeShape.square,
                compact: true,
              ),
            ],
          ),
          SizedBox(height: AppSizes.sm + AppSizes.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.l10n.totalTargetLabel,
                    style: TextStyle(
                      color: context.appColors.textHint,
                      fontSize: AppSizes.fontXs,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    CurrencyFormatter.format(totalTarget),
                    style: TextStyle(
                      color: context.appColors.textPrimary,
                      fontSize: AppSizes.fontXl,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.l10n.achievedLabel,
                    style: TextStyle(
                      color: context.appColors.textHint,
                      fontSize: AppSizes.fontXs,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    CurrencyFormatter.format(totalAchieved),
                    style: TextStyle(
                      color: AppColors.success,
                      fontSize: AppSizes.fontXl,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: AppSizes.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.xs),
            child: LinearProgressIndicator(
              value: achievedPercent,
              minHeight: AppSizes.xs,
              backgroundColor: AppColors.primaryLight,
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
          SizedBox(height: AppSizes.md),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        context.l10n.totalMembersLabel,
                        style: TextStyle(
                          color: context.appColors.textHint,
                          fontSize: AppSizes.fontXs,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        context.l10n.representativesCount(totalMembers),
                        style: TextStyle(
                          color: context.appColors.textPrimary,
                          fontSize: AppSizes.fontMd,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                VerticalDivider(width: AppSizes.md, color: context.appColors.border),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        context.l10n.activeTodayLabel,
                        style: TextStyle(
                          color: context.appColors.textHint,
                          fontSize: AppSizes.fontXs,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.success,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: AppSizes.xs),
                          Text(
                            context.l10n.onlineCountLabel(onlineCount),
                            style: TextStyle(
                              color: context.appColors.textPrimary,
                              fontSize: AppSizes.fontMd,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
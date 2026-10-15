import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_color_scheme.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/utility/custom_refresh_wrapper.dart';
import '../../../../core/widgets/utility/custom_shimmer.dart';
import '../../../../core/widgets/utility/custom_snackbar.dart';
import '../../../../core/widgets/utility/empty_state.dart';
import '../../../../core/widgets/utility/error_state.dart';
import '../controllers/team_member_controller.dart';
import '../widgets/sales_activity_item.dart';
import '../widgets/team_member_action_bar.dart';
import '../widgets/team_member_daily_stat_card.dart';
import '../widgets/team_member_detail_app_bar.dart';
import '../widgets/team_member_profile_card.dart';
import '../widgets/team_member_target_card.dart';

class TeamMemberMobileView extends ConsumerWidget {
  const TeamMemberMobileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(teamMemberControllerProvider);
    final controller = ref.read(teamMemberControllerProvider.notifier);
    final isFirstLoad = state.isInitialLoading && state.name.isEmpty;

    return Scaffold(
      appBar: TeamMemberDetailAppBar(
        memberName: state.name.isEmpty ? '...' : state.name,
        riskLabel: state.isOnTrack ? AppStrings.statusOnTrack : AppStrings.atRiskLabel,
        riskType: state.riskBadgeType,
      ),
      body: isFirstLoad
          ? _buildShimmer()
          : state.errorMessage != null && state.name.isEmpty
              ? ErrorState(message: state.errorMessage!, onRetry: controller.refresh)
              : CustomRefreshWrapper(
                  onRefresh: controller.refresh,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppSizes.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TeamMemberProfileCard(
                          name: state.name,
                          initials: state.initials,
                          roleLabel: state.roleLabel,
                          email: state.email,
                        ),
                        const SizedBox(height: AppSizes.lg),
                        TeamMemberTargetCard(
                          achievedPercent: state.achievedPercent,
                          monthlyTarget: CurrencyFormatter.format(state.monthlyTarget),
                          achievedAmount: CurrencyFormatter.format(state.achievedAmount),
                          remainingAmount: CurrencyFormatter.format(state.remainingAmount),
                        ),
                        const SizedBox(height: AppSizes.lg),
                        Row(
                          children: [
                            Expanded(
                              child: TeamMemberDailyStatCard(
                                label: AppStrings.todaysTargetLabel,
                                value: CurrencyFormatter.format(state.todaysTarget),
                                note: AppStrings.dailyAssignment,
                                valueColor: context.appColors.textPrimary,
                                noteColor: context.appColors.textSecondary,
                              ),
                            ),
                            const SizedBox(width: AppSizes.sm + AppSizes.xs),
                            Expanded(
                              child: TeamMemberDailyStatCard(
                                label: AppStrings.todaysSalesLabel,
                                value: CurrencyFormatter.format(state.todaysSales),
                                note: state.todaysGap > 0
                                    ? '${CurrencyFormatter.format(state.todaysGap)} deficit today'
                                    : 'Target met today',
                                valueColor: state.todaysGap > 0
                                    ? AppColors.error
                                    : context.appColors.textPrimary,
                                noteColor: state.todaysGap > 0
                                    ? AppColors.error
                                    : context.appColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSizes.lg),
                        Text(
                          AppStrings.recentSalesActivity,
                          style: TextStyle(fontSize: AppSizes.fontSm, fontWeight: FontWeight.w700, color: context.appColors.textPrimary),
                        ),
                        const SizedBox(height: AppSizes.sm + AppSizes.xs),
                        if (state.recentSales.isEmpty)
                          const EmptyState(title: 'No sales recorded yet')
                        else
                          for (final item in state.recentSales) ...[
                            SalesActivityItem(
                              outletName: item.outletName,
                              detailLine: item.detailLine,
                              amount: item.amountLabel,
                            ),
                            if (item != state.recentSales.last) const SizedBox(height: AppSizes.sm),
                          ],
                      ],
                    ),
                  ),
                ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.md),
          child: TeamMemberActionBar(
            onCallTap: state.phone.isEmpty
                ? null
                : () => launchUrl(Uri(scheme: 'tel', path: state.phone)),
            onMessageTap: state.phone.isEmpty
                ? null
                : () => launchUrl(Uri(scheme: 'sms', path: state.phone)),
            onFullReportTap: () =>
                CustomSnackBar.show(context, AppStrings.reportsComingSoonTitle),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.lg),
      child: Column(
        children: [
          CustomShimmer(height: 80, borderRadius: BorderRadius.circular(AppSizes.radiusLg)),
          const SizedBox(height: AppSizes.lg),
          CustomShimmer(height: 140, borderRadius: BorderRadius.circular(AppSizes.radiusLg)),
          const SizedBox(height: AppSizes.lg),
          CustomShimmer(height: 90, borderRadius: BorderRadius.circular(AppSizes.radiusLg)),
        ],
      ),
    );
  }
}

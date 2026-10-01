import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/utility/custom_refresh_wrapper.dart';
import '../../../../core/widgets/utility/custom_shimmer.dart';
import '../../../../core/widgets/utility/error_state.dart';
import '../controllers/salesman_home_controller.dart';
import '../widgets/create_sale_entry_button.dart';
import '../widgets/daily_run_rate_card.dart';
import '../widgets/monthly_target_card.dart';
import '../widgets/sales_stat_row.dart';
import '../widgets/salesman_greeting_header.dart';

class SalesmanHomeMobileView extends ConsumerWidget {
  const SalesmanHomeMobileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(salesmanHomeControllerProvider);
    final controller = ref.read(salesmanHomeControllerProvider.notifier);

    final isFirstLoad = state.isLoading && state.salesmanName.isEmpty;

    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: isFirstLoad
            ? _buildShimmer()
            : state.errorMessage != null
            ? ErrorState(message: state.errorMessage!, onRetry: controller.refresh)
            : CustomRefreshWrapper(
          onRefresh: controller.refresh,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.sm),
            children: [
              SalesmanGreetingHeader(
                name: state.salesmanName,
                avatarInitials: state.avatarInitials,
                onNotificationTap: () {
                  // TODO: wire to context.push(RouteNames.notifications)
                },
              ),
              SizedBox(height: AppSizes.md),
              CreateSaleEntryButton(
                onPressed: () {
                  // TODO: wire to context.push(RouteNames.new_sale_entry)
                },
              ),
              SizedBox(height: AppSizes.md),
              MonthlyTargetCard(
                target: state.monthlyTarget,
                achieved: state.achievedAmount,
                remaining: state.remainingAmount,
                achievedPercent: state.achievedPercent,
              ),
              SizedBox(height: AppSizes.md),
              SalesStatRow(
                todaysSales: state.todaysSales,
                todaysSalesChangePercent: state.todaysSalesChangePercent,
                remaining: state.remainingAmount,
              ),
              SizedBox(height: AppSizes.md),
              DailyRunRateCard(
                daysLeft: state.daysLeftInMonth,
                targetRunRate: state.targetRunRatePerDay,
                currentRunRate: state.currentAvgRunRatePerDay,
                isOnTrack: state.isOnTrack,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return Padding(
      padding: EdgeInsets.all(AppSizes.md),
      child: Column(
        children: [
          CustomShimmer(height: 72, borderRadius: BorderRadius.circular(AppSizes.radiusLg)),
          SizedBox(height: AppSizes.md),
          CustomShimmer(height: 48, borderRadius: BorderRadius.circular(AppSizes.radiusLg)),
          SizedBox(height: AppSizes.md),
          CustomShimmer(height: 140, borderRadius: BorderRadius.circular(AppSizes.radiusLg)),
          SizedBox(height: AppSizes.md),
          CustomShimmer(height: 90, borderRadius: BorderRadius.circular(AppSizes.radiusLg)),
          SizedBox(height: AppSizes.md),
          CustomShimmer(height: 110, borderRadius: BorderRadius.circular(AppSizes.radiusLg)),
        ],
      ),
    );
  }
}
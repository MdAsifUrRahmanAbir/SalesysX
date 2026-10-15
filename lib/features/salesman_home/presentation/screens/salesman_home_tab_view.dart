import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:salesysx/routes/route_names.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../notifications/presentation/controllers/notification_controller.dart';
import '../../../../core/constants/app_sizes.dart';
import '../controllers/salesman_home_controller.dart';
import '../widgets/create_sale_entry_button.dart';
import '../widgets/daily_run_rate_card.dart';
import '../widgets/monthly_target_card.dart';
import '../widgets/sales_stat_row.dart';
import '../widgets/salesman_greeting_header.dart';

class SalesmanHomeTabView extends ConsumerWidget {
  const SalesmanHomeTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(salesmanHomeControllerProvider);

    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.md,
                vertical: AppSizes.sm,
              ),
              children: [
                SalesmanGreetingHeader(
                  name: state.salesmanName,
                  avatarInitials: state.avatarInitials,
                  unreadCount: ref.watch(notificationControllerProvider).unreadCount,
                  onNotificationTap: () => context.push(RouteNames.notifications),
                ),
                SizedBox(height: AppSizes.md),
                CreateSaleEntryButton(
                  onPressed: () => context.push(RouteNames.new_sale_entry),
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
      ),
    );
  }
}
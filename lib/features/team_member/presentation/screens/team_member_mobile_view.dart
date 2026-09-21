import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_color_scheme.dart';
import '../widgets/team_member_detail_app_bar.dart';
import '../widgets/team_member_profile_card.dart';
import '../widgets/team_member_target_card.dart';
import '../widgets/team_member_daily_stat_card.dart';
import '../widgets/sales_activity_item.dart';
import '../widgets/team_member_action_bar.dart';

class TeamMemberMobileView extends ConsumerWidget {
  const TeamMemberMobileView({super.key});

  // TODO: replace hardcoded member/target/activity data with
  // teamMemberDetailControllerProvider once features/team_member/data/repositories
  // is wired to the real staff-performance endpoint.
  static const _activity = [
    SalesActivityItem(
      outletName: 'Anowar Kirana, Mirpur',
      detailLine: 'Mango Juice 250ml x 12 • Today, 02:45 PM',
      amount: '৳370',
    ),
    SalesActivityItem(
      outletName: 'Mayer Doa Enterprise, Uttara',
      detailLine: 'Orange Drink 500ml x 24 • Today, 11:30 AM',
      amount: '৳1,200',
    ),
    SalesActivityItem(
      outletName: 'Dhaka Mart, Banani',
      detailLine: 'Potato Chips x 50 • Yesterday, 04:15 PM',
      amount: '৳800',
    ),
    SalesActivityItem(
      outletName: 'Popular Store, Dhanmondi',
      detailLine: 'Drinking Water 1L x 120 • 24 Oct, 10:10 AM',
      amount: '৳1,500',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const TeamMemberDetailAppBar(memberName: 'Rahim Uddin'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TeamMemberProfileCard(
              name: 'Rahim Uddin',
              initials: 'RU',
              roleLabel: 'Role: Salesman • EMP-0042',
              email: 'rahim.uddin@company.com',
            ),
            const SizedBox(height: AppSizes.lg),
            const TeamMemberTargetCard(
              achievedPercent: 68,
              monthlyTarget: '৳5,00,000',
              achievedAmount: '৳3,40,000',
              remainingAmount: '৳1,60,000',
            ),
            const SizedBox(height: AppSizes.lg),
            Row(
              children: [
                Expanded(
                  child: TeamMemberDailyStatCard(
                    label: AppStrings.todaysTargetLabel,
                    value: '৳15,000',
                    note: AppStrings.dailyAssignment,
                    valueColor: context.appColors.textPrimary,
                    noteColor: context.appColors.textSecondary,
                  ),
                ),
                const SizedBox(width: AppSizes.sm + AppSizes.xs),
                const Expanded(
                  child: TeamMemberDailyStatCard(
                    label: AppStrings.todaysSalesLabel,
                    value: '৳8,500',
                    note: '৳6,500 deficit today',
                    valueColor: AppColors.error,
                    noteColor: AppColors.error,
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
            for (final item in _activity) ...[
              item,
              if (item != _activity.last) const SizedBox(height: AppSizes.sm),
            ],
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.md),
          child: TeamMemberActionBar(
            onCallTap: () {
              // TODO: launch dialer via url_launcher once wired
            },
            onMessageTap: () {
              // TODO: launch messaging flow once wired
            },
            onFullReportTap: () {
              // TODO: navigate to a full staff report route once it exists
            },
          ),
        ),
      ),
    );
  }
}
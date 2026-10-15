import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_color_scheme.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/common/app_header_bar.dart';
import '../../../../core/widgets/common/summary_card.dart';
import '../../../../core/widgets/utility/custom_refresh_wrapper.dart';
import '../../../../core/widgets/utility/empty_state.dart';
import '../../../../core/widgets/utility/error_state.dart';
import '../controllers/team_reports_controller.dart';
import '../widgets/category_sales_bar.dart';
import '../widgets/salesman_rank_tile.dart';

class TeamReportsTabView extends ConsumerWidget {
  const TeamReportsTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(teamReportsControllerProvider);
    final controller = ref.read(teamReportsControllerProvider.notifier);
    final isFirstLoad = state.isLoading && state.ranking.isEmpty;

    return Container(
      color: context.appColors.background,
      child: SafeArea(
        child: Column(
          children: [
            AppHeaderBar(title: AppStrings.teamReportsTitle),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 640),
                  child: isFirstLoad
                      ? const SizedBox.shrink()
                      : state.errorMessage != null
                          ? ErrorState(message: state.errorMessage!, onRetry: controller.refresh)
                          : CustomRefreshWrapper(
                              onRefresh: controller.refresh,
                              child: ListView(
                                padding: EdgeInsets.all(AppSizes.md),
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SummaryCard(
                                          label: AppStrings.totalTargetLabel,
                                          value: CurrencyFormatter.format(state.totalTarget),
                                        ),
                                      ),
                                      SizedBox(width: AppSizes.sm),
                                      Expanded(
                                        child: SummaryCard(
                                          label: AppStrings.achievedLabel,
                                          value: CurrencyFormatter.format(state.totalAchieved),
                                        ),
                                      ),
                                      SizedBox(width: AppSizes.sm),
                                      Expanded(
                                        child: SummaryCard(
                                          label: '%',
                                          value: '${state.achievedPercent.round()}%',
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: AppSizes.lg),
                                  Text(
                                    AppStrings.salesmanRankingTitle,
                                    style: TextStyle(fontSize: AppSizes.fontMd, fontWeight: FontWeight.w700, color: context.appColors.textPrimary),
                                  ),
                                  SizedBox(height: AppSizes.sm),
                                  if (state.ranking.isEmpty)
                                    const EmptyState(title: 'No team sales yet this month')
                                  else
                                    for (var i = 0; i < state.ranking.length; i++) ...[
                                      SalesmanRankTile(rank: i + 1, row: state.ranking[i]),
                                      SizedBox(height: AppSizes.xs),
                                    ],
                                  SizedBox(height: AppSizes.lg),
                                  Text(
                                    AppStrings.salesByCategoryTitle,
                                    style: TextStyle(fontSize: AppSizes.fontMd, fontWeight: FontWeight.w700, color: context.appColors.textPrimary),
                                  ),
                                  SizedBox(height: AppSizes.sm),
                                  if (state.categorySales.isEmpty)
                                    const EmptyState(title: 'No sales yet this month')
                                  else
                                    for (final row in state.categorySales) CategorySalesBar(row: row),
                                ],
                              ),
                            ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:salesysx/routes/route_names.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_color_scheme.dart';
import '../../../../core/widgets/utility/custom_refresh_wrapper.dart';
import '../../../../core/widgets/utility/empty_state.dart';
import '../../../../core/widgets/utility/error_state.dart';
import '../controllers/team_sales_list_controller.dart';
import '../widgets/new_sale_fab.dart';
import '../widgets/team_sale_row_tile.dart';
import '../widgets/team_sales_list_header.dart';

class TeamSalesListTabView extends ConsumerWidget {
  const TeamSalesListTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(teamSalesListControllerProvider);
    final controller = ref.read(teamSalesListControllerProvider.notifier);
    final isFirstLoad = state.isLoading && state.rows.isEmpty;

    return Container(
      color: context.appColors.background,
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const TeamSalesListHeader(),
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 640),
                      child: isFirstLoad
                          ? const SizedBox.shrink()
                          : state.errorMessage != null
                              ? ErrorState(message: state.errorMessage!, onRetry: controller.refresh)
                              : state.rows.isEmpty
                                  ? const EmptyState(title: 'No sales recorded yet')
                                  : CustomRefreshWrapper(
                                      onRefresh: controller.refresh,
                                      child: ListView.separated(
                                        padding: EdgeInsets.fromLTRB(
                                          AppSizes.md,
                                          AppSizes.md,
                                          AppSizes.md,
                                          AppSizes.xxl * 2,
                                        ),
                                        itemCount: state.rows.length,
                                        separatorBuilder: (_, __) => SizedBox(height: AppSizes.sm),
                                        itemBuilder: (context, index) => TeamSaleRowTile(row: state.rows[index]),
                                      ),
                                    ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              right: AppSizes.md,
              bottom: AppSizes.lg,
              child: NewSaleFab(onTap: () => context.push(RouteNames.new_sale_entry)),
            ),
          ],
        ),
      ),
    );
  }
}

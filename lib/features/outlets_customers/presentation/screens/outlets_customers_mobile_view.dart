import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/utility/custom_bottom_sheet.dart';
import '../../../../core/widgets/utility/custom_refresh_wrapper.dart';
import '../../../../core/widgets/utility/custom_shimmer.dart';
import '../../../../core/widgets/utility/custom_snackbar.dart';
import '../../../../core/widgets/utility/empty_state.dart';
import '../../../../core/widgets/utility/error_state.dart';
import '../controllers/outlets_customers_controller.dart';
import '../widgets/add_outlet_sheet.dart';
import '../widgets/outlet_detail_sheet.dart';
import '../widgets/outlet_list.dart';
import '../widgets/outlet_search_field.dart';
import '../widgets/outlet_status_filter_chips.dart';
import '../widgets/outlets_customers_header.dart';

class OutletsCustomersMobileView extends ConsumerWidget {
  const OutletsCustomersMobileView({super.key});

  List<String> _filterOptions(BuildContext context) => [
    context.l10n.filterAll,
    context.l10n.filterActive,
    context.l10n.filterNew,
    context.l10n.filterPotential,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(outletsCustomersControllerProvider);
    final controller = ref.read(outletsCustomersControllerProvider.notifier);
    final isFirstLoad = state.isLoading && state.outlets.isEmpty;

    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Column(
          children: [
            OutletsCustomersHeader(
              onAddTap: () => CustomBottomSheet.show<void>(
                context,
                child: AddOutletSheet(
                  onCreated: (_) {
                    controller.refresh();
                    CustomSnackBar.show(context, AppStrings.outletAddedSuccess);
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppSizes.md,
                AppSizes.sm,
                AppSizes.md,
                AppSizes.xs,
              ),
              child: Column(
                children: [
                  OutletSearchField(
                    controller: controller.searchController,
                    onChanged: controller.setSearchQuery,
                  ),
                  SizedBox(height: AppSizes.sm),
                  OutletStatusFilterChips(
                    options: _filterOptions(context),
                    selected: state.selectedFilter,
                    onSelected: controller.selectFilter,
                  ),
                ],
              ),
            ),
            Expanded(
              child: isFirstLoad
                  ? _buildShimmer()
                  : state.errorMessage != null
                      ? ErrorState(message: state.errorMessage!, onRetry: controller.refresh)
                      : state.filteredOutlets.isEmpty
                      ? const EmptyState(title: 'No outlets found')
                      : CustomRefreshWrapper(
                          onRefresh: controller.refresh,
                          child: ListView(
                            padding: EdgeInsets.fromLTRB(
                              AppSizes.md,
                              AppSizes.xs,
                              AppSizes.md,
                              AppSizes.md,
                            ),
                            children: [
                              OutletList(
                                outlets: state.filteredOutlets,
                                onOutletTap: (outlet) {
                                  CustomBottomSheet.show<void>(
                                    context,
                                    child: OutletDetailSheet(outlet: outlet),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return Padding(
      padding: EdgeInsets.all(AppSizes.md),
      child: Column(
        children: [
          for (var i = 0; i < 4; i++) ...[
            CustomShimmer(height: 150, borderRadius: BorderRadius.circular(AppSizes.radiusLg)),
            SizedBox(height: AppSizes.sm),
          ],
        ],
      ),
    );
  }
}
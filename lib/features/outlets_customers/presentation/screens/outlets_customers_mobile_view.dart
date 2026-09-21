import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../controllers/outlets_customers_controller.dart';
import '../widgets/outlet_list.dart';
import '../widgets/outlet_search_field.dart';
import '../widgets/outlet_status_filter_chips.dart';
import '../widgets/outlets_customers_header.dart';

class OutletsCustomersMobileView extends ConsumerWidget {
  const OutletsCustomersMobileView({super.key});

  static const _filterOptions = [
    AppStrings.filterAll,
    AppStrings.filterActive,
    AppStrings.filterNew,
    AppStrings.filterPotential,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(outletsCustomersControllerProvider);
    final controller = ref.read(outletsCustomersControllerProvider.notifier);

    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Column(
          children: [
            OutletsCustomersHeader(
              onAddTap: () {
                // TODO: wire to context.push(RouteNames.addOutlet)
              },
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
                    options: _filterOptions,
                    selected: state.selectedFilter,
                    onSelected: controller.selectFilter,
                  ),
                ],
              ),
            ),
            Expanded(
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
                      // TODO: wire to context.push(RouteNames.outletDetail,
                      // extra: outlet) once an outlet detail screen exists.
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
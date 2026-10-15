import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/utility/custom_bottom_sheet.dart';
import '../../../../core/widgets/utility/custom_refresh_wrapper.dart';
import '../../../../core/widgets/utility/custom_snackbar.dart';
import '../../../../core/widgets/utility/error_state.dart';
import 'package:salesysx/features/outlets_customers/presentation/widgets/add_outlet_sheet.dart';
import '../controllers/new_sale_entry_controller.dart';
import '../widgets/calculated_price_summary.dart';
import '../widgets/category_filter_chips.dart';
import '../widgets/discount_input_field.dart';
import '../widgets/new_sale_entry_header.dart';
import '../widgets/outlet_picker_sheet.dart';
import '../widgets/outlet_selector_field.dart';
import '../widgets/product_picker_sheet.dart';
import '../widgets/product_selector_field.dart';
import '../widgets/quantity_stepper_field.dart';
import '../widgets/submit_sale_entry_button.dart';
import '../widgets/todays_entries_section.dart';

class NewSaleEntryTabView extends ConsumerWidget {
  const NewSaleEntryTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(newSaleEntryControllerProvider);
    final controller = ref.read(newSaleEntryControllerProvider.notifier);
    final isFirstLoad = state.isLoading && state.outlets.isEmpty && state.products.isEmpty;

    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Column(
          children: [
            NewSaleEntryHeader(
              onBack: () => context.pop(),
              onHelpTap: () => CustomBottomSheet.show<void>(
                context,
                child: Text(AppStrings.saleEntryHelpText),
              ),
            ),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: isFirstLoad
                      ? const SizedBox.shrink()
                      : state.errorMessage != null && state.outlets.isEmpty
                          ? ErrorState(message: state.errorMessage!, onRetry: controller.refresh)
                          : CustomRefreshWrapper(
                              onRefresh: controller.refresh,
                              child: ListView(
                                padding: EdgeInsets.all(AppSizes.md),
                                children: [
                                  OutletSelectorField(
                                    outletName: state.outletName,
                                    onTap: () => CustomBottomSheet.show<void>(
                                      context,
                                      child: OutletPickerSheet(
                                        outlets: state.outlets,
                                        onSelected: controller.selectOutlet,
                                        onAddNew: () => CustomBottomSheet.show<void>(
                                          context,
                                          child: AddOutletSheet(onCreated: controller.addNewOutlet),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: AppSizes.md),
                                  CategoryFilterChips(
                                    categories: state.categories,
                                    selected: state.selectedCategory,
                                    onSelected: controller.selectCategory,
                                  ),
                                  SizedBox(height: AppSizes.md),
                                  ProductSelectorField(
                                    productName: state.productName,
                                    onTap: () => CustomBottomSheet.show<void>(
                                      context,
                                      child: ProductPickerSheet(
                                        products: state.filteredProducts,
                                        onSelected: controller.selectProduct,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: AppSizes.md),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: QuantityStepperField(
                                          quantity: state.quantity,
                                          onIncrement: controller.incrementQuantity,
                                          onDecrement: controller.decrementQuantity,
                                        ),
                                      ),
                                      SizedBox(width: AppSizes.sm),
                                      Expanded(
                                        child: DiscountInputField(
                                          controller: controller.discountController,
                                          onChanged: (value) {
                                            controller.setDiscount(
                                              double.tryParse(value) ?? 0,
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: AppSizes.md),
                                  CalculatedPriceSummary(
                                    quantity: state.quantity,
                                    unitPrice: state.unitPrice,
                                    discount: state.discount,
                                    total: state.calculatedPrice,
                                  ),
                                  SizedBox(height: AppSizes.md),
                                  SubmitSaleEntryButton(
                                    onPressed: () async {
                                      final success = await controller.submitSaleEntry();
                                      if (!context.mounted) return;
                                      if (success) {
                                        CustomSnackBar.show(context, AppStrings.saleRecordedSuccess);
                                      } else {
                                        final latest = ref.read(newSaleEntryControllerProvider);
                                        if (latest.errorMessage != null) {
                                          CustomSnackBar.show(context, latest.errorMessage!, error: true);
                                        }
                                      }
                                    },
                                  ),
                                  SizedBox(height: AppSizes.lg),
                                  TodaysEntriesSection(entries: state.todaysEntries),
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
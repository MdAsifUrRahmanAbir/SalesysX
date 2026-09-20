import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../controllers/new_sale_entry_controller.dart';
import '../widgets/calculated_price_summary.dart';
import '../widgets/category_filter_chips.dart';
import '../widgets/discount_input_field.dart';
import '../widgets/new_sale_entry_header.dart';
import '../widgets/outlet_selector_field.dart';
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

    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Column(
          children: [
            NewSaleEntryHeader(
              onBack: () {
                // TODO: wire to context.pop()
              },
              onHelpTap: () {
                // TODO: wire to a help/how-it-works sheet
              },
            ),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: ListView(
                    padding: EdgeInsets.all(AppSizes.md),
                    children: [
                      OutletSelectorField(
                        outletName: state.outletName,
                        onTap: () {
                          // TODO: wire to an outlet picker bottom sheet
                        },
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
                        onTap: () {
                          // TODO: wire to a product picker bottom sheet
                        },
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
                        onPressed: () {
                          // TODO: wire to controller.submitSaleEntry()
                          // then a success snackbar + list refresh, once
                          // the repository layer is ready.
                        },
                      ),
                      SizedBox(height: AppSizes.lg),
                      TodaysEntriesSection(entries: state.todaysEntries),
                    ],
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
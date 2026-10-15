import 'package:flutter/material.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/common/custom_list_tile.dart';
import '../../../../core/widgets/utility/empty_state.dart';
import '../../data/models/product_model.dart';

/// Bottom-sheet list of active products, already filtered to the
/// selected category by the caller.
class ProductPickerSheet extends StatelessWidget {
  const ProductPickerSheet({super.key, required this.products, required this.onSelected});

  final List<ProductModel> products;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.selectProduct, style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: AppSizes.sm),
        if (products.isEmpty)
          const EmptyState(title: 'No products in this category')
        else
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 420),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return CustomListTile(
                  title: product.name,
                  subtitle: CurrencyFormatter.format(product.unitPrice),
                  onTap: () {
                    onSelected(product.id);
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'package:salesysx/features/common_models/outlet_model.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/common/custom_list_tile.dart';
import '../../../../core/widgets/utility/empty_state.dart';

/// Bottom-sheet list of the signed-in salesman's assigned outlets, plus
/// a shortcut to add a brand-new one on the spot (the "freedom feature").
class OutletPickerSheet extends StatelessWidget {
  const OutletPickerSheet({
    super.key,
    required this.outlets,
    required this.onSelected,
    required this.onAddNew,
  });

  final List<OutletModel> outlets;
  final ValueChanged<String> onSelected;
  final VoidCallback onAddNew;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.selectOutlet, style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: AppSizes.sm),
        CustomListTile(
          title: AppStrings.addNewOutletOption,
          leading: const Icon(Icons.add_circle_outline_rounded, color: AppColors.primary),
          onTap: () {
            Navigator.of(context).pop();
            onAddNew();
          },
        ),
        SizedBox(height: AppSizes.xs),
        if (outlets.isEmpty)
          const EmptyState(title: 'No outlets assigned yet')
        else
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 360),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: outlets.length,
              itemBuilder: (context, index) {
                final outlet = outlets[index];
                return CustomListTile(
                  title: outlet.name,
                  subtitle: outlet.areaRoute,
                  onTap: () {
                    onSelected(outlet.id);
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

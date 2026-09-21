import 'package:flutter/material.dart';

import '../../../../core/constants/app_sizes.dart';
import '../states/outlets_customers_state.dart';
import 'outlet_card.dart';

/// Vertical list of [OutletCard]s built from the filtered outlet list.
class OutletList extends StatelessWidget {
  const OutletList({
    super.key,
    required this.outlets,
    this.onOutletTap,
  });

  final List<OutletCustomer> outlets;
  final ValueChanged<OutletCustomer>? onOutletTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final outlet in outlets) ...[
          OutletCard(
            outlet: outlet,
            onTap: onOutletTap == null ? null : () => onOutletTap!(outlet),
          ),
          SizedBox(height: AppSizes.sm),
        ],
      ],
    );
  }
}
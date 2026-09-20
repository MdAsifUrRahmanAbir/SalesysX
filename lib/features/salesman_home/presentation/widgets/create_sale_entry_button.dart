import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/core_widgets.dart';

/// Full-width CTA for starting a new sale entry from the salesman
/// dashboard. Thin wrapper over [PrimaryButton] so icon + label + elevated
/// teal styling stays consistent with the design system.
class CreateSaleEntryButton extends StatelessWidget {
  const CreateSaleEntryButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      label: AppStrings.createNewSaleEntry,
      icon: Icons.add_rounded,
      onPressed: onPressed,
    );
  }
}
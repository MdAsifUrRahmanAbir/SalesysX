import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/core_widgets.dart';

/// Full-width submit CTA for the New Sale Entry form.
class SubmitSaleEntryButton extends StatelessWidget {
  const SubmitSaleEntryButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      label: AppStrings.submitSaleEntry,
      onPressed: onPressed,
    );
  }
}
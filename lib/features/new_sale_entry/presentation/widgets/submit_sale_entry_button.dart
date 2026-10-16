import 'package:flutter/material.dart';

import '../../../../core/widgets/core_widgets.dart';
import 'package:salesysx/core/locale/app_localizations_x.dart';

/// Full-width submit CTA for the New Sale Entry form.
class SubmitSaleEntryButton extends StatelessWidget {
  const SubmitSaleEntryButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      label: context.l10n.submitSaleEntry,
      onPressed: onPressed,
    );
  }
}
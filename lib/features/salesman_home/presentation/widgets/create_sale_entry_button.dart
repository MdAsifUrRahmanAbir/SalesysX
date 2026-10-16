import 'package:flutter/material.dart';

import '../../../../core/widgets/core_widgets.dart';
import 'package:salesysx/core/locale/app_localizations_x.dart';

/// Full-width CTA for starting a new sale entry from the salesman
/// dashboard. Thin wrapper over [PrimaryButton] so icon + label + elevated
/// teal styling stays consistent with the design system.
class CreateSaleEntryButton extends StatelessWidget {
  const CreateSaleEntryButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      label: context.l10n.createNewSaleEntry,
      icon: Icons.add_rounded,
      onPressed: onPressed,
    );
  }
}
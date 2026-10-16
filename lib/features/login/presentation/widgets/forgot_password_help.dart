import 'package:flutter/material.dart';

import 'package:salesysx/core/locale/app_localizations_x.dart';

/// Sales App passwords are set by the company admin, so "Forgot
/// password?" explains who can reset it instead of sending an email.
Future<void> showForgotPasswordHelp(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(context.l10n.forgotPassword),
      content: Text(context.l10n.forgotPasswordHelp),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: Text(MaterialLocalizations.of(dialogContext).okButtonLabel),
        ),
      ],
    ),
  );
}

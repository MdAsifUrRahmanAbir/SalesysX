
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'custom_alert_dialog.dart';
import 'package:salesysx/core/locale/app_localizations_x.dart';

/// Wraps [child] with an exit-confirmation flow on the system back
/// gesture/button. Intercepts the pop, shows a confirm dialog via
/// [CustomAlertDialog], and only closes the app if the user confirms.
///
/// Intended for root-level screens (e.g. MainShell) where the default
/// back navigation has nothing left to pop and would otherwise exit
/// the app immediately with no warning.
class AppExitAlert extends StatelessWidget {
  final Widget child;
  final String? title;
  final String? message;
  final String? confirmText;
  final String? cancelText;

  const AppExitAlert({
    super.key,
    required this.child,
    this.title,
    this.message,
    this.confirmText,
    this.cancelText,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final confirmed = await CustomAlertDialog.confirm(
          context,
          title: title ?? context.l10n.exitAppTitle,
          message: message ?? context.l10n.exitAppMessage,
          confirmText: confirmText ?? context.l10n.exitAppConfirm,
          cancelText: cancelText ?? context.l10n.exitAppCancel,
          destructive: true,
        );
        if (confirmed == true) {
          SystemNavigator.pop();
        }
      },
      child: child,
    );
  }
}
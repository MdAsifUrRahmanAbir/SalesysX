import 'package:flutter/widgets.dart';

import '../../l10n/app_localizations.dart';

/// Shorthand for `AppLocalizations.of(context)!` — every screen/widget
/// reads translated strings via `context.l10n.xxx` instead of the
/// longer generated-class call.
extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

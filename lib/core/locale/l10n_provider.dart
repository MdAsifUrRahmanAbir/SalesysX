import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../../l10n/app_localizations_bn.dart';
import '../../l10n/app_localizations_en.dart';
import '../../l10n/app_localizations_hi.dart';
import '../../l10n/app_localizations_ur.dart';
import 'locale_controller.dart';

/// Resolves the generated per-locale [AppLocalizations] instance for
/// code with no [BuildContext] to call `AppLocalizations.of(context)`
/// with — Riverpod controllers and repositories (form validators,
/// thrown failure messages, computed state fields).
final l10nProvider = Provider<AppLocalizations>((ref) {
  final locale = ref.watch(localeControllerProvider);
  return switch (locale.languageCode) {
    'bn' => AppLocalizationsBn(),
    'hi' => AppLocalizationsHi(),
    'ur' => AppLocalizationsUr(),
    _ => AppLocalizationsEn(),
  };
});

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Every language the app ships UI translations for. English is the
/// primary/default language; the other three are Bangladesh's common
/// regional languages.
const supportedLocales = [
  Locale('en'),
  Locale('bn'),
  Locale('hi'),
  Locale('ur'),
];

const _localeNames = {
  'en': 'English',
  'bn': 'বাংলা',
  'hi': 'हिन्दी',
  'ur': 'اردو',
};

String localeDisplayName(Locale locale) => _localeNames[locale.languageCode] ?? locale.languageCode;

/// Persists the chosen UI language independently of the session/auth
/// storage — a language choice is a device preference, not account data,
/// so it must survive logout (unlike [SecureStorageService]'s tokens or
/// [LocalCacheService]'s `clearOnLogout`-wiped standard box).
class LocaleController extends Notifier<Locale> {
  static const _boxName = 'app_settings';
  static const _key = 'locale_code';

  @override
  Locale build() {
    Future.microtask(_restore);
    return const Locale('en');
  }

  Future<void> _restore() async {
    final box = await Hive.openBox(_boxName);
    final code = box.get(_key) as String?;
    if (code != null && code != state.languageCode) {
      state = Locale(code);
    }
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    final box = await Hive.openBox(_boxName);
    await box.put(_key, locale.languageCode);
  }
}

final localeControllerProvider = NotifierProvider<LocaleController, Locale>(LocaleController.new);

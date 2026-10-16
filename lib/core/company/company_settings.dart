import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../network/firebase_client.dart';
import '../utils/working_days.dart';

/// Company used when a profile carries no `companyId` — same default as
/// the Admin Panel.
const defaultCompanyId = 'company_demo';

/// The business rules the Admin Panel sets in `companies/{companyId}`
/// that change how the Sales App behaves.
class CompanySettings {
  /// `DateTime.weekday` values that are not working days.
  final List<int> weekendDays;

  /// Whether a salesman may change a product's unit price on a sale.
  final bool allowPriceEdit;

  const CompanySettings({this.weekendDays = const [DateTime.friday], this.allowPriceEdit = false});

  factory CompanySettings.fromMap(Map<String, dynamic> map) {
    final days = [
      for (final d in map['weekendDays'] as List<dynamic>? ?? const [])
        if (d is num && d >= 1 && d <= 7) d.toInt(),
    ];
    return CompanySettings(
      weekendDays: days.isEmpty ? const [DateTime.friday] : days,
      allowPriceEdit: map['allowPriceEdit'] as bool? ?? false,
    );
  }
}

class CompanySettingsController extends Notifier<CompanySettings> {
  @override
  CompanySettings build() => const CompanySettings();

  Future<void> load(String? companyId) async {
    final id = (companyId == null || companyId.isEmpty) ? defaultCompanyId : companyId;
    final data = await ref.read(firebaseClientProvider).getDocument('companies/$id');
    final settings = data == null ? const CompanySettings() : CompanySettings.fromMap(data);
    WorkingDays.weekendDays = settings.weekendDays;
    state = settings;
  }
}

final companySettingsProvider = NotifierProvider<CompanySettingsController, CompanySettings>(CompanySettingsController.new);

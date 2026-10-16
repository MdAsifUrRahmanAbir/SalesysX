import 'package:flutter_test/flutter_test.dart';
import 'package:salesysx/core/company/company_settings.dart';
import 'package:salesysx/core/constants/user_role.dart';
import 'package:salesysx/core/utils/working_days.dart';
import 'package:salesysx/features/common_models/outlet_model.dart';
import 'package:salesysx/features/common_models/sale_model.dart';
import 'package:salesysx/features/new_sale_entry/data/models/product_model.dart';
import 'package:salesysx/features/new_sale_entry/presentation/states/new_sale_entry_state.dart';
import 'package:salesysx/features/notifications/data/models/notification_model.dart';

Map<String, dynamic> _sale(String id, {String? status, double amount = 100}) => {
  'id': id,
  'salesmanEmail': 'rahim@x.com',
  'amount': amount,
  'quantity': 1,
  'date': '2026-10-10T10:00:00',
  'status': ?status,
};

void main() {
  group('UserRole', () {
    test('panel roles are recognised so the Sales App can reject them', () {
      for (final wire in ['SUPER_ADMIN', 'ADMIN', 'OWNER', 'MANAGER']) {
        expect(UserRoleParsing.fromString(wire).isPanelRole, isTrue, reason: wire);
      }
      expect(UserRoleParsing.fromString('TEAM_HEAD').isPanelRole, isFalse);
      expect(UserRoleParsing.fromString('SALESMAN').isPanelRole, isFalse);
    });
  });

  group('sales', () {
    test('cancelled sales never count; a missing status means completed', () {
      final sales = SaleModel.completedFrom([
        _sale('a'),
        _sale('b', status: 'COMPLETED'),
        _sale('c', status: 'CANCELLED', amount: 999),
        _sale('d', status: 'cancelled'),
      ]);
      expect(sales.map((s) => s.id), ['a', 'b']);
      expect(sales.fold<double>(0, (t, s) => t + s.amount), 200);
    });
  });

  group('products', () {
    test('a product is sellable only when both status and active allow it', () {
      ProductModel p(Map<String, dynamic> extra) =>
          ProductModel.fromMap({'id': 'x', 'name': 'Rice', 'unitPrice': 10, ...extra});
      expect(p({}).active, isTrue);
      expect(p({'active': true, 'status': 'active'}).active, isTrue);
      expect(p({'active': true, 'status': 'inactive'}).active, isFalse);
      expect(p({'active': false}).active, isFalse);
    });
  });

  group('notifications', () {
    test('read state is per user, including broadcasts', () {
      final broadcast = {'id': 'n1', 'targetEmail': 'all', 'readBy': ['karim@x.com'], 'createdAt': '2026-10-10T10:00:00'};
      expect(NotificationModel.fromMap(broadcast, viewer: 'karim@x.com').isRead, isTrue);
      expect(NotificationModel.fromMap(broadcast, viewer: 'rahim@x.com').isRead, isFalse);

      final legacyPersonal = {'id': 'n2', 'targetEmail': 'rahim@x.com', 'isRead': true, 'createdAt': '2026-10-10T10:00:00'};
      expect(NotificationModel.fromMap(legacyPersonal, viewer: 'rahim@x.com').isRead, isTrue);
    });
  });

  group('company settings', () {
    tearDown(() => WorkingDays.weekendDays = const [DateTime.friday]);

    test('weekly holiday drives working-day counts', () {
      // 1–7 Oct 2026: Thu..Wed, one Friday and one Saturday.
      final start = DateTime(2026, 10, 1);
      final end = DateTime(2026, 10, 7);
      expect(WorkingDays.count(start, end), 6);

      WorkingDays.weekendDays = CompanySettings.fromMap({'weekendDays': [5, 6]}).weekendDays;
      expect(WorkingDays.count(start, end), 5);
    });

    test('bad weekend data falls back to Friday', () {
      expect(CompanySettings.fromMap({'weekendDays': [0, 9]}).weekendDays, [DateTime.friday]);
      expect(CompanySettings.fromMap({}).allowPriceEdit, isFalse);
    });
  });

  group('sale entry pricing', () {
    const product = ProductModel(id: 'p', name: 'Rice', category: 'Grocery', unitPrice: 1600);
    const outlet = OutletModel(id: 'o', name: 'Shop', ownerName: '', phone: '', address: '', areaRoute: '', status: 'active', assignedSalesmanEmail: 'rahim@x.com', teamId: 't', lastOrderAmount: 0);

    test('price override applies only when the company allows it', () {
      const base = NewSaleEntryState(products: [product], selectedProductId: 'p', outlets: [outlet], quantity: 2, discount: 100);
      expect(base.calculatedPrice, 3100);
      expect(base.copyWith(priceOverride: 1500).unitPrice, 1600);
      final editable = base.copyWith(allowPriceEdit: true, priceOverride: 1500);
      expect(editable.unitPrice, 1500);
      expect(editable.calculatedPrice, 2900);
      expect(editable.copyWith(clearPriceOverride: true).unitPrice, 1600);
    });

    test('total never goes negative', () {
      const s = NewSaleEntryState(products: [product], selectedProductId: 'p', discount: 99999);
      expect(s.calculatedPrice, 0);
    });
  });
}

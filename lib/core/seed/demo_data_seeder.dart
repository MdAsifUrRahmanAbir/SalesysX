import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/firestore_collections.dart';
import '../network/firebase_client.dart';
import '../utils/password_hasher.dart';

final demoDataSeederProvider = Provider<DemoDataSeeder>((ref) {
  return DemoDataSeeder(ref.watch(firebaseClientProvider));
});

/// Seeds Firestore with a small realistic demo dataset — one Team Head,
/// two Salesmen, outlets, this month's targets, a week of sales, and a
/// couple of notifications — the first time the app runs against an
/// empty database. Safe to call on every launch: it checks whether
/// `users` already has data and no-ops if so.
///
/// Caveat: the "is it empty" check isn't atomic, so two fresh installs
/// racing at the exact same instant could double-seed. Fine for demo
/// data; not something to rely on for real provisioning later.
class DemoDataSeeder {
  final FirebaseClient _client;
  DemoDataSeeder(this._client);

  static const demoPassword = '12345678';

  static const _teamId = 'team_dhaka_01';
  static const _companyId = 'company_demo';
  static const teamHeadEmail = 'head@salesysx.demo';
  static const salesman1Email = 'karim@salesysx.demo';
  static const salesman2Email = 'rahim@salesysx.demo';

  Future<void> seedIfNeeded() async {
    final existing = await _client.getCollection(FirestoreCollections.users, limit: 1);
    if (existing.isNotEmpty) return;

    final passwordHash = PasswordHasher.hash(demoPassword);
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);
    final monthEnd = DateTime(now.year, now.month + 1, 0);
    final monthKey = '${now.year}-${now.month.toString().padLeft(2, '0')}';

    await _seedUsers(passwordHash);
    await _seedTeam();
    final outletIds = await _seedOutlets();
    await _seedTargets(monthKey, monthStart, monthEnd);
    await _seedSales(now, outletIds);
    await _seedNotifications(now, monthKey);
  }

  Future<void> _seedUsers(String passwordHash) async {
    final users = [
      {
        'email': teamHeadEmail,
        'name': 'Nusrat Jahan',
        'phone': '01710000001',
        'employeeId': 'EMP-1001',
        'role': 'TEAM_HEAD',
      },
      {
        'email': salesman1Email,
        'name': 'Abdul Karim',
        'phone': '01710000002',
        'employeeId': 'EMP-1002',
        'role': 'SALESMAN',
      },
      {
        'email': salesman2Email,
        'name': 'Abdur Rahim',
        'phone': '01710000003',
        'employeeId': 'EMP-1003',
        'role': 'SALESMAN',
      },
    ];

    for (final u in users) {
      await _client.setDocument(FirestoreCollections.userDoc(u['email']!), {
        'name': u['name'],
        'email': u['email'],
        'passwordHash': passwordHash,
        'phone': u['phone'],
        'employeeId': u['employeeId'],
        'role': u['role'],
        'teamId': _teamId,
        'companyId': _companyId,
        'status': 'active',
        'photoUrl': null,
      });
    }
  }

  Future<void> _seedTeam() async {
    await _client.setDocument(FirestoreCollections.teamDoc(_teamId), {
      'name': 'Dhaka Team A',
      'teamHeadEmail': teamHeadEmail,
      'companyId': _companyId,
      'memberEmails': [salesman1Email, salesman2Email],
    });
  }

  Future<List<String>> _seedOutlets() async {
    final outlets = [
      {'name': 'Rahman General Store', 'ownerName': 'Mizanur Rahman', 'phone': '01810000001', 'address': 'Mirpur-10, Dhaka', 'areaRoute': 'Mirpur Route', 'status': 'active', 'assignedSalesmanEmail': salesman1Email},
      {'name': 'City Mart', 'ownerName': 'Shahin Alam', 'phone': '01810000002', 'address': 'Dhanmondi, Dhaka', 'areaRoute': 'Dhanmondi Route', 'status': 'active', 'assignedSalesmanEmail': salesman1Email},
      {'name': 'New Star Traders', 'ownerName': 'Jamal Uddin', 'phone': '01810000003', 'address': 'Mohammadpur, Dhaka', 'areaRoute': 'Mohammadpur Route', 'status': 'newCustomer', 'assignedSalesmanEmail': salesman1Email},
      {'name': 'Green Valley Shop', 'ownerName': 'Farida Begum', 'phone': '01810000004', 'address': 'Uttara, Dhaka', 'areaRoute': 'Uttara Route', 'status': 'active', 'assignedSalesmanEmail': salesman2Email},
      {'name': 'Prime Grocery', 'ownerName': 'Sohel Rana', 'phone': '01810000005', 'address': 'Badda, Dhaka', 'areaRoute': 'Badda Route', 'status': 'potential', 'assignedSalesmanEmail': salesman2Email},
    ];

    final ids = <String>[];
    for (final outlet in outlets) {
      final id = await _client.addDocument(FirestoreCollections.outlets, {
        ...outlet,
        'teamId': _teamId,
        'lastVisit': null,
        'lastOrderAmount': 0,
      });
      ids.add(id);
    }
    return ids;
  }

  Future<void> _seedTargets(String monthKey, DateTime start, DateTime end) async {
    final workingDays = _countWorkingDays(start, end); // excludes Fridays

    await _client.addDocument(FirestoreCollections.targets, {
      'salesmanEmail': salesman1Email,
      'teamId': _teamId,
      'month': monthKey,
      'targetAmount': 150000,
      'startDate': start.toIso8601String(),
      'endDate': end.toIso8601String(),
      'workingDays': workingDays,
    });

    await _client.addDocument(FirestoreCollections.targets, {
      'salesmanEmail': salesman2Email,
      'teamId': _teamId,
      'month': monthKey,
      'targetAmount': 120000,
      'startDate': start.toIso8601String(),
      'endDate': end.toIso8601String(),
      'workingDays': workingDays,
    });
  }

  Future<void> _seedSales(DateTime now, List<String> outletIds) async {
    final products = [
      {'name': 'Cooking Oil 5L', 'category': 'Grocery', 'unitPrice': 850.0},
      {'name': 'Rice 25kg', 'category': 'Grocery', 'unitPrice': 1600.0},
      {'name': 'Detergent Powder 1kg', 'category': 'Household', 'unitPrice': 220.0},
      {'name': 'Biscuit Carton', 'category': 'Snacks', 'unitPrice': 480.0},
      {'name': 'Soft Drink Case', 'category': 'Beverage', 'unitPrice': 650.0},
    ];
    final salesmen = [salesman1Email, salesman2Email];
    var outletCursor = 0;

    for (var dayOffset = 0; dayOffset < 6; dayOffset++) {
      final date = now.subtract(Duration(days: dayOffset));
      for (final salesmanEmail in salesmen) {
        final product = products[(dayOffset + salesmen.indexOf(salesmanEmail)) % products.length];
        final outletId = outletIds[outletCursor % outletIds.length];
        outletCursor++;

        final quantity = 2 + (dayOffset % 3);
        final unitPrice = product['unitPrice'] as double;
        final discount = dayOffset == 0 ? 0.0 : 50.0;

        await _client.addDocument(FirestoreCollections.sales, {
          'salesmanEmail': salesmanEmail,
          'teamId': _teamId,
          'outletId': outletId,
          'productName': product['name'],
          'category': product['category'],
          'quantity': quantity,
          'unitPrice': unitPrice,
          'discount': discount,
          'amount': (quantity * unitPrice) - discount,
          'date': date.toIso8601String(),
        });
      }
    }
  }

  Future<void> _seedNotifications(DateTime now, String monthKey) async {
    await _client.addDocument(FirestoreCollections.notifications, {
      'title': 'Welcome to SalesysX',
      'message': 'Your account has been set up. Start logging your sales today.',
      'type': 'info',
      'targetEmail': 'all',
      'isRead': false,
      'createdAt': now.toIso8601String(),
    });

    await _client.addDocument(FirestoreCollections.notifications, {
      'title': 'Monthly target published',
      'message': 'Your target for $monthKey has been set. Check the Target tab for details.',
      'type': 'target',
      'targetEmail': salesman1Email,
      'isRead': false,
      'createdAt': now.toIso8601String(),
    });
  }

  /// Counts days excluding Friday (Bangladesh's standard weekly holiday).
  /// Flagging this assumption — if your company's weekend is
  /// Friday+Saturday, exclude `DateTime.saturday` too.
  int _countWorkingDays(DateTime start, DateTime end) {
    var count = 0;
    for (var d = start; !d.isAfter(end); d = d.add(const Duration(days: 1))) {
      if (d.weekday != DateTime.friday) count++;
    }
    return count;
  }
}
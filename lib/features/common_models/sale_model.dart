class SaleModel {
  final String id;
  final String salesmanEmail;
  final String teamId;
  final String outletId;
  final String productName;
  final String category;
  final int quantity;
  final double unitPrice;
  final double discount;
  final double amount;
  final DateTime date;

  /// COMPLETED or CANCELLED (set from the Admin Panel). Older records
  /// without a status are completed.
  final String status;

  const SaleModel({
    required this.id,
    required this.salesmanEmail,
    required this.teamId,
    required this.outletId,
    required this.productName,
    required this.category,
    required this.quantity,
    required this.unitPrice,
    required this.discount,
    required this.amount,
    required this.date,
    this.status = 'COMPLETED',
  });

  bool get isCancelled => status == 'CANCELLED';

  /// Maps query results, leaving out cancelled sales — they must never
  /// count toward totals, targets or rankings.
  static List<SaleModel> completedFrom(List<Map<String, dynamic>> docs) =>
      [for (final d in docs) SaleModel.fromMap(d)].where((s) => !s.isCancelled).toList();

  factory SaleModel.fromMap(Map<String, dynamic> map) {
    return SaleModel(
      id: map['id'] as String,
      salesmanEmail: map['salesmanEmail'] as String? ?? '',
      teamId: map['teamId'] as String? ?? '',
      outletId: map['outletId'] as String? ?? '',
      productName: map['productName'] as String? ?? '',
      category: map['category'] as String? ?? '',
      quantity: (map['quantity'] as num?)?.toInt() ?? 0,
      unitPrice: (map['unitPrice'] as num?)?.toDouble() ?? 0,
      discount: (map['discount'] as num?)?.toDouble() ?? 0,
      amount: (map['amount'] as num?)?.toDouble() ?? 0,
      date: DateTime.tryParse(map['date'] as String? ?? '') ?? DateTime.now(),
      status: (map['status'] as String? ?? 'COMPLETED').toUpperCase(),
    );
  }

  Map<String, dynamic> toMap() => {
    'salesmanEmail': salesmanEmail,
    'teamId': teamId,
    'outletId': outletId,
    'productName': productName,
    'category': category,
    'quantity': quantity,
    'unitPrice': unitPrice,
    'discount': discount,
    'amount': amount,
    'date': date.toIso8601String(),
    'status': status,
  };
}
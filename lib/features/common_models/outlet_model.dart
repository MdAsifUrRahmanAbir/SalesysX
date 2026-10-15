class OutletModel {
  final String id;
  final String name;
  final String ownerName;
  final String phone;
  final String address;
  final String areaRoute;
  final String status; // 'active' | 'newCustomer' | 'potential'
  final String assignedSalesmanEmail;
  final String teamId;
  final DateTime? lastVisit;
  final double lastOrderAmount;

  const OutletModel({
    required this.id,
    required this.name,
    required this.ownerName,
    required this.phone,
    required this.address,
    required this.areaRoute,
    required this.status,
    required this.assignedSalesmanEmail,
    required this.teamId,
    this.lastVisit,
    required this.lastOrderAmount,
  });

  factory OutletModel.fromMap(Map<String, dynamic> map) {
    return OutletModel(
      id: map['id'] as String,
      name: map['name'] as String? ?? '',
      ownerName: map['ownerName'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      address: map['address'] as String? ?? '',
      areaRoute: map['areaRoute'] as String? ?? '',
      status: map['status'] as String? ?? 'active',
      assignedSalesmanEmail: map['assignedSalesmanEmail'] as String? ?? '',
      teamId: map['teamId'] as String? ?? '',
      lastVisit: map['lastVisit'] == null ? null : DateTime.tryParse(map['lastVisit'] as String),
      lastOrderAmount: (map['lastOrderAmount'] as num?)?.toDouble() ?? 0,
    );
  }
}

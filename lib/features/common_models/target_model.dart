class TargetModel {
  final String id;
  final String salesmanEmail;
  final String teamId;
  final String month; // 'YYYY-MM'
  final double targetAmount;
  final DateTime startDate;
  final DateTime endDate;
  final int workingDays;

  const TargetModel({
    required this.id,
    required this.salesmanEmail,
    required this.teamId,
    required this.month,
    required this.targetAmount,
    required this.startDate,
    required this.endDate,
    required this.workingDays,
  });

  factory TargetModel.fromMap(Map<String, dynamic> map) {
    return TargetModel(
      id: map['id'] as String,
      salesmanEmail: map['salesmanEmail'] as String? ?? '',
      teamId: map['teamId'] as String? ?? '',
      month: map['month'] as String? ?? '',
      targetAmount: (map['targetAmount'] as num?)?.toDouble() ?? 0,
      startDate: DateTime.tryParse(map['startDate'] as String? ?? '') ?? DateTime.now(),
      endDate: DateTime.tryParse(map['endDate'] as String? ?? '') ?? DateTime.now(),
      workingDays: (map['workingDays'] as num?)?.toInt() ?? 0,
    );
  }
}
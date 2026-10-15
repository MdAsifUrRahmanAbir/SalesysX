enum NotificationType { target, targetRisk, lowSales, milestone, dailyReminder, info }

extension NotificationTypeParsing on NotificationType {
  static NotificationType fromString(String? value) {
    switch ((value ?? '').trim().toUpperCase()) {
      case 'TARGET':
        return NotificationType.target;
      case 'TARGET_RISK':
        return NotificationType.targetRisk;
      case 'LOW_SALES':
        return NotificationType.lowSales;
      case 'MILESTONE':
        return NotificationType.milestone;
      case 'DAILY_REMINDER':
        return NotificationType.dailyReminder;
      case 'INFO':
      default:
        return NotificationType.info;
    }
  }
}

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final String targetEmail;
  final bool isRead;
  final DateTime createdAt;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.targetEmail,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as String,
      title: map['title'] as String? ?? '',
      message: map['message'] as String? ?? '',
      type: NotificationTypeParsing.fromString(map['type'] as String?),
      targetEmail: map['targetEmail'] as String? ?? 'all',
      isRead: map['isRead'] as bool? ?? false,
      createdAt: DateTime.tryParse(map['createdAt'] as String? ?? '') ?? DateTime.now(),
    );
  }

  NotificationModel copyWith({bool? isRead}) {
    return NotificationModel(
      id: id,
      title: title,
      message: message,
      type: type,
      targetEmail: targetEmail,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt,
    );
  }
}

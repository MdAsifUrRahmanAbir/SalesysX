import '../../data/models/notification_model.dart';

class NotificationsState {
  final String selectedFilter;
  final bool isNotificationsLoading;
  final String? errorMessage;
  final List<NotificationModel> items;

  const NotificationsState({
    this.selectedFilter = 'all',
    this.isNotificationsLoading = false,
    this.errorMessage,
    this.items = const [],
  });

  List<NotificationModel> get filteredItems =>
      selectedFilter == 'unread' ? items.where((n) => !n.isRead).toList() : items;

  int get unreadCount => items.where((n) => !n.isRead).length;

  NotificationsState copyWith({
    String? selectedFilter,
    bool? isNotificationsLoading,
    String? errorMessage,
    List<NotificationModel>? items,
  }) {
    return NotificationsState(
      selectedFilter: selectedFilter ?? this.selectedFilter,
      isNotificationsLoading: isNotificationsLoading ?? this.isNotificationsLoading,
      errorMessage: errorMessage,
      items: items ?? this.items,
    );
  }
}

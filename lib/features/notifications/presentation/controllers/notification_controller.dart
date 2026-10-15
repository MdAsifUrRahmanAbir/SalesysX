import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/session/auth_session_controller.dart';
import '../../../../core/utils/error_mapper.dart';
import '../../data/repositories/notification_repository.dart';
import '../states/notifications_state.dart';

class NotificationController extends Notifier<NotificationsState> {
  NotificationRepository get _repository => ref.read(notificationRepositoryProvider);

  @override
  NotificationsState build() {
    Future.microtask(_load);
    return const NotificationsState(isNotificationsLoading: true);
  }

  Future<void> refresh() => _load();

  Future<void> _load() async {
    state = state.copyWith(isNotificationsLoading: true, errorMessage: null);
    try {
      final user = ref.read(authSessionControllerProvider).user;
      if (user == null) {
        state = state.copyWith(isNotificationsLoading: false, errorMessage: 'Not signed in.');
        return;
      }
      final items = await _repository.getForUser(user.id);
      state = state.copyWith(isNotificationsLoading: false, items: items);
    } catch (e) {
      state = state.copyWith(isNotificationsLoading: false, errorMessage: getErrorMessage(e));
    }
  }

  void selectFilter(String filter) {
    state = state.copyWith(selectedFilter: filter);
  }

  Future<void> markRead(String id) async {
    final target = state.items.where((n) => n.id == id);
    if (target.isEmpty || target.first.isRead) return;
    try {
      await _repository.markAsRead(id);
      state = state.copyWith(
        items: [for (final n in state.items) n.id == id ? n.copyWith(isRead: true) : n],
      );
    } catch (_) {
      // Best-effort — leave the item unread in local state on failure.
    }
  }

  Future<bool> markAllAsRead() async {
    final unreadIds = state.items.where((n) => !n.isRead).map((n) => n.id).toList();
    if (unreadIds.isEmpty) return true;
    try {
      await _repository.markAllAsRead(unreadIds);
      state = state.copyWith(items: [for (final n in state.items) n.copyWith(isRead: true)]);
      return true;
    } catch (_) {
      return false;
    }
  }
}

final notificationControllerProvider =
NotifierProvider.autoDispose<NotificationController, NotificationsState>(NotificationController.new);

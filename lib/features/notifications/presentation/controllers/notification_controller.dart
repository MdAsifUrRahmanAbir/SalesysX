import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/session/auth_session_controller.dart';
import '../../../../core/utils/error_mapper.dart';
import '../../data/repositories/notification_repository.dart';
import '../states/notifications_state.dart';

/// Live notifications for the signed-in user — new pushes appear (and the
/// unread badge updates) without a manual refresh.
class NotificationController extends Notifier<NotificationsState> {
  NotificationRepository get _repository => ref.read(notificationRepositoryProvider);
  StreamSubscription<dynamic>? _subscription;

  String? get _email => ref.read(authSessionControllerProvider).user?.id;

  @override
  NotificationsState build() {
    ref.onDispose(() => _subscription?.cancel());
    Future.microtask(_listen);
    return const NotificationsState(isNotificationsLoading: true);
  }

  Future<void> refresh() async => _listen();

  void _listen() {
    _subscription?.cancel();
    final email = _email;
    if (email == null) {
      state = state.copyWith(isNotificationsLoading: false, errorMessage: 'Not signed in.');
      return;
    }
    state = state.copyWith(isNotificationsLoading: state.items.isEmpty, errorMessage: null);
    _subscription = _repository.watchForUser(email).listen(
      (items) => state = state.copyWith(isNotificationsLoading: false, items: items),
      onError: (Object e) => state = state.copyWith(isNotificationsLoading: false, errorMessage: getErrorMessage(e)),
    );
  }

  void selectFilter(String filter) {
    state = state.copyWith(selectedFilter: filter);
  }

  Future<void> markRead(String id) async {
    final email = _email;
    final target = state.items.where((n) => n.id == id);
    if (email == null || target.isEmpty || target.first.isRead) return;
    try {
      await _repository.markAsRead(target.first, email);
    } catch (_) {
      // Best-effort — the live stream keeps showing it as unread.
    }
  }

  Future<bool> markAllAsRead() async {
    final email = _email;
    final unread = state.items.where((n) => !n.isRead).toList();
    if (email == null || unread.isEmpty) return true;
    try {
      await _repository.markAllAsRead(unread, email);
      return true;
    } catch (_) {
      return false;
    }
  }
}

final notificationControllerProvider =
NotifierProvider.autoDispose<NotificationController, NotificationsState>(NotificationController.new);

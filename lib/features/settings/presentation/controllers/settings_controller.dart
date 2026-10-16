import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/push/push_notification_service.dart';
import '../../../../core/session/auth_session_controller.dart';

class SettingsState {
  final bool pushNotifications;
  final bool isUpdatingPush;

  const SettingsState({this.pushNotifications = true, this.isUpdatingPush = false});

  SettingsState copyWith({bool? pushNotifications, bool? isUpdatingPush}) {
    return SettingsState(
      pushNotifications: pushNotifications ?? this.pushNotifications,
      isUpdatingPush: isUpdatingPush ?? this.isUpdatingPush,
    );
  }
}

class SettingsController extends Notifier<SettingsState> {
  PushNotificationService get _push => ref.read(pushNotificationServiceProvider);

  @override
  SettingsState build() {
    Future.microtask(_loadPushPreference);
    return const SettingsState();
  }

  Future<void> _loadPushPreference() async {
    final enabled = await _push.isEnabled();
    if (ref.mounted) state = state.copyWith(pushNotifications: enabled);
  }

  /// Turns push notifications on or off for this device. Returns false
  /// when turning on failed (e.g. the OS permission was denied).
  Future<bool> setPushNotifications(bool value) async {
    final email = ref.read(authSessionControllerProvider).user?.id;
    if (email == null || state.isUpdatingPush) return false;
    state = state.copyWith(pushNotifications: value, isUpdatingPush: true);
    try {
      final registered = await _push.setEnabled(value, email);
      if (!ref.mounted) return true;
      state = state.copyWith(isUpdatingPush: false);
      return !value || registered;
    } catch (_) {
      if (ref.mounted) state = state.copyWith(pushNotifications: !value, isUpdatingPush: false);
      return false;
    }
  }
}

final settingsControllerProvider =
    NotifierProvider.autoDispose<SettingsController, SettingsState>(
      SettingsController.new,
    );

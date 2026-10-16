import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../routes/app_router.dart';
import '../../routes/route_names.dart';
import '../session/auth_session_controller.dart';
import '../session/auth_session_state.dart';
import 'push_notification_service.dart';

/// Opens the Notifications screen when the user taps a push while the
/// app is running (taps that cold-start the app are handled by the
/// splash screen once the session is restored).
class PushOpenListener extends ConsumerStatefulWidget {
  final Widget child;
  const PushOpenListener({super.key, required this.child});

  @override
  ConsumerState<PushOpenListener> createState() => _PushOpenListenerState();
}

class _PushOpenListenerState extends ConsumerState<PushOpenListener> {
  StreamSubscription<String?>? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = ref.read(pushNotificationServiceProvider).onOpened.listen((_) {
      if (ref.read(authSessionControllerProvider).status != AuthStatus.authenticated) return;
      ref.read(routerProvider).push(RouteNames.notifications);
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

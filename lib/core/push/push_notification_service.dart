import 'dart:async';
import 'dart:io' show Platform;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../firebase_options.dart';
import '../constants/firestore_collections.dart';
import '../network/firebase_client.dart';

/// Runs in its own isolate when a push arrives while the app is in the
/// background or terminated. FCM `notification` messages are shown by the
/// system tray already, so there is nothing to do but initialize Firebase.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

final pushNotificationServiceProvider = Provider<PushNotificationService>((ref) {
  return PushNotificationService(ref.watch(firebaseClientProvider));
});

/// Firebase Cloud Messaging for the Sales App.
///
/// The Admin Panel writes a `notifications` document; the
/// `sendNotificationPush` Cloud Function sends it to every token in the
/// recipient's `users/{email}.fcmTokens`. This class keeps those tokens
/// current, shows pushes that arrive while the app is open, and reports
/// taps so the app can open the Notifications screen.
class PushNotificationService {
  final FirebaseClient _client;
  PushNotificationService(this._client);

  /// Must match `ANDROID_CHANNEL_ID` in functions/push.js.
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'salesysx_default',
    'SalesysX notifications',
    description: 'Targets, reminders and announcements from your admin',
    importance: Importance.high,
  );

  static const _prefsBox = 'push_prefs';
  static const _enabledKey = 'enabled';

  final _local = FlutterLocalNotificationsPlugin();
  final _opened = StreamController<String?>.broadcast();
  StreamSubscription<String>? _tokenRefresh;
  String? _pendingOpen;
  bool _initialized = false;

  FirebaseMessaging get _messaging => FirebaseMessaging.instance;

  bool get _supported => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  /// Emits (with the notification id, if known) when the user taps a push.
  Stream<String?> get onOpened => _opened.stream;

  /// A tap that launched the app from terminated state; read once after
  /// the session is restored.
  String? takePendingOpen() {
    final id = _pendingOpen;
    _pendingOpen = null;
    return id;
  }

  /// Call once from `main()`, after `Firebase.initializeApp`.
  Future<void> init() async {
    if (!_supported || _initialized) return;
    _initialized = true;

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    await _local.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@drawable/ic_notification'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      ),
      onDidReceiveNotificationResponse: (response) => _opened.add(response.payload),
    );
    await _local
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // iOS shows foreground pushes itself with these options; Android needs
    // a local notification (see [_showForeground]).
    await _messaging.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

    FirebaseMessaging.onMessage.listen(_showForeground);
    FirebaseMessaging.onMessageOpenedApp.listen((m) => _opened.add(m.data['notificationId'] as String?));

    final initial = await _messaging.getInitialMessage();
    if (initial != null) {
      _pendingOpen = initial.data['notificationId'] as String? ?? '';
    } else {
      final launch = await _local.getNotificationAppLaunchDetails();
      if (launch?.didNotificationLaunchApp ?? false) {
        _pendingOpen = launch!.notificationResponse?.payload ?? '';
      }
    }
  }

  Future<Box> _prefs() => Hive.openBox(_prefsBox);

  /// The per-device switch in Settings (on by default).
  Future<bool> isEnabled() async => (await _prefs()).get(_enabledKey, defaultValue: true) as bool;

  /// Turns pushes on/off for this device and (un)registers its token.
  Future<bool> setEnabled(bool enabled, String email) async {
    await (await _prefs()).put(_enabledKey, enabled);
    if (enabled) return registerFor(email);
    await unregisterFrom(email);
    return false;
  }

  /// Asks for permission (Android 13+, iOS) and stores this device's token
  /// on the user. Returns false when pushes are off or not permitted.
  Future<bool> registerFor(String email) async {
    if (!_supported || !await isEnabled()) return false;

    final settings = await _messaging.requestPermission(alert: true, badge: true, sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.denied) return false;

    if (Platform.isIOS && await _messaging.getAPNSToken() == null) {
      // The APNs token arrives shortly after permission is granted.
      await Future<void>.delayed(const Duration(seconds: 2));
      if (await _messaging.getAPNSToken() == null) return false;
    }

    final token = await _messaging.getToken();
    if (token == null) return false;
    await _addToken(email, token);

    await _tokenRefresh?.cancel();
    _tokenRefresh = _messaging.onTokenRefresh.listen((t) => _addToken(email, t).catchError((_) {}));
    return true;
  }

  /// Removes this device's token so a signed-out phone stops receiving
  /// the previous user's notifications.
  Future<void> unregisterFrom(String email) async {
    if (!_supported) return;
    await _tokenRefresh?.cancel();
    _tokenRefresh = null;
    try {
      final token = await _messaging.getToken();
      if (token != null) {
        await _client.updateDocument(FirestoreCollections.userDoc(email), {
          'fcmTokens': _client.arrayRemove([token]),
        });
      }
    } finally {
      await _messaging.deleteToken();
    }
  }

  Future<void> _addToken(String email, String token) {
    return _client.updateDocument(FirestoreCollections.userDoc(email), {
      'fcmTokens': _client.arrayUnion([token]),
    });
  }

  Future<void> _showForeground(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null || !Platform.isAndroid) return;
    try {
      await _local.show(
        id: message.messageId?.hashCode ?? DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title: notification.title,
        body: notification.body,
        payload: message.data['notificationId'] as String?,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            importance: Importance.high,
            priority: Priority.high,
            icon: '@drawable/ic_notification',
            styleInformation: BigTextStyleInformation(notification.body ?? ''),
          ),
        ),
      );
    } catch (e) {
      debugPrint('Could not show foreground push: $e');
    }
  }
}

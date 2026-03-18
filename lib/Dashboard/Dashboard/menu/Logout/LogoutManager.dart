// lib/Auth/Logout/LogoutManager.dart
import 'dart:async';

import '../../../../Push/FcmService.dart';
import '../../../../init/Manager.dart';
import 'LogoutService.dart';

class LogoutManager {
  static final LogoutManager _instance = LogoutManager._internal();
  factory LogoutManager() => _instance;
  LogoutManager._internal();

  final _service = LogoutService();

  Future<void> logout() async {
    final manager = Manager();

    String? refresh;
    try {
      refresh = await manager.helperService.getRefreshToken();
    } catch (_) {
      refresh = null;
    }

    String? fcmToken;
    try {
      fcmToken = await FcmService().getLocalToken();
    } catch (_) {
      fcmToken = null;
    }

    if (refresh != null && refresh.isNotEmpty) {
      try {
        await _service.logoutWithRefresh(
          refreshToken: refresh,
          fcmToken: fcmToken,
        );
      } catch (_) {}
    }

    try {
      await manager.helperService.clearTokens();
    } catch (_) {}

    manager.tokens = null;
    manager.currentUser = null;
    manager.lastAccountStatus = null;
    manager.attemptsMax = null;

    manager.dio.options.headers.remove('Authorization');

    unawaited(() async {
      try {
        await FcmService().clearLocalToken();
      } catch (_) {}
    }());
  }
}

// lib/Auth/Managers/LoginManager.dart
import 'dart:async';

import '../../Push/FcmService.dart';
import '../../init/Manager.dart';
import '../../init/BaseResponse.dart';
import '../Shared/AuthModels.dart';
import 'LoginService.dart';

class LoginManager {
  static final LoginManager _instance = LoginManager._internal();
  factory LoginManager() => _instance;
  LoginManager._internal();

  final _service = LoginService();

  Future<BaseResponse<LoginStep1Data>> authLogin(
      String email,
      String password,
      ) async {
    final res = await _service.authLogin(
      LoginRequest(email: email, password: password),
    );
    Manager().lastAccountStatus = res.data?.status;
    return res;
  }

  Future<BaseResponse<LoginData>> authLoginOtp(
      String email,
      String otp,
      String password,
      ) async {
    final res = await _service.authLoginOtp(
      LoginOtpRequest(email: email, otp: otp, password: password),
    );

    if (res.success && res.data != null) {
      final m = Manager();

      m.tokens = res.data!.tokens;
      m.currentUser = res.data!.user;
      m.currentSubscription = res.data!.subscription;

      unawaited(() async {
        try {
          await FcmService().init();
          await FcmService().registerToken();
        } catch (_) {}
      }());
    }

    return res;
  }

  Future<BaseResponse<StatusData>> sendPasswordResetLink(String email) {
    return _service.sendPasswordResetLink(email);
  }
}

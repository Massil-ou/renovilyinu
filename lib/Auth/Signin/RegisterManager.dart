// lib/Auth/Managers/RegisterManager.dart
import 'dart:async';

import '../../Push/FcmService.dart';
import '../../init/Manager.dart';
import '../../init/BaseResponse.dart';
import '../Shared/AuthModels.dart';
import 'RegisterService.dart';

class RegisterManager {
  static final RegisterManager _instance = RegisterManager._internal();
  factory RegisterManager() => _instance;
  RegisterManager._internal();

  final _service = RegisterService();

  BaseResponse<StatusData>? lastRegister;
  BaseResponse<LoginData>? lastVerifyRegisterOtp;
  BaseResponse<StatusData>? lastResendRegisterOtp;
  String? lastAccountStatus;

  Future<BaseResponse<StatusData>> register(RegisterRequest req) async {
    final res = await _service.register(req);
    lastRegister = res;
    lastAccountStatus = res.data?.status;
    return res;
  }

  Future<BaseResponse<LoginData>> verifyRegisterOtp({
    required String email,
    required String otp,
    required String password,
  }) async {
    final res = await _service.verifyRegisterOtp(
      VerifyRegisterOtpRequest(
        email: email,
        otp: otp,
        password: password,
      ),
    );

    lastVerifyRegisterOtp = res;

    if (res.success && res.data != null) {
      final m = Manager();

      m.tokens = res.data!.tokens;
      m.currentUser = res.data!.user;
      m.currentSubscription = res.data!.subscription;

      lastAccountStatus = 'active';

      unawaited(() async {
        try {
          final fcm = FcmService();
          await fcm.init();
          await fcm.registerToken();
        } catch (_) {
        }
      }());
    }

    return res;
  }

  Future<BaseResponse<StatusData>> resendRegisterOtp(String email) async {
    final res = await _service.resendRegisterOtp(email);
    lastResendRegisterOtp = res;
    lastAccountStatus = res.data?.status;
    return res;
  }

  void clear() {
    lastRegister = null;
    lastVerifyRegisterOtp = null;
    lastResendRegisterOtp = null;
    lastAccountStatus = null;
  }
}

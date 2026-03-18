// lib/Auth/Services/LoginService.dart
import '../../init/Manager.dart';
import '../../init/BaseResponse.dart';
import '../../init/HelperService.dart';
import '../Shared/AuthModels.dart';

class LoginService {
  static final LoginService _instance = LoginService._internal();
  factory LoginService() => _instance;
  LoginService._internal();

  HelperService get _auth => Manager().helperService;

  Future<BaseResponse<LoginStep1Data>> authLogin(LoginRequest req) {
    return _auth.postTyped<LoginStep1Data>(
      '/renovily/login/auth_login',
      data: req.toJson(),
      parse: (j) => LoginStep1Data.fromJson(j),
    );
  }

  Future<BaseResponse<LoginData>> authLoginOtp(LoginOtpRequest req) async {
    final res = await _auth.postTyped<LoginData>(
      '/renovily/login/auth_login_otp',
      data: req.toJson(),
      parse: (j) => LoginData.fromJson(j),
    );

    if (res.success && res.data != null) {
      final m = Manager();

      m.tokens = res.data!.tokens;
      m.currentUser = res.data!.user;

      await _auth.saveTokens(res.data!.tokens);
    }

    return res;
  }

  Future<BaseResponse<StatusData>> sendPasswordResetLink(String email) {
    return _auth.postTyped<StatusData>(
      '/renovily/password/auth_forgot_password',
      data: EmailOnlyRequest(email).toJson(),
      parse: (j) => StatusData.fromJson(j),
    );
  }
}

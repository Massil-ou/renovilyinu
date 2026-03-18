// lib/Auth/Services/RegisterService.dart
import '../../Push/FcmService.dart';
import '../../init/Manager.dart';
import '../../init/BaseResponse.dart';
import '../../init/HelperService.dart';
import '../Shared/AuthModels.dart';

class RegisterService {
  static final RegisterService _instance = RegisterService._internal();
  factory RegisterService() => _instance;
  RegisterService._internal();

  HelperService get _auth => Manager().helperService;

  Future<BaseResponse<StatusData>> register(RegisterRequest req) {
    return _auth.postTyped<StatusData>(
      '/renovily/register/auth_register',
      data: req.toJson(),
      parse: (j) => StatusData.fromJson(j),
    );
  }

  Future<BaseResponse<LoginData>> verifyRegisterOtp(
      VerifyRegisterOtpRequest req,
      ) async {
    final res = await _auth.postTyped<LoginData>(
      '/renovily/register/auth_register_verify_otp',
      data: req.toJson(),
      parse: (j) => LoginData.fromJson(j),
    );

    if (res.success && res.data != null) {
      await _auth.saveTokens(res.data!.tokens);
      await FcmService().registerToken();
    }

    return res;
  }

  Future<BaseResponse<StatusData>> resendRegisterOtp(String email) {
    return _auth.postTyped<StatusData>(
      '/renovily/register/auth_register_resend_otp',
      data: EmailOnlyRequest(email).toJson(),
      parse: (j) => StatusData.fromJson(j),
    );
  }
}

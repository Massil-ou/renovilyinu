// lib/Auth/Services/PasswordService.dart
import '../../init/Manager.dart';
import '../../init/BaseResponse.dart';
import '../../init/HelperService.dart';
import '../Shared/AuthModels.dart';

class PasswordService {
  static final PasswordService _instance = PasswordService._internal();
  factory PasswordService() => _instance;
  PasswordService._internal();

  HelperService get _auth => Manager().helperService;

  Future<BaseResponse<StatusData>> changePasswordWithToken({
    required String email,
    required String token,
    required String newPassword,
  }) {
    return _auth.postTyped<StatusData>(
      '/renovily/password/auth_change_password',
      data: {
        'email': email,
        'token': token,
        'new_password': newPassword,
      },
      parse: (j) => StatusData.fromJson(j),
    );
  }
}

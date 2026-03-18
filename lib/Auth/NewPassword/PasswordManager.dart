// lib/Auth/Managers/PasswordManager.dart
import '../../init/BaseResponse.dart';
import '../Shared/AuthModels.dart';
import 'PasswordService.dart';

class PasswordManager {
  static final PasswordManager _instance = PasswordManager._internal();
  factory PasswordManager() => _instance;
  PasswordManager._internal();

  final _service = PasswordService();

  Future<BaseResponse<StatusData>> changePassword({
    required String email,
    required String token,
    required String newPassword,
  }) {
    return _service.changePasswordWithToken(
      email: email,
      token: token,
      newPassword: newPassword,
    );
  }
}

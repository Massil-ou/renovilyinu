// lib/Auth/Logout/LogoutService.dart
import '../../../../Auth/Shared/AuthModels.dart';
import '../../../../init/BaseResponse.dart';
import '../../../../init/HelperService.dart';
import '../../../../init/Manager.dart';


class LogoutService {
  static final LogoutService _instance = LogoutService._internal();
  factory LogoutService() => _instance;
  LogoutService._internal();

  HelperService get _auth => Manager().helperService;

  Future<BaseResponse<StatusData>> logoutWithRefresh({
    required String refreshToken,
    String? fcmToken,
  }) {
    return _auth.postTyped<StatusData>(
      '/renovily/auth/logout',
      data: {
        'refresh_token': refreshToken,
        if (fcmToken != null && fcmToken.isNotEmpty) 'fcm_token': fcmToken,
      },
      parse: (j) => StatusData.fromJson(j),
    );
  }
}

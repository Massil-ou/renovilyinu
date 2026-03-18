import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../Auth/Shared/AuthModels.dart';
import '../../../../init/BaseResponse.dart';
import '../../../../init/Manager.dart';

class AutoLoginService {
  static final AutoLoginService _instance = AutoLoginService._internal();
  factory AutoLoginService() => _instance;
  AutoLoginService._internal();

  static const String _endpoint = '/renovily/login/auto_login';

  Future<BaseResponse<LoginData>> serviceAutoLogin({
    required String refreshToken,
    Duration maxWait = const Duration(seconds: 5),
  }) async {
    final helper = Manager().helperService;
    final Dio authDio = helper.authDio;

    try {
      final devHeader = await helper.deviceHeaderValue();

      final res = await authDio
          .post(
        _endpoint,
        data: jsonEncode({'refresh_token': refreshToken}),
        options: Options(
          headers: {'X-Device-Id': devHeader},
          //  crucial : pas de refresh/ré-entrance sur auto_login
          extra: {'skipRefresh': true},
        ),
      )
          .timeout(maxWait);

      final payload = helper.asJson(res.data);

      return BaseResponse.fromJson<LoginData>(
        payload,
        parse: (j) => LoginData.fromJson(j),
      );
    } on TimeoutException {
      return BaseResponse<LoginData>(
        success: false,
        message: 'timeout',
        code: 408,
        data: null,
      );
    } on DioException catch (e) {
      // essaie de parser la réponse si elle existe
      final data = e.response?.data;
      try {
        final payload = helper.asJson(data);
        return BaseResponse.fromJson<LoginData>(
          payload,
          parse: (j) => LoginData.fromJson(j),
        );
      } catch (_) {
        return BaseResponse<LoginData>(
          success: false,
          message: 'network_error',
          code: e.response?.statusCode ?? -1,
          data: null,
        );
      }
    } catch (_) {
      return BaseResponse<LoginData>(
        success: false,
        message: 'network_error',
        code: -1,
        data: null,
      );
    }
  }
}

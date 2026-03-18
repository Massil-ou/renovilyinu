// lib/init/Manager.dart
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Auth/Shared/AuthModels.dart';

import '../Dashboard/Dashboard/AdminManager.dart';
import '../Dashboard/Dashboard/RenovilyAdmin/RenovilyAdminManager.dart';
import '../Dashboard/Dashboard/menu/LoginAuto/AutoLoginManager.dart';
import '../Dashboard/Dashboard/menu/Logout/LogoutManager.dart';
import '../MetaData/Adresse/dz_lookup.dart';
import '../MetaData/Langues/AppLanguage.dart';
import 'BaseResponse.dart';
import '../Auth/Login/LoginManager.dart';
import '../Auth/NewPassword/PasswordManager.dart';
import '../Auth/Signin/RegisterManager.dart';
import 'CarCatalog.dart';
import 'GlobalSingleton.dart';
import 'HelperService.dart';
import 'LanguageService.dart';

class Manager {
  static final Manager _instance = Manager._internal();
  factory Manager() => _instance;
  Manager._internal();


  LanguageService? _languageService;
  LanguageService get languageService => _languageService ??= LanguageService();

  WinyCar get winyCarTranslation => WinyCar(languageService.appLanguage);

  GlobalSingleton? _globalSingleton;
  GlobalSingleton get globalSingleton => _globalSingleton ??= GlobalSingleton();

  RenovilyAdminManager? _adminManager;
  RenovilyAdminManager get adminManager => _adminManager ??= RenovilyAdminManager();

  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.winycar.fr',
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
  ));

  final storage = const FlutterSecureStorage();

  HelperService? _helperService;
  HelperService get helperService {
    return _helperService ??= HelperService(dio, storage, deviceMacKeyB64: "u4InvlLCuedXt67EaUZHS1cWzJjc54K8Gj3jQ8IhAcI=");
  }

  LogoutManager? _logoutManager;
  LogoutManager get logoutManager => _logoutManager ??= LogoutManager();

  AutoLoginManager? _autoLoginManager;
  AutoLoginManager get autoLoginManager =>
      _autoLoginManager ??= AutoLoginManager();

  LoginManager? _loginManager;
  LoginManager get loginManager => _loginManager ??= LoginManager();


  PasswordManager? _passwordManager;
  PasswordManager get passwordManager => _passwordManager ??= PasswordManager();

  RegisterManager? _registerManager;
  RegisterManager get registerManager => _registerManager ??= RegisterManager();


  CarCatalog? _carCatalog;
  CarCatalog get carCatalog => _carCatalog ??= CarCatalog();


  DzLookupService? _dzLookupService;
  DzLookupService get dzLookupService => _dzLookupService ??= DzLookupService();


  TokensData? tokens;
  UserData? currentUser;
  SubscriptionData? currentSubscription;

  String get currentUserEmail =>
      (currentUser?.email ?? '').toLowerCase().trim();

  bool get isAuthenticated => tokens?.accessToken.isNotEmpty == true;

  String? lastAccountStatus;
  int? attemptsMax;
  BaseResponse<LoginData>? lastAutoLogin;

  String readableMessage(BaseResponse resp) {
    final custom = ApiCodes.messageFor(resp.code);
    return custom.isNotEmpty
        ? custom
        : (resp.message.isNotEmpty ? resp.message : 'Une erreur est survenue.');
  }

  static const _kRememberKey = 'auth_remember';
  static const _kRememberEmailKey = 'auth_email';
  static const _kRememberPasswordKey = 'auth_password';

  Future<void> setRememberedCredentials({
    required bool remember,
    String? email,
    String? password,
  }) async {
    if (!remember) {
      await storage.delete(key: _kRememberKey);
      await storage.delete(key: _kRememberEmailKey);
      await storage.delete(key: _kRememberPasswordKey);
      return;
    }

    await storage.write(key: _kRememberKey, value: '1');

    if ((email?.isNotEmpty ?? false)) {
      await storage.write(key: _kRememberEmailKey, value: email);
    }
    if ((password?.isNotEmpty ?? false)) {
      await storage.write(key: _kRememberPasswordKey, value: password);
    }
  }

  Future<({bool remember, String email, String password})>
  getRememberedCredentials() async {
    final r = await storage.read(key: _kRememberKey);
    final em = await storage.read(key: _kRememberEmailKey) ?? '';
    final pw = await storage.read(key: _kRememberPasswordKey) ?? '';

    return (remember: r == '1', email: em, password: pw);
  }
}

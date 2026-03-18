import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';

import '../MetaData/Langues/AppLanguage.dart';

class LanguageService {
  static final LanguageService _instance = LanguageService._internal();
  factory LanguageService() => _instance;

  LanguageService._internal() {
    _initFuture = _init();
  }

  static const _kLangKey = 'app_lang';

  final ValueNotifier<AppLanguage> language = ValueNotifier<AppLanguage>(
    AppLanguage.fr,
  );

  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final Dio dio = Dio();

  AppLanguage get appLanguage => language.value;
  Locale get locale => appLanguage.locale;
  String get languageCode => appLanguage.code;
  TextDirection get textDirection => appLanguage.direction;

  Future<void>? _initFuture;

  Future<void> _init() async {
    try {
      final savedCode = await storage.read(key: _kLangKey);
      if (savedCode != null && savedCode.trim().isNotEmpty) {
        final savedLang = AppLanguage.fromCode(savedCode);
        language.value = savedLang;
        dio.options.headers['Accept-Language'] = savedLang.code;
        return;
      }

      final systemCode = ui.PlatformDispatcher.instance.locale.languageCode;

      final lc = systemCode.toLowerCase();
      final detectedLang = lc.startsWith('ar')
          ? AppLanguage.ar
          : (lc == 'en' ? AppLanguage.en : AppLanguage.fr);

      language.value = detectedLang;
      dio.options.headers['Accept-Language'] = detectedLang.code;
    } catch (e) {
      language.value = AppLanguage.fr;
      dio.options.headers['Accept-Language'] = 'fr';
    }
  }

  Future<void> waitForInit() async => _initFuture ?? Future.value();

  Future<void> setLanguage(AppLanguage lang) async {
    if (language.value == lang) return;

    language.value = lang;
    await storage.write(key: _kLangKey, value: lang.code);
    dio.options.headers['Accept-Language'] = lang.code;
  }

  Future<void> cycleLanguage() async {
    final next = switch (language.value) {
      AppLanguage.fr => AppLanguage.en,
      AppLanguage.en => AppLanguage.ar,
      AppLanguage.ar => AppLanguage.fr,
    };
    await setLanguage(next);
  }
}

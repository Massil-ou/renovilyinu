import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import '../App/WinyCarApp.dart';
import '../firebase_options.dart';
import '../init/Manager.dart';

Future<void> runAppEntry() async {
  setUrlStrategy(PathUrlStrategy());

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final manager = Manager();
  await manager.autoLoginManager.bootstrap();

  runApp(TomobilApp(manager: manager));
}

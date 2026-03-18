// lib/main_mobile.dart
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../App/WinyCarApp.dart';
import '../firebase_options.dart';
import '../init/Manager.dart';

Future<void> runAppEntry() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final manager = Manager();
  await manager.autoLoginManager.bootstrap();

  runApp(TomobilApp(manager: manager));
}

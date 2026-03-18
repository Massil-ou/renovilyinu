// lib/main.dart
import 'dart:async';
import 'package:flutter/widgets.dart';

import 'Main/main_mobile.dart' if (dart.library.html) 'Main/main_web.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await runAppEntry();
}

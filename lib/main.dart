import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobipad/services/package_info_manager.dart';
import 'composition.dart';

Future<void> main() async {
  // Lock to portrait orientation.
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await PackageInfoManager().init();

  runApp(await appWidget);
}

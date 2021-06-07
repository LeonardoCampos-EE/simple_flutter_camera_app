import 'package:camera_simple/app/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:camera_simple/app/app_module.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ModularApp(module: AppModule(), child: AppWidget())
  );
}

// Flutter imports
import 'package:flutter_modular/flutter_modular.dart';

/// Modular imports
// App
import 'package:camera_simple/app/app_controller.dart';
import 'package:camera_simple/app/pages/home/home_page.dart';

// Camera
import 'package:camera_simple/app/pages/camera/camera_controller.dart';
import 'package:camera_simple/app/pages/camera/camera_page.dart';

// Picture
import 'package:camera_simple/app/pages/picture/picture_controller.dart';
import 'package:camera_simple/app/pages/picture/picture_page.dart';

// ArCore
import 'package:camera_simple/app/pages/ar_core/ar_controller.dart';
import 'package:camera_simple/app/pages/ar_core/ar_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => AppController()),
    Bind((i) => CameraPageController()),
    Bind((i) => PictureController()),
    Bind((i) => ArPageController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/home', child: (_, args) => HomePage()),
    ChildRoute('/camera', child: (_, args) => CameraPage()),
    ChildRoute('/picture', child: (_, args) => PicturePage()),
    ChildRoute('/ar', child: (_, args) => ArPage()),
  ];
}
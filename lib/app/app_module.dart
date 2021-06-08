// Flutter imports
import 'package:flutter_modular/flutter_modular.dart';

// Modular imports
import 'package:camera_simple/app/app_controller.dart';
import 'package:camera_simple/app/pages/home/home_page.dart';
import 'package:camera_simple/app/pages/camera/camera_controller.dart';
import 'package:camera_simple/app/pages/camera/camera_page.dart';
import 'package:camera_simple/app/pages/picture/picture_controller.dart';
import 'package:camera_simple/app/pages/picture/picture_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => AppController()),
    Bind((i) => CameraPageController()),
    Bind((i) => PictureController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/home', child: (_, args) => HomePage()),
    ChildRoute('/camera', child: (_, args) => CameraPage()),
    ChildRoute('/picture', child: (_, args) => PicturePage()),
  ];
}
// Flutter imports
import 'package:camera/camera.dart';
import 'package:mobx/mobx.dart';

// Modular imports
import 'package:camera_simple/app/pages/camera/guidelines_painter.dart';

// MobX imports
part 'camera_controller.g.dart';

abstract class _CameraPageController with Store {
  @observable
  int selectedCameraIndex = 0;

  @observable
  List<CameraDescription> cameras = [];  

  @observable
  GuidelinesPainter guidelinesPainter = GuidelinesPainter();
}

class CameraPageController = _CameraPageController with _$CameraPageController;

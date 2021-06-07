import 'package:mobx/mobx.dart';
part 'camera_controller.g.dart';

abstract class _CameraPageController with Store {
  @observable
  int top = 0;

  @observable
  int left = 0;

  @observable
  int width = 0;

  @observable
  int height = 0;

  @observable
  String imagePath = "";

  @observable
  int selectedCameraIndex = 0;
}

class CameraPageController = _CameraPageController with _$CameraPageController;
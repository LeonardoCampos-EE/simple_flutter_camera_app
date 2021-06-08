// Dart imports
import 'dart:io';
import 'dart:typed_data';

// Flutter imports
import 'package:mobx/mobx.dart';

// MobX imports
part 'picture_controller.g.dart';

abstract class _PictureController with Store {
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
  String fileName = "";

  @action
  Future getBytes() async {
    Uint8List bytes = File(imagePath).readAsBytesSync();
    return ByteData.view(bytes.buffer);
  }
}

class PictureController = _PictureController with _$PictureController;
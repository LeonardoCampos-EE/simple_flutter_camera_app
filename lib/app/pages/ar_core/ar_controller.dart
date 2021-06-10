// Dart imports
import 'dart:io';
import 'dart:typed_data';
import 'dart:async';

// Flutter imports
import 'package:mobx/mobx.dart';
import 'package:image/image.dart' as img;
import 'package:exif/exif.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart' as ARCore;

// MobX imports
part 'ar_controller.g.dart';

abstract class _ArPageController with Store {}

class ArPageController = _ArPageController with _$ArPageController;

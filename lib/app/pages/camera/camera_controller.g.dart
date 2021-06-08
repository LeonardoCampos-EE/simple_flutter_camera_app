// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CameraPageController on _CameraPageController, Store {
  final _$selectedCameraIndexAtom =
      Atom(name: '_CameraPageController.selectedCameraIndex');

  @override
  int get selectedCameraIndex {
    _$selectedCameraIndexAtom.reportRead();
    return super.selectedCameraIndex;
  }

  @override
  set selectedCameraIndex(int value) {
    _$selectedCameraIndexAtom.reportWrite(value, super.selectedCameraIndex, () {
      super.selectedCameraIndex = value;
    });
  }

  final _$camerasAtom = Atom(name: '_CameraPageController.cameras');

  @override
  List<CameraDescription> get cameras {
    _$camerasAtom.reportRead();
    return super.cameras;
  }

  @override
  set cameras(List<CameraDescription> value) {
    _$camerasAtom.reportWrite(value, super.cameras, () {
      super.cameras = value;
    });
  }

  final _$guidelinesPainterAtom =
      Atom(name: '_CameraPageController.guidelinesPainter');

  @override
  GuidelinesPainter get guidelinesPainter {
    _$guidelinesPainterAtom.reportRead();
    return super.guidelinesPainter;
  }

  @override
  set guidelinesPainter(GuidelinesPainter value) {
    _$guidelinesPainterAtom.reportWrite(value, super.guidelinesPainter, () {
      super.guidelinesPainter = value;
    });
  }

  @override
  String toString() {
    return '''
selectedCameraIndex: ${selectedCameraIndex},
cameras: ${cameras},
guidelinesPainter: ${guidelinesPainter}
    ''';
  }
}

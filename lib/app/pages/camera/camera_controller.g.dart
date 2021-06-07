// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CameraPageController on _CameraPageController, Store {
  final _$topAtom = Atom(name: '_CameraPageController.top');

  @override
  int get top {
    _$topAtom.reportRead();
    return super.top;
  }

  @override
  set top(int value) {
    _$topAtom.reportWrite(value, super.top, () {
      super.top = value;
    });
  }

  final _$leftAtom = Atom(name: '_CameraPageController.left');

  @override
  int get left {
    _$leftAtom.reportRead();
    return super.left;
  }

  @override
  set left(int value) {
    _$leftAtom.reportWrite(value, super.left, () {
      super.left = value;
    });
  }

  final _$widthAtom = Atom(name: '_CameraPageController.width');

  @override
  int get width {
    _$widthAtom.reportRead();
    return super.width;
  }

  @override
  set width(int value) {
    _$widthAtom.reportWrite(value, super.width, () {
      super.width = value;
    });
  }

  final _$heightAtom = Atom(name: '_CameraPageController.height');

  @override
  int get height {
    _$heightAtom.reportRead();
    return super.height;
  }

  @override
  set height(int value) {
    _$heightAtom.reportWrite(value, super.height, () {
      super.height = value;
    });
  }

  final _$imagePathAtom = Atom(name: '_CameraPageController.imagePath');

  @override
  String get imagePath {
    _$imagePathAtom.reportRead();
    return super.imagePath;
  }

  @override
  set imagePath(String value) {
    _$imagePathAtom.reportWrite(value, super.imagePath, () {
      super.imagePath = value;
    });
  }

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

  @override
  String toString() {
    return '''
top: ${top},
left: ${left},
width: ${width},
height: ${height},
imagePath: ${imagePath},
selectedCameraIndex: ${selectedCameraIndex}
    ''';
  }
}

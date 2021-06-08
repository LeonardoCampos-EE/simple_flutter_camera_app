// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picture_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PictureController on _PictureController, Store {
  final _$topAtom = Atom(name: '_PictureController.top');

  @override
  double get top {
    _$topAtom.reportRead();
    return super.top;
  }

  @override
  set top(double value) {
    _$topAtom.reportWrite(value, super.top, () {
      super.top = value;
    });
  }

  final _$leftAtom = Atom(name: '_PictureController.left');

  @override
  double get left {
    _$leftAtom.reportRead();
    return super.left;
  }

  @override
  set left(double value) {
    _$leftAtom.reportWrite(value, super.left, () {
      super.left = value;
    });
  }

  final _$widthAtom = Atom(name: '_PictureController.width');

  @override
  double get width {
    _$widthAtom.reportRead();
    return super.width;
  }

  @override
  set width(double value) {
    _$widthAtom.reportWrite(value, super.width, () {
      super.width = value;
    });
  }

  final _$heightAtom = Atom(name: '_PictureController.height');

  @override
  double get height {
    _$heightAtom.reportRead();
    return super.height;
  }

  @override
  set height(double value) {
    _$heightAtom.reportWrite(value, super.height, () {
      super.height = value;
    });
  }

  final _$imagePathAtom = Atom(name: '_PictureController.imagePath');

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

  final _$fileNameAtom = Atom(name: '_PictureController.fileName');

  @override
  String get fileName {
    _$fileNameAtom.reportRead();
    return super.fileName;
  }

  @override
  set fileName(String value) {
    _$fileNameAtom.reportWrite(value, super.fileName, () {
      super.fileName = value;
    });
  }

  final _$getBytesAsyncAction = AsyncAction('_PictureController.getBytes');

  @override
  Future<dynamic> getBytes() {
    return _$getBytesAsyncAction.run(() => super.getBytes());
  }

  final _$fixRotationAsyncAction =
      AsyncAction('_PictureController.fixRotation');

  @override
  Future<dynamic> fixRotation() {
    return _$fixRotationAsyncAction.run(() => super.fixRotation());
  }

  final _$cropImageAsyncAction = AsyncAction('_PictureController.cropImage');

  @override
  Future<dynamic> cropImage() {
    return _$cropImageAsyncAction.run(() => super.cropImage());
  }

  @override
  String toString() {
    return '''
top: ${top},
left: ${left},
width: ${width},
height: ${height},
imagePath: ${imagePath},
fileName: ${fileName}
    ''';
  }
}

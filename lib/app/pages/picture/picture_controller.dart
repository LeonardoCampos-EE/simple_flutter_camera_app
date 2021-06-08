// Dart imports
import 'dart:io';
import 'dart:typed_data';
import 'dart:async';

// Flutter imports
import 'package:mobx/mobx.dart';
import 'package:image/image.dart' as img;
import 'package:exif/exif.dart';

// MobX imports
part 'picture_controller.g.dart';

abstract class _PictureController with Store {
  @observable
  double top = 0;

  @observable
  double left = 0;

  @observable
  double width = 0;

  @observable
  double height = 0;

  @observable
  String imagePath = "";

  @observable
  String fileName = "";

  @action
  Future getBytes() async {
    Uint8List bytes = File(imagePath).readAsBytesSync();
    return ByteData.view(bytes.buffer);
  }

  @action
  Future fixRotation() async {
    final originalFile = File(imagePath);

    // ignore: await_only_futures
    Uint8List imageBytes = await originalFile.readAsBytesSync();

    final originalImage = img.decodeImage(imageBytes);

    // We'll use the exif package to read exif data
    // This is map of several exif properties
    // Let's check 'Image Orientation'
    // final exifData = await readExifFromBytes(imageBytes);

    img.Image fixedImage = img.copyRotate(originalImage, -90);

    // if (height < width) {
    //   // rotate
    //   if (exifData['Image Orientation']!.printable.contains('Horizontal')) {
    //     fixedImage = img.copyRotate(originalImage, 90);
    //   } else if (exifData['Image Orientation']!.printable.contains('180')) {
    //     fixedImage = img.copyRotate(originalImage, -90);
    //   } else {
    //     fixedImage = img.copyRotate(originalImage, 0);
    //   }
    // }

    // Here you can select whether you'd like to save it as png
    // or jpg with some compression
    // I choose jpg with 100% quality
    await originalFile.writeAsBytes(img.encodeJpg(fixedImage));
  }

  @action
  Future cropImage() async {
    final originalFile = File(imagePath);

    // ignore: await_only_futures
    Uint8List imageBytes = await originalFile.readAsBytesSync();

    final originalImage = img.decodeImage(imageBytes);

    final imageWidth = originalImage.width;
    final imageHeight = originalImage.height;

    img.Image croppedImage =
        img.copyCrop(
          originalImage, 
          (left*1.25*imageWidth).round(), 
          (top*0.75*imageHeight).round(),
          (width*imageWidth).round(), 
          (height*imageHeight).round()
        );

    // Here you can select whether you'd like to save it as png
    // or jpg with some compression
    // I choose jpg with 100% quality
    await originalFile.writeAsBytes(img.encodeJpg(croppedImage));
  }
}

class PictureController = _PictureController with _$PictureController;

// Dart imports
import 'dart:ui' as ui;

// Flutter imports
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Modular imports
import 'package:camera_simple/app/pages/picture/picture_controller.dart';

final pictureController = Modular.get<PictureController>();

class GuidelinesPainter extends CustomPainter {
  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    canvas.drawColor(Colors.grey.withOpacity(0.8), BlendMode.dstOut);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement
    return false;
  }
}

class Clip extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    // Origin on Top Left portrait / Bottom Left landscape
    double left = ((size.width / 2) - (size.width * 0.25));
    double top = ((size.height / 2) - (size.height * 0.175));
    double width = (size.width / 2);
    double height = (size.height / 2);

    print("Size: $size");
    Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(left, top, width, height), Radius.circular(25)));

    pictureController.left = (left/size.width);
    pictureController.top = (top/size.height);
    pictureController.width = (width/size.width);
    pictureController.height = (height/size.height);

    return path;
  }

  @override
  bool shouldReclip(oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

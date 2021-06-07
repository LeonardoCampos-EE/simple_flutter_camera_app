import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

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

class Clip extends CustomClipper<Path>{
  @override
  getClip(Size size) {
    print(size);
    Path path = Path()
    ..addRRect(RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width/2, size.height/2),
        width : size.width*0.50,
        height: size.height*0.70
      ),
        Radius.circular(25)
    ));
    return path;
  }
  @override
  bool shouldReclip(oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}



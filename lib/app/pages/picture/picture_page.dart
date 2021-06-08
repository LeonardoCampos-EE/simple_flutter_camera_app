// Dart imports
import 'dart:io';

// Flutter imports
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

// Modular imports
import 'package:camera_simple/app/pages/picture/picture_controller.dart';


class PicturePage extends StatefulWidget {
  PicturePage();

  @override
  _PicturePageState createState() => _PicturePageState();
}

class _PicturePageState extends State<PicturePage> {

  final pictureController = Modular.get<PictureController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Image.file(
                  File(pictureController.imagePath),
                  fit: BoxFit.contain,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 60,
                  color: Colors.black,
                  child: Center(
                    child: IconButton(
                      icon: Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        pictureController.getBytes().then((bytes) {
                          Share.file(
                            'Share via', pictureController.imagePath,
                            bytes.buffer.asUint8List(), 'image/path'
                          );
                        });
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

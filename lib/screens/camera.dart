import 'package:camera_simple/screens/preview.dart';
import 'package:camera_simple/screens/painter.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart';

import 'dart:io';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  int _selectedCameraIndex = 0;
  String imgPath = "";
  GuidelinesPainter guidelinesPainter = GuidelinesPainter();

  Future initCamera(CameraDescription cameraDescription) async {
    if (_cameraController != null) {
      await _cameraController?.dispose();
    }

    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);

    _cameraController?.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    try {
      await _cameraController?.initialize();
    } catch (e) {
      showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  /// Display camera preview
  Widget cameraPreview() {
    final CameraController? cameraController = _cameraController;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return Text(
        'Loading',
        style: TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
      );
    }

    return MaterialApp(
        home: Padding(
            padding: EdgeInsets.all(5.0),
            child: Stack(
              children: <Widget>[
                CustomPaint(
                  foregroundPainter: guidelinesPainter,
                  child: CameraPreview(cameraController),
                ),
                ClipPath(
                  clipper: Clip(),
                  child: AspectRatio(
                    aspectRatio: cameraController.value.aspectRatio, // This creates a distortion in the feed image
                    child: CameraPreview(cameraController)),
                )
              ],
            )));
  }

  Widget cameraControl(context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            FloatingActionButton(
              child: Icon(
                Icons.camera,
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
              onPressed: () {
                onCapture(context);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget cameraToggle() {
    CameraDescription selectedCamera = _cameras[_selectedCameraIndex];
    CameraLensDirection lensDirection = selectedCamera.lensDirection;

    return Expanded(
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextButton.icon(
            onPressed: () {
              onSwitchCamera();
            },
            icon: Icon(
              getCameraLensIcons(lensDirection),
              color: Colors.white,
              size: 24,
            ),
            label: Text(
              '${lensDirection.toString().substring(lensDirection.toString().indexOf('.') + 1).toUpperCase()}',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            )),
      ),
    );
  }

  onCapture(context) async {
    try {
      final p = await getApplicationDocumentsDirectory();
      final name = DateTime.now();
      final dirPath = "${p.path}/media";
      await Directory(dirPath).create(recursive: true);

      final String filePath = '$dirPath/$name.jpeg';

      await _cameraController?.takePicture().then((file) {
        print(file.path);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PreviewScreen(
                      file.path,
                      "$name.jpeg",
                    )));
      });
    } catch (e) {
      showCameraException(e);
    }
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    availableCameras().then((value) {
      _cameras = value;
      if (_cameras.length > 0) {
        setState(() {
          _selectedCameraIndex = 0;
        });
        initCamera(_cameras[_selectedCameraIndex]).then((value) {});
      } else {
        print('No camera available');
      }
    }).catchError((e) {
      print('Error : ${e.code}');
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: cameraPreview(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 120,
                width: double.infinity,
                padding: EdgeInsets.all(15),
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    cameraToggle(),
                    cameraControl(context),
                    Spacer(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getCameraLensIcons(lensDirection) {
    switch (lensDirection) {
      case CameraLensDirection.back:
        return CupertinoIcons.switch_camera;
      case CameraLensDirection.front:
        return CupertinoIcons.switch_camera_solid;
      case CameraLensDirection.external:
        return CupertinoIcons.photo_camera;
      default:
        return Icons.device_unknown;
    }
  }

  onSwitchCamera() {
    _selectedCameraIndex = _selectedCameraIndex < _cameras.length - 1
        ? _selectedCameraIndex + 1
        : 0;
    CameraDescription selectedCamera = _cameras[_selectedCameraIndex];
    initCamera(selectedCamera);
  }

  showCameraException(e) {
    String errorText = 'Error ${e.code} \nError message: ${e.description}';
  }
}

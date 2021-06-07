import 'package:camera_simple/app/pages/camera/preview_screen.dart';
import 'package:camera_simple/app/pages/camera/guidelines_painter.dart';
import 'package:camera_simple/app/pages/camera/camera_controller.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

final cameraPageController = CameraPageController();

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage>
    with WidgetsBindingObserver {
  // Class properties
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  GuidelinesPainter guidelinesPainter = GuidelinesPainter();

  // Initialize camera
  Future initCamera(CameraDescription cameraDescription) async {
    // If cameraController was already initialized, close it
    if (_cameraController != null) {
      await _cameraController?.dispose();
    }

    // Start camera controller
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.max);

    // Initialize camera if the device is connected
    _cameraController?.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    try {
      await _cameraController?.initialize();
    } catch (e) {
      print('Error $e \nError message: $e');
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();

    // Force landscape orientation
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);

    availableCameras().then((value) {
      _cameras = value;
      if (_cameras.length > 0) {
        cameraPageController.selectedCameraIndex = 0;
        // setState(() {
        //   _selectedCameraIndex = 0;
        // });
        initCamera(_cameras[cameraPageController.selectedCameraIndex])
            .then((value) {});
      } else {
        print('No camera available');
      }
    }).catchError((e) {
      print('Error : ${e.code}');
    });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();

    // Force portrait orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
                    child: CameraPreview(
                        cameraController) // AspectRatio(aspectRatio: cameraController.value.aspectRatio, child: CameraPreview(cameraController))
                    )
              ],
            )));
  }

  /// Widget to allocate the camera controls (switch and capture)
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

  /// Widget to switch between front and back cameras
  Widget cameraToggle() {
    CameraDescription selectedCamera =
        _cameras[cameraPageController.selectedCameraIndex];
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
      // final p = await getApplicationDocumentsDirectory();
      // final dirPath = "${p.path}/media";
      // await Directory(dirPath).create(recursive: true);
      // final String filePath = '$dirPath/$name.jpeg';

      final name = DateTime.now();

      final rect = {
        "top": cameraPageController.top,
        "left": cameraPageController.left,
        "width": cameraPageController.width,
        "height": cameraPageController.height
      };

      await _cameraController?.takePicture().then((file) {
        print(file.path);
        cameraPageController.imagePath = file.path;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PreviewScreen(
                    cameraPageController.imagePath, "$name.jpeg", rect)));
      });
    } catch (e) {
      print('Error $e \nError message: $e');
    }
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
    cameraPageController.selectedCameraIndex =
        cameraPageController.selectedCameraIndex < _cameras.length - 1
            ? cameraPageController.selectedCameraIndex + 1
            : 0;
    CameraDescription selectedCamera =
        _cameras[cameraPageController.selectedCameraIndex];
    initCamera(selectedCamera);
  }
}

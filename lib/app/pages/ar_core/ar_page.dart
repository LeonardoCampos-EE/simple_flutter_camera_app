import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:vector_math/vector_math_64.dart';

class ArPage extends StatefulWidget {
  @override
  _ArPageState createState() => _ArPageState();
}

class _ArPageState extends State<ArPage> {
  final double scale = 0.005;
  double measurement = 0.0;
  final double lineRadius = 0.1;
  bool busy = false;
  bool planeDetected = false;

  late Vector3 scaleVector;
  late ArCoreController arCoreController;
  late ArCorePlane plane;
  List<ArCoreNode> nodes = [];

  double middleX = 0.0;
  double middleY = 0.0;

  @override
  void initState() {
    scaleVector = Vector3(scale, scale, scale);
    super.initState();
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width *
        MediaQuery.of(context).devicePixelRatio;
    double screenHeight = MediaQuery.of(context).size.height *
        MediaQuery.of(context).devicePixelRatio;

    middleX = screenWidth / 2;
    middleY = screenHeight / 2;

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('ARCore Measurement Example'),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[Color(0xff9CECFB), Color(0xff0052D4)])),
            ),
          ),
          body: Stack(
            children: <Widget>[
              ArCoreView(
                onArCoreViewCreated: _onArCoreViewCreated,
                enableUpdateListener: true,
                enableTapRecognizer: true,
                forceTapOnScreenCenter: true,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text('Tap anywhere to place a node'),
                    Text('measurement: ${measurement.toString()}'),
                    Text('Is plane detected: ${planeDetected.toString()}'),
                  ],
                ),
              ),
              const Center(
                child: Icon(
                  Icons.add,
                  color: Color.fromRGBO(255, 255, 255, 1),
                  size: 50.0,
                ),
              ),
            ],
          )),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onPlaneTap = _onPlaneTap;

    arCoreController.onPlaneDetected = (plane) {
      print("Plane detected!");
      this.plane = plane;

      // _addSphere(hitTestAtScreenPosition);

      // final customSphere = ArCoreNode(
      //     scale: scaleVector,
      //     shape: ArCoreSphere(materials: [
      //       ArCoreMaterial(
      //         color: Color.fromRGBO(0, 0, 255, 1),
      //         roughness: 1.0,
      //         reflectance: 0.0,
      //       )
      //     ], radius: 1),
      //     position: Vector3(1, 1, 1),
      //     rotation: Vector4(1, 1, 1, 1));
      // arCoreController.addArCoreNode(customSphere);

      setState(() {
        this.planeDetected = true;
      });
    };
  }

  void _onPlaneTap(List<ArCoreHitTestResult> results) {
    final ArCoreHitTestResult hit = results.first;
    if (nodes.length <= 2) {
      _addSphere(hit);
    }
  }

  Future _addSphere(ArCoreHitTestResult hit) async {
    var hitScreen =
        await arCoreController.performHitTestAtScreenPosition(middleX, middleY);

    print("Completed hit test");

    for (String key in hitScreen.keys) {
      print("******************* $key : ${hitScreen[key]}");
    }

    Map<dynamic, dynamic> screenPose = hitScreen["pose"];
    var screenRot = screenPose["rotation"];
    var screenTrans = screenPose["translation"];

    print("********************** rot[0] = ${screenRot[0]}");

    Vector4 screenRotVec =
        Vector4(screenRot[0], screenRot[1], screenRot[2], screenRot[3]);
    Vector3 screenTransVec =
        Vector3(screenTrans[0], screenTrans[1], screenTrans[2]);

    final material2 = ArCoreMaterial(
      color: Color.fromRGBO(0, 0, 255, 1),
      roughness: 1.0,
      reflectance: 1.0,
    );

    final shape2 = ArCoreSphere(
      materials: [material2],
      radius: 2,
    );

    final node2 = ArCoreNode(
        scale: scaleVector,
        shape: shape2,
        position: screenTransVec,
        rotation: screenRotVec);

    arCoreController.addArCoreNode(node2);

    final material = ArCoreMaterial(
      color: Color.fromRGBO(255, 0, 0, 1),
      roughness: 1.0,
      reflectance: 0.0,
    );

    final shape = ArCoreSphere(
      materials: [material],
      radius: 1,
    );

    final node = ArCoreNode(
        scale: scaleVector,
        shape: shape,
        position: hit.pose.translation,
        rotation: hit.pose.rotation);

    nodes.add(node);
    arCoreController.addArCoreNode(node);

    if (nodes.length == 2) {
      _drawLine();
    }
  }

  void _drawLine() async {
    Vector3 firstPosition = nodes.first.position.value;
    Vector3 lastPosition = nodes.last.position.value;

    final material = ArCoreMaterial(
      color: Color.fromRGBO(255, 255, 255, 1),
      roughness: 1.0,
      reflectance: 0.0,
    );

    final measurement =
        _calculateDistanceBetweenPoints(firstPosition, lastPosition);

    final shape = ArCoreCylinder(
      materials: [material],
      radius: lineRadius,
      height: measurement / scale,
    );

    final middlePoint = _getMiddleVector(firstPosition, lastPosition);
    final rotationVector = _getRotationVector(firstPosition, lastPosition);

    final lineNode = ArCoreNode(
      scale: scaleVector,
      shape: shape,
      position: middlePoint,
      rotation: rotationVector,
    );

    // _addSphere(hitTestAtScreenPosition);

    setState(() {
      this.measurement = measurement;
    });
  }

  Vector3 _getMiddleVector(Vector3 A, Vector3 B) {
    return Vector3((A.x + B.x) / 2.0, (A.y + B.y) / 2.0, (A.z + B.z) / 2.0);
  }

  Vector4 _getRotationVector(Vector3 firstPosition, Vector3 lastPosition) {
    final Vector3 directionA = Vector3(0, 1, 0).normalized();
    final Vector3 directionB =
        subtract(lastPosition, firstPosition).normalized();

    final double theta = acos(directionA.dot(directionB));
    final Vector3 rotationAxis = directionA.cross(directionB).normalized();
    Quaternion quaternion = Quaternion.axisAngle(rotationAxis, theta);
    return Vector4(quaternion.x, quaternion.y, quaternion.z, quaternion.w);
  }

  Vector3 subtract(Vector3 A, Vector3 B) {
    return Vector3(A.x - B.x, A.y - B.y, A.z - B.z);
  }

  double _calculateDistanceBetweenPoints(Vector3 A, Vector3 B) {
    // distance is in meters
    return A.distanceTo(B);
  }
}

import 'package:camera_simple/screens/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home' : (BuildContext context) => HomeScreen(context),
        '/camera': (BuildContext context) => CameraScreen(),
      },
    );
  }
}

class HomeScreen extends Scaffold {
  HomeScreen(context)
  : super(
    appBar: GradientAppBar(),
    backgroundColor: Color(0xff9CECFB),
    body: Padding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/camera');
              },
              icon: Icon(Icons.camera_alt_sharp)
            )
          )
        ],
      ),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
    )
  );
}

class GradientAppBar extends AppBar {
  GradientAppBar()
      : super(
          title: const Text('Simple Camera App'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: <Color>[Color(0xff9CECFB), Color(0xff0052D4)])),
          ),
        );
}

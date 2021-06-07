import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return HomeScreen(context);
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
                          icon: Icon(Icons.camera_alt_sharp)))
                ],
              ),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            ));
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

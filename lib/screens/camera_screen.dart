import 'package:flutter/material.dart';

import 'dart:io';

import 'package:camera/camera.dart';

import 'location_screen.dart';
import 'review_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VetX',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.purple.shade300,
      ),
      routes: {
        '/photo/take': (_) => const TakePhotoPage(),
      },
      initialRoute: '/photo/take',
    );
  }
}

class TakePhotoPage extends StatefulWidget {
  const TakePhotoPage({Key key}) : super(key: key);

  @override
  TakePhotoPageState createState() => TakePhotoPageState();
}

class TakePhotoPageState extends State<TakePhotoPage> {
  CameraController _controller;
  bool isCameraReady = false;
  bool isPhotoInProgress = false;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  void initCamera() async {
    final cameras = await availableCameras();
    print('cameras.length ${cameras.length}'); // PROBLEMO: 2 cameras always!!

    cameras.forEach((CameraDescription element) {
      print(element);
    });

    final firstCamera = cameras.first;
    _controller = CameraController(
      firstCamera,
      ResolutionPreset.max,
      enableAudio: false,
    );

    await _controller.initialize();
    setState(() {
      isCameraReady = true;
    });
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade300,
      appBar: AppBar(
        backgroundColor: Colors.purple.shade300,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 20),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ReviewScreen()),
            );
          },
        ),
        elevation: 4,
        title: Center(
          child: Text(
            'Take a picture',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => LocationScreen()),
              );
            },
            icon: Icon(Icons.location_pin),
          ),
          SizedBox(width: 15.0),
        ],
      ),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: Center(
        child: isCameraReady
            ? Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      CameraPreview(_controller),
                    ],
                  ),
                ),
              ])
            : TextFormField(),
      ),
    );
  }
}

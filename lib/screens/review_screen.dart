import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import '../helpers/components.dart';
import 'details_payment_screen.dart';
import 'home_screen.dart';
import 'location_screen.dart';
import 'camera_screen.dart';

class ReviewScreen extends StatefulWidget {
  static const String routeName = "/review";

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () => Navigator.of(context).pop(),
  ),
  backgroundColor: Colors.deepPurple.shade700,
  elevation: 4,
  title: Container(
    padding: const EdgeInsets.only(top: 20),
    height: 10,
    width: 200,
    child: Text(
      'Review',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),
  ),
  actions: [
    Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => LocationScreen(),
              ),
            );
          },
          icon: Icon(
            Icons.location_pin,
          ),
        ),
        SizedBox(
          width: 15,
        ),
      ],
    ),
  ],
),
      body: Container(
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter review',
          ),
          maxLines: 20,
          minLines: 15,
        ),
      ),
      floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.deepPurple.shade700,
  onPressed: () {
  Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TakePhotoPage(),
              ),
            );
},
  child: Icon(
    Icons.photo_camera_outlined,

  ),
),
    );
  }
}
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:path_provider/path_provider.dart';
import '../helpers/components.dart';
import '../helpers/search_bar.dart';
import 'details_payment_screen.dart';
import 'home_screen.dart';
import 'location_screen.dart';
import 'camera_screen.dart';
import 'profile_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MileniumReviewScreen extends StatefulWidget {
  static const String routeName = "/review";

  @override
  _MileniumReviewScreenState createState() => _MileniumReviewScreenState();
}

class _MileniumReviewScreenState extends State<MileniumReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade300,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 20),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
        elevation: 4,
        title: Center(
          child: Text(
            'MyCinema',
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple.shade300, Colors.pink.shade100],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 15),
            Material(
              color: Colors.purple.shade400,
              elevation: 10,
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Gradski Trgovski Centar',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 15),
            Material(
              color: Colors.purple.shade400,
              elevation: 10,
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Kino Milenium',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 15),
            Material(
              color: Colors.purple.shade400,
              elevation: 10,
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(10.0),
                child: Text(
                  '2nd floor, Gradski Trgovski Centar, Kej 13-ti Noemvri, 1000 Skopje, Macedonia',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            SizedBox(height: 25),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 12.0,
                          ),
                        ),
                        hintText: 'Enter review..',
                      ),
                      maxLines: 20,
                      minLines: 5,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: 5),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 25,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ],
              ),
            ),
          ],
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

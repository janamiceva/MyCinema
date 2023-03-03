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
import 'cineplexx_review_screen.dart';
import 'milenium_review_screen.dart';

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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple.shade300, Colors.pink.shade100],
          ),
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
               onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CineplexxReviewScreen()));
                },
              child: Text('Cineplexx  Add review ->', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
              style: ElevatedButton.styleFrom(
              primary: Colors.purple.shade400, elevation: 10,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
               onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MileniumReviewScreen()));
                },
              child: Text('Kino Milenium  Add review ->' ,style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
              style: ElevatedButton.styleFrom(
              primary: Colors.purple.shade400, elevation: 10,
              ),
            ),
          ],
        )),
      ),
    );
  }
}

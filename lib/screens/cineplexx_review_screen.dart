import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'location_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'review_screen.dart';

class CineplexxReviewScreen extends StatefulWidget {
  static const String routeName = "/review";

  @override
  _CineplexxReviewScreenState createState() => _CineplexxReviewScreenState();
}

class _CineplexxReviewScreenState extends State<CineplexxReviewScreen> {
  TextEditingController _controllerReview = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();

  CollectionReference _reference =
      FirebaseFirestore.instance.collection('list_reviews');
  String imageUrl = '';
  double stars;

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
                  'Skopje City Mall',
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
                  'Cineplexx',
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
                  '3rd floor, Skopje City Mall, Partizanski odredi, Karpos 4, 1000 Skopje, Macedonia',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            SizedBox(height: 25),
            Form(
              key: key,
              child: Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: _controllerReview,
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
                      stars = rating;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.deepPurple.shade700,
            onPressed: () async {
              ImagePicker imagePicker = ImagePicker();
              XFile file =
                  await imagePicker.pickImage(source: ImageSource.camera);
              print('${file?.path}');

              if (file == null) return;
              String uniqueFileName =
                  DateTime.now().millisecondsSinceEpoch.toString();

              Reference referenceRoot = FirebaseStorage.instance.ref();
              Reference referenceDirImages = referenceRoot.child('images');

              Reference referenceImageToUpload =
                  referenceDirImages.child(uniqueFileName);

              try {
                await referenceImageToUpload.putFile(File(file.path));
                imageUrl = await referenceImageToUpload.getDownloadURL();
              } catch (error) {
                //Some error occurred
              }
            },
            child: Icon(
              Icons.photo_camera_outlined,
            ),
          ),
          SizedBox(width: 25),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.deepPurple.shade700)),
              onPressed: () async {
                if (imageUrl.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please upload an image')));

                  return;
                }
                if (key.currentState.validate()) {
                  String itemReview = _controllerReview.text;
                  //Create a Map of data
                  Map<String, Object> dataToSend = {
                    'cinema': 'Cineplexx',
                    'review': itemReview,
                    'image': imageUrl,
                    'stars': stars,
                  };

                  //Add a new item
                  _reference.add(dataToSend);
                }
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ReviewList()));
              },
              child: Text('Submit'))
        ],
      ),
    );
  }
}

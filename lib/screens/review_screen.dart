import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../helpers/starDisplay.dart';
import 'home_screen.dart';
import 'location_screen.dart';

class ReviewList extends StatelessWidget {
  ReviewList({Key key}) : super(key: key) {
    _stream = _reference.snapshots();
  }

  CollectionReference _reference =
      FirebaseFirestore.instance.collection('list_reviews');

  //_reference.get()  ---> returns Future<QuerySnapshot>
  //_reference.snapshots()--> Stream<QuerySnapshot> -- realtime updates
  Stream<QuerySnapshot> _stream;

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
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //Check error
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }

          //Check if data arrived
          if (snapshot.hasData) {
            //get the data
            QuerySnapshot querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;

            //Convert the documents to Maps
            List<Map> items = documents.map((e) => e.data() as Map).toList();

            //Display the list
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                //Get the item at this index
                Map thisItem = items[index];
                //Return the widget for the list items
                return Card(
                  color: Colors.purple.shade200,
                  child: ListTile(
                    title: Text('${thisItem['cinema']}'),
                    subtitle: Text('${thisItem['review']}'),
                    trailing: StarDisplay(value: thisItem['stars']),
                    leading: Container(
                      height: 80,
                      width: 80,
                      child: thisItem.containsKey('image')
                          ? Image.network('${thisItem['image']}')
                          : Container(),
                    ),
                  ),
                );
              },
            );
          }

          //Show loader
          return Center(child: CircularProgressIndicator());
        },
      ), //Display a list // Add a FutureBuilder
    );
  }
}

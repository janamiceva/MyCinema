import '../helpers/cinemas.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'home_screen.dart';
import '../helpers/location_helper.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String _locationImage;
  Position _currentUserPosition;
  double distanceImMeter = 0.0;
  Data data = Data();

  Future _getTheDistance() async {
    _currentUserPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentUserPosition = position;
      });
    }).catchError((e) {
      print(e);
    });

    final _staticImage = LocationHelper.generateLocationPrevieImage(
        _currentUserPosition.latitude, _currentUserPosition.longitude);

    print(_currentUserPosition);

    for (int i = 0; i < data.cinemas.length; i++) {
      double Lablat = data.cinemas[i]['lat'];
      double Lablng = data.cinemas[i]['lng'];

      double distanceImMeter = await Geolocator.distanceBetween(
        _currentUserPosition.latitude,
        _currentUserPosition.longitude,
        Lablat,
        Lablng,
      );
      var distance = distanceImMeter.round().toInt();

      data.cinemas[i]['distance'] = (distance / 100);

      setState(() {
        _locationImage = _staticImage;
      });
    }
  }

  @override
  void initState() {
    _getTheDistance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
        body: Column(children: [
          Container(
            width: double.infinity,
            height: height * 0.4,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Image.network(
              _locationImage ?? '',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: ListView.builder(
                  itemCount: data.cinemas.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      data.cinemas[index]['navigate']));
                            },
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      data.cinemas[index]['name'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Text(
                                      "${data.cinemas[index]['distance']} KM",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Add review',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400)),
                                    Icon(Icons.arrow_right)
                                  ],
                                ),
                              ],
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.purple.shade200)),
                          ),
                          SizedBox(
                            height: 15,
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ]));
  }
}

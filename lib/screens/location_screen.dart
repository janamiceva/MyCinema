import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mycinema/helpers/components.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  Future<void> _getCurrentUserLocation() async{
    final locData = await Location().getLocation();
    print(locData.latitude);
    print(locData.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(onPressed: _getCurrentUserLocation, child: Icon(Icons.location_pin))
      ],
    );
  }
}
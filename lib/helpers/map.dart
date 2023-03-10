import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Position _currentUserPosition;

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
  }

  static final Marker _cineplexxMarker = Marker(
    markerId: MarkerId('_cineplexxMarker'),
    infoWindow: InfoWindow(title: 'Cineplexx'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(42.0049214389, 21.3924407959),
  );

  static final Marker _mileniumMarker = Marker(
    markerId: MarkerId('_mileniumMarker'),
    infoWindow: InfoWindow(title: 'Milenium'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: LatLng(41.9942401867, 21.4357065799),
  );

  Set<Polyline> _polylines = Set<Polyline>();
  Marker _marker = Marker();

  @override
  void initState() {
    super.initState();
    _getTheDistance().then((_) {
      _addPolylines();
      _addMarkers();
    });
  }

  void _addMarkers() {
    setState(() {
      _marker = Marker(
        markerId: MarkerId('_myLocation'),
        infoWindow: InfoWindow(title: 'My Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        position: LatLng(
            _currentUserPosition.latitude, _currentUserPosition.longitude),
      );
    });
  }

  void _addPolylines() {
    setState(() {
      _polylines.add(Polyline(
        polylineId: PolylineId('cineplexxPolyline'),
        points: [
          LatLng(_currentUserPosition.latitude, _currentUserPosition.longitude),
          _cineplexxMarker.position,
        ],
        width: 5,
        color: Colors.red,
      ));
      _polylines.add(Polyline(
        polylineId: PolylineId('mileniumPolyline'),
        points: [
          LatLng(_currentUserPosition.latitude, _currentUserPosition.longitude),
          _mileniumMarker.position,
        ],
        width: 5,
        color: Colors.blue,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        markers: {
          _cineplexxMarker,
          _mileniumMarker,
          _marker,
        },
        polylines: _polylines,
        initialCameraPosition: CameraPosition(
          target: LatLng(
              _currentUserPosition.latitude, _currentUserPosition.longitude),
          zoom: 14.4746,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}

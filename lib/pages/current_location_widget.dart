import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

import '../common_widgets/placeholder_widget.dart';

// this widget will maintain state, in a class called _locationState
class CurrentLocationWidget extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}



// this widget is the state class for CurrentLocationWidget and where most of the magic occurs with initState() and build()
class _LocationState extends State<CurrentLocationWidget> {
  Position _position;

  @override
  void initState() {
    super.initState();
    _initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _initPlatformState() async {
    Position position;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final Geolocator geolocator = Geolocator()
        ..forceAndroidLocationManager = true;
      position = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);

          
    } on PlatformException {
      position = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }

    // this call to set state, with it's wierd syntax, will force the widget to redraw, ie call build() again
    setState(() {
      _position = position;
    });
  }

  @override
  Widget build(BuildContext context) {

    // this widget builds the ui based on the results of asking for permission to location services.
    return FutureBuilder<GeolocationStatus>(
        future: Geolocator().checkGeolocationPermissionStatus(),
        builder:
            (BuildContext context, AsyncSnapshot<GeolocationStatus> snapshot) {
          
          // the future hasn't returned yet, show a progress animation
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          // future returned but there is no location service available, ie it was disabled. show message
          //breaking change from pre 4.0, no more .disabled
          //Future<bool> allowed = await Geolocator().isLocationServiceEnabled();
          
          if (snapshot.data == GeolocationStatus.restricted) {
          //  if (allowed) {
            return const PlaceholderWidget('Location services restricted',
                'Enable location services for this App using the device settings.');
          }

          // either the user said deny now, or disabled location services prior.  show message
          if (snapshot.data == GeolocationStatus.denied) {
            return const PlaceholderWidget('Access to location denied',
                'Allow access to the location services for this App using the device settings.');
          }

          // all good, display the position data from the current state
          return PlaceholderWidget('Current location:', _position.toString());
        });
  }
}

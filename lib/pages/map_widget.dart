import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';


//void main() => runApp(MapWidget())

class MapWidget extends StatelessWidget {
  static const LatLng _center = LatLng(45.172179, -93.874451);

  Future nothing() async {
     Position position;
    
    try {
      final Geolocator geolocator = Geolocator()
        ..forceAndroidLocationManager = true;
     position = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);


        
          
    } on PlatformException {
      position = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child:  GoogleMap(
            onMapCreated: (GoogleMapController controller) {},
              initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 15.0
          ),
        ),
      ), 
      floatingActionButton: FloatingActionButton(
        onPressed: nothing,
        tooltip: 'Increment Counter',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
    //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
  }

  /*return MaterialApp(
      home:  Material(
        child:  Center(
          child: GoogleMap(
            onMapCreated: (GoogleMapController controller) {},
              initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 15.0
          ),
        ),
      ),
    )
    );*/

  /*Widget build(BuildContext context) {
    return MaterialApp(
      home:  Material(
        child:  Center(
          child: const Text('Hello world!'),
        ),
      ),
    );
  }*/

}

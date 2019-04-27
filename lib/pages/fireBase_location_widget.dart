import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class FireBaseLocationWidget extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<FireBaseLocationWidget> {
  Position _position;

  @override
  void initState() {
    super.initState();
  }

 @override
Widget build(BuildContext context) {

  // this is a widget that works with futures?
  return StreamBuilder<QuerySnapshot>(
    // the stream/rx style this widget should observe
    stream: Firestore.instance.collection('consultants').snapshots(),

    // when an event is fired, call this method to build the ui based on the change event
    builder: (BuildContext context, 
              AsyncSnapshot<QuerySnapshot> snapshot) {

                // sometimes the callback get's called but the data isn't ready yet?
                if (!snapshot.hasData) 
                  return Text('loading ...');

      GeoPoint loc = snapshot.data.documents[0]['location'];

      // ok, the data is ready, build a column holding a single text box. with the data.
      return Column(children: <Widget>[
        Text(snapshot.data.documents[0]['name']),
        Text(snapshot.data.documents[0]['location'].latitude.toString()),
        Text(snapshot.data.documents[0]['location'].longitude.toString())
      ],
      );
    },
  );
}

}

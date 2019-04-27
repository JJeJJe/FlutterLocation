import 'package:flutter/material.dart';
import 'pages/fireBase_location_widget.dart';

import 'pages/calculate_distance_widget.dart';
import 'pages/current_location_widget.dart';
import 'pages/location_stream_widget.dart';
import 'pages/map_widget.dart';


// this is what kicks thing off for the app, like public void main() in c.  
void main() => runApp(Locatr());

enum TabItem { firebase, singleLocation, locationStream, distance, map }

class Locatr extends StatefulWidget {
  //@override
  State<Locatr> createState() => BottomNavigationState();
}

class BottomNavigationState extends State<Locatr> {
  TabItem _currentItem = TabItem.firebase;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Geolocator Example App'),
        ),
        body: _buildBody(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  // checks the state of the _currentItem and returns the widget
  Widget _buildBody() {
    switch (_currentItem) {

      case TabItem.firebase:
        return FireBaseLocationWidget();

      case TabItem.locationStream:
        return LocationStreamWidget();

      case TabItem.distance:
        return CalculateDistanceWidget();

      case TabItem.map:
        return MapWidget();

      case TabItem.singleLocation:

      default:
        return CurrentLocationWidget();
    }
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,

      // for each of the items in the bottom nav bar, we call the same method and pass in an
      // icon
      // enum for the widget that this nav bar item contains.
      items: <BottomNavigationBarItem>[
        _buildBottomNavigationBarItem(Icons.account_circle, TabItem.firebase),
        _buildBottomNavigationBarItem(Icons.location_on, TabItem.singleLocation),
        _buildBottomNavigationBarItem(Icons.clear_all, TabItem.locationStream),
        _buildBottomNavigationBarItem(Icons.redo, TabItem.distance),
        _buildBottomNavigationBarItem(Icons.access_alarm, TabItem.map)
      ],
      onTap: _onSelectTab,
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      IconData icon, TabItem tabItem) {

    final String text = tabItem.toString().split('.').last;
    final Color color =
        _currentItem == tabItem ? Theme.of(context).primaryColor : Colors.grey;

    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: color,
        ),
      ),
    );
  }

  void _onSelectTab(int index) {
    TabItem selectedTabItem;
  //return;
    switch (index) {
      case 0:
        selectedTabItem = TabItem.firebase;
        break;
      case 1:
        selectedTabItem = TabItem.singleLocation;
        break;
      case 2:
        selectedTabItem = TabItem.locationStream;
        break;
      case 3:
        selectedTabItem = TabItem.distance;
        break;
      case 4:
        selectedTabItem = TabItem.map;
        break;

      default:
        selectedTabItem = TabItem.singleLocation;
    }

    setState(() {
      _currentItem = selectedTabItem;
    });
  }
}

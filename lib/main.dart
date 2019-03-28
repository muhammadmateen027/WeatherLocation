import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'place_detail.dart';
import 'pages/Weather.dart';
import 'pages/History.dart';
import 'constants/utils.dart';


class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

void main() {
  runApp(MaterialApp(
    title: "Weather App",
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Weather List", Icons.cloud),
    new DrawerItem("Weather History", Icons.info)
  ];

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new WeatherFragment();
      case 1:
        return new ThirdFragment();
      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];

    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return Scaffold(
        
        drawer: new Drawer(
          child: new Column(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: const Color(0xFFff8b54),
                ),
                  accountName: new Text("Muhammad Mateen", style: TextStyle(fontWeight: FontWeight.bold),),
                   accountEmail: new Text("muhammadmateen027@post.umt.edu.pk")),
              new Column(children: drawerOptions)
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text("Current Location"),
          backgroundColor: const Color(0xFFff8b54),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                _handlePressButton();
              },
            ),
          ],
        ),
        body: _getDrawerItemWidget(_selectedDrawerIndex),
      );
  }


  Future<void> _handlePressButton() async {
    try {
      Prediction p = await PlacesAutocomplete.show(
          context: context,
          apiKey: kGoogleApiKey,
          mode: Mode.fullscreen,
          language: "en");

      showDetailPlace(p.placeId);
    } catch (e) {
      return;
    }
  }

  Future<Null> showDetailPlace(String placeId) async {
    if (placeId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PlaceDetailWidget(placeId)),
      );
    }
  }

}

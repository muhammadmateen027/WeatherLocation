import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

  BoxDecoration appBackground() {
    return new BoxDecoration(
      // Box decoration takes a gradient
      gradient: LinearGradient(
        // Where the linear gradient begins and ends
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        // Add one stop for each color. Stops should increase from 0 to 1
        // stops: [0.5, 0.8, 0.9, 0.3],
        stops: [0.6, 0.2, 1.0, 0.3],
        colors: [
          // Colors are easy thanks to Flutter's Colors class.
          const Color(0xFFe6e6e6),
          const Color(0xFFffa354),
          const Color(0xFFff8b54),
          const Color(0xFFff8b54),
        ],
      ),
    );
  }


  Drawer appDrawer(BuildContext context) {
    return Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the Drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Drawer Header', style: new TextStyle(color: Colors.white),),
                decoration: BoxDecoration(
                  color: const Color(0xFFff8b54),
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
  }
}

class AppName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 30.0),
          child: new Text(
            "Kolas Rail",
            style: new TextStyle(
              fontSize: 30.0,
            ),
          ),
        )
      ],
    );
  }
}

class StackedIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Stack(
              alignment: Alignment.center,
              children: <Widget>[
                new Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(50.0),
                    color: Color(0xFF18D191)
                  ),
                  child: new Icon(Icons.local_offer, color: Colors.white,),
                ),//local_offer
                
              
              ],
              
            );
  }

}


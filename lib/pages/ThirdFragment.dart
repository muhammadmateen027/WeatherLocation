import 'package:flutter/material.dart';
import '../api/networkcall.dart';

BoxDecoration appBackground() {
    return new BoxDecoration(
      // Box decoration takes a gradient
      gradient: LinearGradient(
        // Where the linear gradient begins and ends
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        // Add one stop for each color. Stops should increase from 0 to 1
        // stops: [0.5, 0.8, 0.9, 0.3],
        stops: [0.5, 0.2, 5.0, 0.3],
        colors: [
          // Colors are easy thanks to Flutter's Colors class.
          const Color(0xFF669999),
          const Color(0xFF669999),
          const Color(0xFF006666),
          const Color(0xFF003333),
        ],
      ),
    );
  }

class ThirdFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: appBackground(),
      child: MyHomePage(),
      );
  }

}

class MyHomePage extends StatefulWidget {
 @override
 _MyHomePageState createState() {
   return _MyHomePageState();
 }
}

class _MyHomePageState extends State<MyHomePage> {

 @override
 Widget build(BuildContext context) {
   return Container(
     child: FutureBuilder(
       future: fetchPost(),
       builder: (context, snapshot) {
        //  print(snapshot.toString());
         return Container();
       }
     ),
   );
 }

}


// https://www.youtube.com/watch?v=DqJ_KjFzL9I
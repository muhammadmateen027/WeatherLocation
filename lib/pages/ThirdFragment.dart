import 'package:flutter/material.dart';
import '../api/networkcall.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/weatherData.dart';
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
  List<WeatherData> list = List();
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
     _fetchData();
    return Container();
    //   child: FutureBuilder(
    //   future: _fetchData(),
    //   builder: (context, snapshot) {
    //     return ListView.builder(
    //         itemCount: list.length,
    //         itemBuilder: (BuildContext context, int index) {
    //           // print('====>>>>  ' + list[0].city);
    //           // return Container();
    //           return ListTile(
    //             contentPadding: EdgeInsets.all(10.0),
    //             title: new Text(list[index].city),
    //           );
    //         });
    //   },
    // ));
  }

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response = await http
        .get("https://weatherapp-97622.firebaseapp.com/api/v1/weather");
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new WeatherData.fromJson(data))
          .toList();
      // setState(() {
      //   isLoading = false;
      // });
    } else {
      throw Exception('Failed to load photos');
    }
  }
}

// https://www.youtube.com/watch?v=DqJ_KjFzL9I

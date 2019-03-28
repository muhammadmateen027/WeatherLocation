import 'package:flutter/material.dart';
import '../api/networkcall.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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


class WeatherLogs {
  final String action;
  final String timeStamp;

  WeatherLogs._({this.action, this.timeStamp});

  factory WeatherLogs.fromJson(Map<String, dynamic> json) {
    return new WeatherLogs._(
      action: json['action'],
      timeStamp: json['timeStamp'] as String,
    );
  }
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
  List<WeatherLogs> list = List();
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
     _fetchData();
    return Container(
      child: FutureBuilder(
      future: _fetchData(),
      builder: (context, snapshot) {
        return ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              // print('====>>>>  ' + list[0].city);
              // return Container();
              return getCard(context, list[index]);
            });
      },
    ));
  }

  Card getCard(BuildContext context, WeatherLogs log) {
    // var date = new DateTime.fromMillisecondsSinceEpoch(log.timeStamp.floor() * 1000);

    // print(date);

    return new Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white70),
        child: ListTile(
                contentPadding: EdgeInsets.all(10.0),
                title: new Text(log.action, style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: new Text(log.timeStamp),
              ),
      ),
    );
  }

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response = await http
        .get("https://weatherapp-97622.firebaseapp.com/api/v1/weatherlogs");
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new WeatherLogs.fromJson(data))
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

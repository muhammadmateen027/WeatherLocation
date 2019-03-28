import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/utils.dart';

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
              return getCard(context, list[index]);
            });
      },
    ));
  }

  Card getCard(BuildContext context, WeatherLogs log) {
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
        .get(WEATHER_URL+"/weatherlogs");
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new WeatherLogs.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }
}

// https://www.youtube.com/watch?v=DqJ_KjFzL9I

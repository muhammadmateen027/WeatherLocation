import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/weather.dart';
import 'dart:io';



const weather_api_key = "5eb149801bb9c8508d7c6a3df7df6aa6";

class ListFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      return new WeatherPageContent();
  }

}

class WeatherPageContent extends StatefulWidget {
  createState() => WeatherState();
}

class WeatherState extends State<WeatherPageContent> {
  
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Center(
          child: FutureBuilder<Weather>(
            future: fetchPost(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.name);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner
              return CircularProgressIndicator();
            },
          ),
        );
  }

}

Future<Weather> fetchPost() async {
  final response =
      await http.get('http://api.openweathermap.org/data/2.5/weather?q=Lahore&units=metric&appid='+weather_api_key);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Weather.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/CustomWeather.dart';
import '../place_detail.dart';
import '../constants/utils.dart';

class WeatherFragment extends StatelessWidget {
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
  List<CustomWeather> weatherList = List();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        decoration: appBackground(),
        child: FutureBuilder(
          future: fetchFromFireBase(),
          builder: (context, snapshot) {
            return ListView.builder(
                itemCount: weatherList.length,
                itemBuilder: (BuildContext context, int index) {

                  return Dismissible(
                    key: Key(weatherList[index].placeId),
                    direction: DismissDirection.horizontal,
                    onDismissed: (DismissDirection direction) {
                      new Container(
                        child: FutureBuilder(
                          future: removeFromFireBase(
                              weatherList[index].placeId.toString()),
                          builder: (context, snapshot) {
                            String hello = "Here is error";
                            if (snapshot.hasData) {
                              hello = snapshot.data.toString();
                            }
                            final snackBar = SnackBar(content: Text(hello));
                            Scaffold.of(context).showSnackBar(snackBar);
                          },
                        ),
                      );
                      // String result = removeFromFireBase(weatherList[index].placeId.toString());

                      weatherList.removeAt(index);
                    },
                    child: getCard(context, weatherList[index]),
                    background: Container(
                        color: Colors.red[200],
                        child: new Icon(
                          Icons.delete_forever,
                          color: Colors.white,
                          size: 50.0,
                        )),
                  );
                });
          },
        ));
  }

  Future<CustomWeather> fetchFromFireBase() async {
    final response = await http
        .get(WEATHER_URL+'/weather');

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      weatherList = (json.decode(response.body) as List)
          .map((data) => new CustomWeather.fromJson(data))
          .toList();
      return CustomWeather.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}

Future<String> removeFromFireBase(String placeId) async {
  final response = await http.delete(WEATHER_URL+'/weather/' + placeId);

  if (response.statusCode == 200) {
    var logs = new Map<String, dynamic>();
    logs["action"] = "Deleted";
    createLogs(body: logs);
    return response.body;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

Card getCard(BuildContext context, CustomWeather weather) {
  return new Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(color: Color(0xFF006666)),
      child: getTile(context, weather),
    ),
  );
}

ListTile getTile(BuildContext context, CustomWeather weather) {
  return new ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    title: Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          weather.city + ', ' + weather.country,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
      ]),
    ),
    // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
          child: Text(
            'Temperature: ' + weather.temp + ' C',
            style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                "Humidity: ",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
            ),
            Container(
              child: Text(
                weather.humidity + ' %',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                "Pressure: ",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
            ),
            Container(
              child: Text(
                weather.pressure + ' %',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    ),

    onTap: () => _onLoginTapped(context, weather.placeId),
  );
}

void _onLoginTapped(BuildContext context, String placeId) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => new PlaceDetailWidget(placeId),
      ));
}

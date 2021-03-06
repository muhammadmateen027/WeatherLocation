import 'package:google_maps_webservice/places.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'pages/models/weather.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants/utils.dart';



GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
String plceDetailId;

class PlaceDetailWidget extends StatefulWidget {
  String placeId;

  PlaceDetailWidget(String placeId) {
    this.placeId = placeId;
    if (placeId != null) plceDetailId = placeId.toString();
  }

  @override
  State<StatefulWidget> createState() {
    return PlaceDetailState();
  }
}

class PlaceDetailState extends State<PlaceDetailWidget> {
  GoogleMapController mapController;
  PlacesDetailsResponse place;
  bool isLoading = false;
  String errorLoading;

  @override
  void initState() {
    if (plceDetailId != null)
      fetchPlaceDetail(plceDetailId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyChild;
    String title;
    if (isLoading) {
      title = "Loading";
      bodyChild = Center(
        child: CircularProgressIndicator(
          value: null,
        ),
      );
    } else if (errorLoading != null) {
      title = "";
      bodyChild = Center(
        child: Text(errorLoading),
      );
    } else {
      if (place != null) {
        final placeDetail = place.result;

      title = placeDetail.name;
      bodyChild = new Container(
        decoration: appBackground(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(              
              child: locationInfo(placeDetail.name),
            )
          ],
        ),
        
      );
    }
      }
      

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: const Color(0xFF004d4d),
        ),
        body: bodyChild);
  }

  void fetchPlaceDetail(String placeId) async {
    setState(() {
      this.isLoading = true;
      this.errorLoading = null;
    });

    PlacesDetailsResponse place =
        await _places.getDetailsByPlaceId(placeId);

    if (mounted) {
      setState(() {
        this.isLoading = false;
        if (place.status == "OK") {
          this.place = place;
        } else {
          this.errorLoading = place.errorMessage;
        }
      });
    }
  }


  Container locationInfo(String cityName) {
    List<Widget> weatherList = [];
    return Container(
      child: FutureBuilder<Weather>(
        future: fetchPost(cityName.toString()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var map = new Map<String, dynamic>();
            map["city"] = snapshot.data.name;
            map["country"] = snapshot.data.sys.country;
            map["placeId"] = plceDetailId.toString();
            map["temp"] = snapshot.data.main.temp.toString();
            map["pressure"] = snapshot.data.main.pressure.toString();
            map["humidity"] = snapshot.data.main.humidity.toString();
            map["minTemp"] = snapshot.data.main.tempMin.toString();
            map["maxTemp"] = snapshot.data.main.tempMax.toString();
            map["timeStamp"] =
                new DateTime.now().millisecondsSinceEpoch.toString();

           

            if (snapshot.data.name != null &&
                snapshot.data.sys.country != null) {
              // For name
              weatherList.add(
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 0.0, left: 4.0, right: 8.0, bottom: 4.0),
                    child: Text(
                        snapshot.data.name + ', ' + snapshot.data.sys.country,
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0)),
                  ),
                ),
              );
            }

            if (snapshot.data.main.temp != null) {
              weatherList.add(
                Padding(
                  padding: EdgeInsets.only(
                      top: 4.0, left: 8.0, right: 8.0, bottom: 4.0),
                  child: new Row(
                    children: <Widget>[
                      Text("Temperature: ",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0)),
                      Text(snapshot.data.main.temp.toString() + " C",
                          style: new TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18.0))
                    ],
                  ),
                ),
              );
            }

            if (snapshot.data.main.pressure != null) {
              weatherList.add(
                Padding(
                  padding: EdgeInsets.only(
                      top: 4.0, left: 8.0, right: 8.0, bottom: 4.0),
                  child: new Row(
                    children: <Widget>[
                      Text("Pressure: ",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0)),
                      Text(snapshot.data.main.pressure.toString() + "%",
                          style: new TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16.0))
                    ],
                  ),
                ),
              );
            }

            if (snapshot.data.main.humidity != null) {
              weatherList.add(
                Padding(
                  padding: EdgeInsets.only(
                      top: 4.0, left: 8.0, right: 8.0, bottom: 4.0),
                  child: new Row(
                    children: <Widget>[
                      Text("Humidity: ",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0)),
                      Text(snapshot.data.main.humidity.toString() + "%",
                          style: new TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16.0))
                    ],
                  ),
                ),
              );
            }

            if (snapshot.data.main.tempMin != null) {
              weatherList.add(
                Padding(
                  padding: EdgeInsets.only(
                      top: 4.0, left: 8.0, right: 8.0, bottom: 4.0),
                  child: new Row(
                    children: <Widget>[
                      Text("Min Temp: ",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0)),
                      Text(snapshot.data.main.tempMin.toString() + " C",
                          style: new TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16.0))
                    ],
                  ),
                ),
              );
            }

            if (snapshot.data.main.tempMax != null) {
              weatherList.add(
                Padding(
                  padding: EdgeInsets.only(
                      top: 4.0, left: 8.0, right: 8.0, bottom: 4.0),
                  child: new Row(
                    children: <Widget>[
                      Text("Max Temp: ",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0)),
                      Text(snapshot.data.main.tempMax.toString() + " C",
                          style: new TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16.0))
                    ],
                  ),
                ),
              );
            }

            
            createPost(body: map);
            var logs = new Map<String, dynamic>();
            logs["action"] = "Created";
            createLogs(body: logs);

            return ListView(
              shrinkWrap: true,
              children: weatherList,
            );
            // return Text(snapshot.data.name);
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

Future<Weather> fetchPost(String cityName) async {
  final response = await http.get(
      'http://api.openweathermap.org/data/2.5/weather?q=' +
          cityName +
          '&units=metric&appid=' +
          weather_api_key);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Weather.fromJson(json.decode(response.body.toString()));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('WeatherAPI Failed to load post');
  }
}

void createPost({Map body}) async {
  String url = WEATHER_URL+'/weather';
  final response = await http.post(url, body: body);
  if (response.statusCode < 200 || response.statusCode > 400 || json == null) {
    throw new Exception("Error while fetching data");
  }
}

void createLogs({Map body}) async {
  String url = WEATHER_URL+'/weatherlogs';
  final response = await http.post(url, body: body);
  if (response.statusCode < 200 || response.statusCode > 400 || json == null) {
    throw new Exception("Error while fetching data");
  } 
}

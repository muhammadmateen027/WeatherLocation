import '../pages/models/weather.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const url = 'https://weatherapp-97622.firebaseapp.com/api/v1/weather';

Future<Weather> fetchPost() async {
  final response =
      await http.get(url);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);
    return Weather.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

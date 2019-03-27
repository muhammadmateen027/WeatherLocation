// // https://app.quicktype.io/
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../pages/models/CustomWeather.dart';

// class NetworkCalls {
//   String url = 'https://weatherapp-97622.firebaseapp.com/api/v1/weather';
//   Future<CustomWeather> fetchFromFireBase() async {
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       // If the call to the server was successful, parse the JSON
//       print(response.body);
//       return CustomWeather.fromJson(json.decode(response.body));
//     } else {
//       // If that call was not successful, throw an error.
//       throw Exception('Failed to load post');
//     }
//   }
// }

// // Future<List> fetchData() async {
// //   List<WeatherData> list;
// //     final response = await http
// //         .get("https://weatherapp-97622.firebaseapp.com/api/v1/weather");
// //     if (response.statusCode == 200) {
// //       list = (json.decode(response.body) as List)
// //           .map((data) => new WeatherData.fromJson(data))
// //           .toList();
// //       // setState(() {
// //       //   isLoading = false;
// //       // });
// //     } else {
// //       throw Exception('Failed to load photos');
// //     }

// //     return list;
// //   }

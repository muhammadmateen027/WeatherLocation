// To parse this JSON data, do
//
//     final customWeather = customWeatherFromJson(jsonString);

import 'dart:convert';

List<CustomWeather> customWeatherFromJson(String str) {
    final jsonData = json.decode(str);
    return new List<CustomWeather>.from(jsonData.map((x) => CustomWeather.fromJson(x)));
}

String customWeatherToJson(List<CustomWeather> data) {
    final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
    return json.encode(dyn);
}

class CustomWeather {
    String pressure;
    String maxTemp;
    String placeId;
    String timeStamp;
    String humidity;
    String temp;
    String city;
    String minTemp;
    String country;

    CustomWeather({
        this.pressure,
        this.maxTemp,
        this.placeId,
        this.timeStamp,
        this.humidity,
        this.temp,
        this.city,
        this.minTemp,
        this.country,
    });

    factory CustomWeather.fromJson(Map<String, dynamic> json) => new CustomWeather(
        pressure: json["pressure"],
        maxTemp: json["maxTemp"],
        placeId: json["placeId"],
        timeStamp: json["timeStamp"],
        humidity: json["humidity"],
        temp: json["temp"],
        city: json["city"],
        minTemp: json["minTemp"],
        country: json["country"],
    );

    Map<String, dynamic> toJson() => {
        "pressure": pressure,
        "maxTemp": maxTemp,
        "placeId": placeId,
        "timeStamp": timeStamp,
        "humidity": humidity,
        "temp": temp,
        "city": city,
        "minTemp": minTemp,
        "country": country,
    };
}

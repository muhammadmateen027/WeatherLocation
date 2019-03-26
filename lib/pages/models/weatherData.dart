class WeatherData {
  final String city;

  WeatherData._({this.city});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return new WeatherData._(
      city: json['city'],
    );
  }
}
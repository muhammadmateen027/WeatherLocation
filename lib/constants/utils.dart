import 'package:flutter/material.dart';

const weather_api_key = "5eb149801bb9c8508d7c6a3df7df6aa6";
const kGoogleApiKey = "AIzaSyBZoeylp_uRm0JhnYQAHz1Q81u3MOwf8JY";

const String WEATHER_URL = 'https://weatherapp-97622.firebaseapp.com/api/v1';


BoxDecoration appBackground() {
    return new BoxDecoration(
      // Box decoration takes a gradient
      gradient: LinearGradient(
        // Where the linear gradient begins and ends
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        // Add one stop for each color. Stops should increase from 0 to 1
        // stops: [0.5, 0.8, 0.9, 0.3],
        stops: [0.6, 0.2, 1.0, 0.3],
        colors: [
          // Colors are easy thanks to Flutter's Colors class.
          const Color(0xFFe6e6e6),
          const Color(0xFFffa354),
          const Color(0xFFff8b54),
          const Color(0xFFff8b54),
        ],
      ),
    );
  }

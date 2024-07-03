// lib/providers/weather_provider.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class WeatherProvider with ChangeNotifier {
  double temperature = 0;
  int humidity = 0;
  double windSpeed = 0;
  int visibility = 0;
  String description = "";
  String cityName = "Jakarta";
  List<dynamic> forecast = [];
  String currentDateTime = "";

  Future<void> fetchWeather(String city) async {
    final weatherUrl = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=46df8f0637c1c43a97eb4e956d30b918&units=metric';
    final forecastUrl = 'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=46df8f0637c1c43a97eb4e956d30b918&units=metric';
    try {
      final weatherResponse = await http.get(Uri.parse(weatherUrl));
      final weatherData = json.decode(weatherResponse.body);
      temperature = weatherData['main']['temp'];
      humidity = weatherData['main']['humidity'];
      windSpeed = weatherData['wind']['speed'];
      visibility = weatherData['visibility'] ~/ 1000;
      description = weatherData['weather'][0]['description'];
      cityName = city;

      final forecastResponse = await http.get(Uri.parse(forecastUrl));
      final forecastData = json.decode(forecastResponse.body);
      forecast = forecastData['list'].take(5).toList(); // Taking forecast for the next 5 time periods

      updateCurrentDateTime();

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  void updateCurrentDateTime() {
    DateTime now = DateTime.now();
    String formattedDateTime = DateFormat('EEEE, d MMMM yyyy, HH:mm').format(now);
    currentDateTime = formattedDateTime;
  }
}




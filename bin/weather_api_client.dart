import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'weather.dart';

class WeatherApiException implements Exception {
  const WeatherApiException(this.message);
  final String message;

  @override
  String toString() => message;
}

class WeatherApiClient {
  static const baseUrl = 'https://api.openweathermap.org';

  void fetchWeather(String city) {
    Map<String, Object?> consolidatedWeather = {};
    final weatherUrl = Uri.parse(
        '$baseUrl/data/2.5/weather?q=$city&APPID=3217817010b704d96500b04e78f97f7b&units=metric');
    http.get(weatherUrl).then((weatherResponse) {
      if (weatherResponse.statusCode != 200) {
        throw WeatherApiException('Error getting weather for location: $city');
      }
      final weatherJson = jsonDecode(weatherResponse.body);
      consolidatedWeather = weatherJson['main'] as Map<String, Object?>;
      if (consolidatedWeather.isEmpty) {
        throw WeatherApiException(
            'Weather data not available for locationId: $city');
      }
      print(Weather.fromJson(consolidatedWeather));
    }).onError<WeatherApiException>((error, stack) {
      print(error);
    }).onError<SocketException>((error, stackTrace) {
      print('Could not fetch data. Check your connection.');
    });
  }
}

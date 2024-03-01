import 'weather_api_client.dart';

void main(List<String> arguments) {
  // Syntax: dart bin/main.dart London
  late final String city;
  if (arguments.length != 1) {
    city = 'London';
  } else {
    city = arguments.first;
  }
  final api = WeatherApiClient();
  api.fetchWeather(city);
}

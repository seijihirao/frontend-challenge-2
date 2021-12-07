import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend_challenge_2/src/models/weather.dart';
import 'package:http/http.dart' as http;

class OpenWeatherService {
  /// Base URL used for requests
  static const String baseUrl = 'api.openweathermap.org';

  /// Searches for all places with similar [city] on google places
  static Future<Weather?> getCurrent(String city) async {
    var params = {
      'q': city,
      'appid': dotenv.env['OPENWEATHER_API_KEY'],
      'units': 'metric'
    };
    var response = await http.get(
        Uri.https(baseUrl, '/data/2.5/weather', params),
        headers: {'Accept': 'application/json'});
    var weather = json.decode(response.body);

    if (weather['weather'].length == 0) {
      return null;
    }

    WeatherCondition condition = WeatherCondition(
        weather['main']['temp'],
        weather['main']['feels_like'],
        weather['main']['temp_min'],
        weather['main']['temp_max'],
        weather['main']['pressure'],
        weather['main']['humidity']);
    return Weather(
        weather["id"], city, weather['weather'][0]['main'], condition);
  }
}

import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend_challenge_2/src/models/weather.dart';
import 'package:http/http.dart' as http;

class OpenWeatherService {
  /// Base URL used for requests
  static const String baseUrl = 'api.openweathermap.org';

  /// Searches current weather of [city] on openweather
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

    if (weather['cod'] == 404) {
      return null;
    }

    WeatherCondition condition = WeatherCondition(
        weather['weather'][0]['description'],
        weather['weather'][0]['icon'],
        weather['main']['temp'],
        weather['main']['feels_like'],
        weather['main']['temp_min'],
        weather['main']['temp_max'],
        weather['main']['pressure'],
        weather['main']['humidity']);
    return Weather(weather["id"], city, [condition]);
  }

  /// Searches weeks weather of city by [id] on openweather
  static Future<Weather?> getWeek(Weather weather) async {
    var params = {
      'id': weather.id.toString(),
      'appid': dotenv.env['OPENWEATHER_API_KEY'],
      'units': 'metric',
      'cnt': "7"
    };
    var response = await http.get(
        Uri.https(baseUrl, '/data/2.5/forecast/daily', params),
        headers: {'Accept': 'application/json'});
    var weatherResponse = json.decode(response.body);

    if (weatherResponse['cod'] == 404) {
      return null;
    }

    List<WeatherCondition> conditions = weatherResponse['list']
        .map((w) => WeatherCondition(
              w['weather'][0]['description'],
              w['weather'][0]['icon'],
              double.parse(w['temp']['day'].toString()),
              double.parse(w['feels_like']['day'].toString()),
              double.parse(w['temp']['min'].toString()),
              double.parse(w['temp']['max'].toString()),
              w['pressure'],
              w['humidity'],
            ))
        .toList()
        ?.cast<WeatherCondition>();

    weather.conditions = conditions;
    return weather;
  }
}

import 'package:flutter/material.dart';
import 'package:frontend_challenge_2/src/apis/openweather.dart';
import 'package:frontend_challenge_2/src/models/weather.dart';

class WeatherProvider with ChangeNotifier {
  final Map<int, Weather> _weathers = {};

  Map<int, Weather> get weathers => _weathers;

  Future addCity(String city) async {
    Weather? weather = await OpenWeatherService.getCurrent(city);
    if (weather == null) {
      // TODO: create toast
      return;
    }
    if (_weathers.containsKey(weather.id)) {
      // TODO: create toast
      return;
    }
    _weathers.addAll({weather.id: weather});
    notifyListeners();
  }

  Future updateWeather(Weather weather) async {
    Weather? newWeather = await OpenWeatherService.getWeek(weather);
    if (newWeather == null) {
      // TODO: create toast
      return;
    }
    _weathers.update(newWeather.id, (_) => newWeather);
    notifyListeners();
  }

  void removeCity(Weather weather) {
    _weathers.remove(weather.id);
    notifyListeners();
  }
}

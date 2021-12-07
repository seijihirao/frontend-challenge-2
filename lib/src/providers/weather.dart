import 'package:flutter/material.dart';
import 'package:frontend_challenge_2/src/apis/openweather.dart';
import 'package:frontend_challenge_2/src/models/weather.dart';

class WeatherProvider with ChangeNotifier {
  final List<Weather> _weathers = [];

  List<Weather> get weathers => _weathers;

  Future addCity(String city) async {
    Weather? weather = await OpenWeatherService.getCurrent(city);
    if (weather == null) {
      // TODO: create toast
      return;
    }
    if (weathers.contains(weather)) {
      // TODO: create toast
      return;
    }
    weathers.add(weather);
    notifyListeners();
  }

  void removeCity(Weather city) {
    _weathers.remove(city);
    notifyListeners();
  }
}

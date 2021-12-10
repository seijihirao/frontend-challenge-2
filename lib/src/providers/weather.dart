import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend_challenge_2/src/apis/openweather.dart';
import 'package:frontend_challenge_2/src/models/weather.dart';

class WeatherProvider with ChangeNotifier {
  final Map<int, Weather> _weathers = {};

  Map<int, Weather> get weathers => _weathers;

  Future addCity(String city) async {
    Weather? weather = await OpenWeatherService.getCurrent(city);
    if (weather == null) {
      Fluttertoast.showToast(
        msg: "Location has no weather data :(",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }
    if (_weathers.containsKey(weather.id)) {
      Fluttertoast.showToast(
        msg: "Location already added",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      return;
    }
    _weathers.addAll({weather.id: weather});
    notifyListeners();
  }

  Future updateWeather(Weather weather) async {
    Weather? newWeather = await OpenWeatherService.getWeek(weather);
    if (newWeather == null) {
      Fluttertoast.showToast(
        msg: "Location has no weather data :(",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
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

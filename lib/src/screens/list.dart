import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:frontend_challenge_2/src/models/weather.dart';
import 'package:frontend_challenge_2/src/providers/weather.dart';
import 'package:frontend_challenge_2/src/widgets/city_autocomplete.dart';
import 'package:provider/provider.dart';

class ScreenWeatherList extends StatelessWidget {
  const ScreenWeatherList({Key? key}) : super(key: key);

  /// Text style to be used on cities list
  static const TextStyle listTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
    shadows: [
      Shadow(
        offset: Offset(0, 6),
        blurRadius: 20.0,
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Banco de Climas'),
          ),
          backgroundColor: const Color(0xFFE5E5E5),
          body: Column(
            children: [
              const Flexible(child: CityAutoComplete()),
              Expanded(
                flex: 10,
                child: ListView(
                  children: weatherProvider.weathers
                      .map(
                        (Weather weather) => Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) =>
                                    weatherProvider.removeCity(weather),
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Remove',
                              ),
                            ],
                          ),
                          child: Container(
                            height: 100,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    _getColorFromTemperature(
                                        weather.condition.temperatureMax),
                                    _getColorFromTemperature(
                                        weather.condition.temperatureMin),
                                  ]),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    weather.city.split(",")[0],
                                    style: listTextStyle,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    weather.condition.temperature.toString() +
                                        "°C",
                                    style: listTextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Gets day color from [temp]
  Color _getColorFromTemperature(double temp) {
    int r = _getGradient([
      [0.0, 255.0],
      [20.0, 135.0],
      [27.0, 135.0],
      [32.0, 255.0],
      [40.0, 255.0]
    ], temp);
    int g = _getGradient([
      [00.0, 255.0],
      [20.0, 206.0],
      [27.0, 206.0],
      [32.0, 102.0],
      [40.0, 10.0]
    ], temp);
    int b = _getGradient([
      [00.0, 255.0],
      [20.0, 235.0],
      [27.0, 235.0],
      [32.0, 7.0],
      [40.0, 0.0]
    ], temp);
    return Color.fromARGB(255, r, g, b);
  }

  /// Gradient function
  int _getGradient(List<List<double>> steps, double value) {
    double a = 0;
    double b = 0;
    for (int i = 0; i < steps.length; i++) {
      if (steps[i][0] > value) {
        if (i == 0) {
          return steps[i][1].toInt();
        }
        List<double> step1 = steps[i - 1];
        List<double> step2 = steps[i];

        a = (step2[1] - step1[1]) / (step2[0] - step1[0]);
        b = step1[1];
        break;
      }
    }
    return (value * a + b).toInt();
  }
}

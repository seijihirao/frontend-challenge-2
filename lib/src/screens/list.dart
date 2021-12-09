import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:frontend_challenge_2/src/models/weather.dart';
import 'package:frontend_challenge_2/src/providers/weather.dart';
import 'package:frontend_challenge_2/src/screens/week.dart';
import 'package:frontend_challenge_2/src/utils/day_color.dart';
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
                  children: weatherProvider.weathers.values
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
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                ScreenWeatherWeek.route,
                                arguments: ScreenWeatherWeekArguments(
                                  weather.id,
                                ),
                              );
                            },
                            child: Container(
                              height: 100,
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      DayColor.fromTemperature(
                                          weather.conditions[0].temperatureMax),
                                      DayColor.fromTemperature(
                                          weather.conditions[0].temperatureMin),
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
                                      weather.conditions[0].temperature
                                              .toString() +
                                          "°C",
                                      style: listTextStyle,
                                    ),
                                  ),
                                ],
                              ),
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
}

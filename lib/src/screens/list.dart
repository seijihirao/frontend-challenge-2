import 'package:flutter/material.dart';
import 'package:frontend_challenge_2/src/models/weather.dart';
import 'package:frontend_challenge_2/src/providers/weather.dart';
import 'package:frontend_challenge_2/src/widgets/city_autocomplete.dart';
import 'package:frontend_challenge_2/src/widgets/weather_block.dart';
import 'package:provider/provider.dart';

/// Screen to list all weathers by city
class ScreenWeatherList extends StatelessWidget {
  const ScreenWeatherList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Diesel Challenge",
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: const Color(0xFFE5E5E5),
          body: Column(
            children: [
              const SizedBox(
                height: 80,
                width: 500,
                child: CityAutoComplete(),
              ),
              Flexible(
                flex: 10,
                child: ListView(
                  children: weatherProvider.weathers.values
                      .map((Weather weather) => WeatherBlock(
                          weather: weather, provider: weatherProvider))
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

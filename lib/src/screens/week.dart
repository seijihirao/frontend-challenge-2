import 'package:flutter/material.dart';
import 'package:frontend_challenge_2/src/models/weather.dart';
import 'package:frontend_challenge_2/src/providers/weather.dart';
import 'package:frontend_challenge_2/src/utils/day_color.dart';
import 'package:frontend_challenge_2/src/widgets/weather_condition.dart';
import 'package:provider/provider.dart';

/// Screen to list all week data from city
class ScreenWeatherWeek extends StatelessWidget {
  const ScreenWeatherWeek({Key? key}) : super(key: key);

  static const route = "/week";

  static const daysOfWeek = ['dom', 'seg', 'ter', 'qua', 'qui', 'sex', 'sab'];

  static const cloudImage =
      'https://www.pikpng.com/pngl/b/111-1113255_free-png-download-white-cloud-png-png-images.png';

  /// Text style to be used on cities list
  TextStyle listTextStyle({fontSize = 20.0}) => TextStyle(
        color: Colors.white,
        fontSize: fontSize,
        shadows: const [
          Shadow(
            offset: Offset(0, 6),
            blurRadius: 20.0,
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as ScreenWeatherWeekArguments;
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, child) {
        Weather? weather = weatherProvider.weathers[args.id];
        weatherProvider.updateWeather(weather!);
        weather = weatherProvider.weathers[args.id];
        return Hero(
          tag: weather!.id,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                "Diesel Challenge",
                style: TextStyle(color: Colors.white),
              ),
            ),
            backgroundColor:
                DayColor.fromTemperature(weather.conditions[0].temperature),
            body: Stack(
              children: [
                const Positioned(
                  left: -300,
                  top: -50,
                  child: Image(
                    width: 400,
                    image: NetworkImage(cloudImage),
                  ),
                ),
                const Positioned(
                  right: -250,
                  top: 50,
                  child: Image(
                    width: 400,
                    image: NetworkImage(cloudImage),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 80.0),
                      child: SizedBox(
                        height: 80,
                        child: Text(
                          weather.city.split(",").getRange(0, 2).join("\n"),
                          textAlign: TextAlign.center,
                          style: listTextStyle(fontSize: 30.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      child: Text(
                        weather.conditions[0].temperature.toInt().toString() +
                            "°C",
                        style: listTextStyle(fontSize: 40.0),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50.0, right: 30),
                        child: ListView(
                            children: weather.conditions
                                .asMap()
                                .entries
                                .map((condition) => WeatherConditionListItem(
                                      condition: condition.value,
                                      weekDay: daysOfWeek[(condition.key +
                                              DateTime.now().weekday) %
                                          7],
                                    ))
                                .toList()),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ScreenWeatherWeekArguments {
  final int id;

  ScreenWeatherWeekArguments(this.id);
}

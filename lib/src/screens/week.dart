import 'package:flutter/material.dart';
import 'package:frontend_challenge_2/src/models/weather.dart';
import 'package:frontend_challenge_2/src/providers/weather.dart';
import 'package:frontend_challenge_2/src/utils/day_color.dart';
import 'package:provider/provider.dart';

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
        return Scaffold(
          appBar: AppBar(
            title: const Text('Essa semana'),
          ),
          backgroundColor:
              DayColor.fromTemperature(weather!.conditions[0].temperature),
          body: Stack(
            children: [
              const Positioned(
                left: -300,
                child: Image(
                  width: 400,
                  image: NetworkImage(cloudImage),
                ),
              ),
              const Positioned(
                left: 250,
                top: 100,
                child: Image(
                  width: 400,
                  image: NetworkImage(cloudImage),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      weather.city.split(",").getRange(0, 2).join("\n"),
                      textAlign: TextAlign.center,
                      style: listTextStyle(fontSize: 30.0),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  Center(
                    child: Text(
                      weather.conditions[0].temperature.toInt().toString() +
                          "°C",
                      style: listTextStyle(fontSize: 40.0),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Center(
                      child: Column(
                          children: weather.conditions
                              .asMap()
                              .entries
                              .map(
                                (condition) => Container(
                                  height: 40.0,
                                  child: Row(
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: Image(
                                          image: NetworkImage(
                                              'http://openweathermap.org/img/wn/${condition.value.icon}.png'),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(10.0),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          daysOfWeek[(condition.key +
                                                  DateTime.now().weekday) %
                                              7],
                                          style: listTextStyle(),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          condition.value.temperature
                                                  .toInt()
                                                  .toString() +
                                              "°C",
                                          style: listTextStyle(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList()),
                    ),
                  ),
                ],
              ),
            ],
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

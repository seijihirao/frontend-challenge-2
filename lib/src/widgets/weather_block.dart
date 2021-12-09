import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:frontend_challenge_2/src/models/weather.dart';
import 'package:frontend_challenge_2/src/providers/weather.dart';
import 'package:frontend_challenge_2/src/screens/week.dart';
import 'package:frontend_challenge_2/src/utils/day_color.dart';

class WeatherBlock extends StatelessWidget {
  final Weather? weather;
  final WeatherProvider? provider;

  const WeatherBlock({Key? key, this.weather, this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: weather!.id,
      child: Card(
        color:
            DayColor.fromTemperature(weather?.conditions[0].temperature ?? 0),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) => provider!.removeCity(weather!),
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
                  weather?.id ?? 0,
                ),
              );
            },
            child: InkWell(
              splashColor: Colors.white.withAlpha(30),
              child: ListTile(
                leading: Image(
                  image: NetworkImage(weather?.conditions[0].icon ?? ""),
                ),
                title: Text(
                  weather?.city.split(",")[0] ?? "",
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  (weather?.conditions[0].temperature.toString() ?? "") + "°C",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

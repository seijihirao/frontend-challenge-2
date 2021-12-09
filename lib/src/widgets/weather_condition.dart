import 'package:flutter/material.dart';
import 'package:frontend_challenge_2/src/models/weather.dart';

/// List item showing [condition.icon], [weekDay] and [condition.temperature]
class WeatherConditionListItem extends StatelessWidget {
  final WeatherCondition? condition;
  final String? weekDay;

  const WeatherConditionListItem({Key? key, this.condition, this.weekDay})
      : super(key: key);

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
    return SizedBox(
      height: 40.0,
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Image(
              image: NetworkImage(condition?.icon ?? ""),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
          ),
          Expanded(
            flex: 3,
            child: Text(
              weekDay!,
              style: listTextStyle(),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              (condition?.temperature.toInt().toString() ?? "?") + "°C",
              style: listTextStyle(),
            ),
          ),
        ],
      ),
    );
  }
}

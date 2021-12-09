import 'package:flutter/material.dart';

class DayColor {
  /// Gets day color from [temp]
  static Color fromTemperature(double temp) {
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
  static int _getGradient(List<List<double>> steps, double value) {
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

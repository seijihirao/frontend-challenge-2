import 'package:flutter/material.dart';
import 'package:frontend_challenge_2/src/screens/list.dart';
import 'package:frontend_challenge_2/src/screens/week.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ScreenWeatherList(),
        '/week': (context) => const ScreenWeatherWeek(),
      }
    );
  }
}